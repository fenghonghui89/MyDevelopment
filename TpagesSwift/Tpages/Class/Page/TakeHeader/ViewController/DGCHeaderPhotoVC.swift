//
//  DGCHeaderPhotoVC.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/20.
//  Copyright © 2016年 DGC. All rights reserved.
//

import UIKit
import AVFoundation
import ImageIO

enum DGCTakePhotoStateType {
  case Stop,Photo,Alubm
}

class DGCHeaderPhotoVC: UIViewController,VPImageCropperDelegate {

  //publish
  let rootVC:UIViewController? = nil
  var type:DGCTakePhotoStateType? = nil
  let isTakeHeaderOrBanner:Bool? = false//yes - 头像 no - 背景
  
  //Carema
  private var sessionQueue:dispatch_queue_t? = nil
  private var session:AVCaptureSession? = nil
  private var videoDeviceInput:AVCaptureDeviceInput? = nil//input
  private var stillImageOutput:AVCaptureStillImageOutput? = nil//图像output
  private var currentFlashMode:AVCaptureFlashMode? = nil//闪光灯模式
  private let previewLayer:AVCaptureVideoPreviewLayer? = nil//预览层

  
  //Utilities.
  private var backgroundRecordingID:UIBackgroundTaskIdentifier? = UIBackgroundTaskInvalid
  private var deviceAutorized:Bool? = false
  private let sessionRunningAndDeviceAuthorized:Bool? = false
  private let runtimeErrorHandlingObserver:AnyObject? = nil
  
  
  //ui
  private var previewView:UIView? = nil
  @IBOutlet private weak var previewBgView: UIView!//预览层bgview
  @IBOutlet private weak var cameraButton: UIButton!//前后摄像头
  @IBOutlet private weak var stillButton: UIButton!//拍照按钮
  @IBOutlet private weak var flashButton: UIButton!//闪光灯
  @IBOutlet private weak var showActionsheetBtn: UIButton!
  @IBOutlet private weak var nextBtn: UIButton!
  @IBOutlet private weak var deleteBtn: UIButton!
  
  //data
  private var stillImage:UIImage? = nil
  
  func isSessionRunningAndDeviceAuthorized() ->Bool {
    return false
  }

  
  //MARK:- ********************* vc lifecycle *********************

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.type = DGCTakePhotoStateType.Stop
    self.navigationController?.setNavigationBarHidden(false, animated:false)
    self.rdv_tabBarController.setTabBarHidden(true, animated: true)
    
    self.customInitUI()
  }
  
  override func viewDidAppear(animated: Bool) {
    dlog("拍照页面 viewDidAppear type \(self.type)");
    super.viewDidAppear(animated)
    self.showActionSheet()
  }
  
  override func viewWillDisappear(animated: Bool) {
    dlog("拍照页面 viewDidDisappear type \(self.type)")
    self.type! = DGCTakePhotoStateType.Stop
    
    
    //停止拍照 释放资源
    self.session?.stopRunning()
    self.previewView?.removeFromSuperview()
    self.session = nil
    self.sessionQueue = nil

    
    self.deleteBtn.hidden = true;
    self.stillButton.enabled = true;
   
    super.viewWillDisappear(animated)
  }
  
  //MARK:- ********************* method *********************
  //MARK:设置设备flashMode（前后摄像头）

  private static func setFlashModeForDevice(flashMode:AVCaptureFlashMode,device:AVCaptureDevice){
    
    if device.hasFlash && device.isFlashModeSupported(flashMode) {
      do{
        try device.lockForConfiguration()
        device.flashMode = flashMode
        device.unlockForConfiguration()
      }catch let err as NSError{
        dlog("置设备flashMode error \(err.localizedDescription)")
      }
    }
  }
  //MARK:获取device

  private static func deviceWithMediaType(mediaType:String,preferringPosition position:AVCaptureDevicePosition) -> AVCaptureDevice {
    
    let devices = AVCaptureDevice.devicesWithMediaType(mediaType)
    var captureDevice = devices.first
    for device in devices {
      if device is AVCaptureDevice {
        if device.position == position {
          captureDevice = device
          break
        }
      }
    }
    
    return captureDevice as! AVCaptureDevice
    
  }
  //MARK:设置自动曝光、对焦
  private func focusWithMode(focusMode:AVCaptureFocusMode,exposeWithMode exposureMode:AVCaptureExposureMode,atDevicePoint point:CGPoint,monitorSubjectAreaChange change:Bool) {
   
    dlog("point:\(NSStringFromCGPoint(point))");
    dispatch_async(self.sessionQueue!) {
      
      let device:AVCaptureDevice = self.videoDeviceInput!.device
      
      do{
        try device.lockForConfiguration()
        if device.isFocusModeSupported(focusMode) && device.focusPointOfInterestSupported{
          device.focusMode = focusMode
          device.focusPointOfInterest = point
        }
        
        if device.isExposureModeSupported(exposureMode) && device.exposurePointOfInterestSupported{
          device.exposureMode = exposureMode
          device.exposurePointOfInterest = point
        }
        
        device.subjectAreaChangeMonitoringEnabled = change
        device.unlockForConfiguration()
      }catch let err as NSError{
        dlog("设置自动曝光、对焦 error\(err.localizedDescription)")
      }
    }
  }
  
  //MARK:请求允许使用相机
  private func checkDeviceAuthorizationStatus(){
    
    AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo) { (granted:Bool) in
      if granted == true{
        self.deviceAutorized = true
      }else{
        dispatch_async(dispatch_get_main_queue(), { 
          let ac = UIAlertController(title: nil, message: "", preferredStyle: UIAlertControllerStyle.Alert)
          let aa = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) in
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
          })
          ac.addAction(aa)
          self.presentViewController(ac, animated: true, completion: nil)
          self.deviceAutorized = false
        })
      }
    }
  }
  
  //MARK:裁剪 压缩 exif提取 修改 插入 （注：要先裁剪再改exif）
  private func cropAndZipImgByBuffer(imageDataSampleBuffer:CMSampleBufferRef) -> UIImage {
    
    //原图
    let imageNSData:NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
    let image:UIImage = UIImage(data: imageNSData)!
    
    //最终尺寸
    let headHeight:CGFloat = 0
    let r = self.previewView!.bounds.size.width/1000.0
    let w = self.previewView!.bounds.size.width/r
    let h = self.previewView!.bounds.size.height/r
    let size:CGSize = CGSizeMake(w, h)
    dlog("拍照原图尺寸：\(NSStringFromCGSize(image.size)) 裁剪尺寸:\(NSStringFromCGSize(size))")
    
    //旋转后图片
    let scaledImage:UIImage = image.resizedImageWithContentMode(UIViewContentMode.ScaleAspectFill, bounds: size, interpolationQuality: CGInterpolationQuality.High)
    
    //最终图片
    let cropFrame:CGRect = CGRectMake((scaledImage.size.width - size.width)/2, (scaledImage.size.height - size.height)/2 + headHeight, size.width, size.height)
    let croppedImage:UIImage = scaledImage.croppedImage(cropFrame)
    self.saveImgToPohotLibrary(UIImageJPEGRepresentation(croppedImage, 1)!)
    return croppedImage
  }
  
  //保存拍照的照片到相册
  private func saveImgToPohotLibrary(imageData:NSData){
    
    // To preserve the metadata, we create an asset from the JPEG NSData representation.
    // Note that creating an asset from a UIImage discards the metadata.
    // In iOS 9, we can use -[PHAssetCreationRequest addResourceWithType:data:options].
    // In iOS 8, we save the image to a temporary file and use +[PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:].
    PHPhotoLibrary.requestAuthorization { (status:PHAuthorizationStatus) in
      if status == PHAuthorizationStatus.Authorized
      {
        if #available(iOS 9.0, *)
        {
          PHPhotoLibrary.sharedPhotoLibrary().performChanges({ 
            PHAssetCreationRequest.creationRequestForAsset().addResourceWithType(PHAssetResourceType.Photo, data: imageData, options: nil)
            }, completionHandler: { (success:Bool, error:NSError?) in
              if !success {
                dlog("Error occurred while saving image to photo library: \(error?.localizedDescription)")
              }
          })
        }
        
        else
        {
          let temporaryFileName = NSProcessInfo.processInfo().globallyUniqueString
          let temporaryFileURL = NSURL(string: NSTemporaryDirectory())
          temporaryFileURL?.URLByAppendingPathComponent(temporaryFileName.stringByAppendingString(".jpg"))
          
          PHPhotoLibrary.sharedPhotoLibrary().performChanges({ 
            do{
              try imageData.writeToURL(temporaryFileURL!, options: NSDataWritingOptions.AtomicWrite)
            }catch let err as NSError{
              dlog("Error occured while writing image data to a temporary file: \(err.localizedDescription)")
            }
            }, completionHandler: { (success:Bool, error:NSError?) in
              if !success{
                dlog("Error occurred while saving image to photo library: \(error?.localizedDescription)")
              }
              
              do{
                try NSFileManager.defaultManager().removeItemAtURL(temporaryFileURL!)
              }catch let err as NSError{
                dlog("Delete the temporary file error:\(err.localizedDescription)")
              }
          })
        }
       
      }
    }
    
    
    
  }
  
  //MARK:- customInit
  private func customInitUI(){
    
    self.edgesForExtendedLayout = UIRectEdge.None;
    
    let titleLabel:UILabel = UILabel(frame: CGRectMake(0,0,100,44))
    if self.isTakeHeaderOrBanner == true {
      titleLabel.text = "头像拍摄"
    }else{
      titleLabel.text = "背景拍摄"
    }
    titleLabel.textColor = UIColor.whiteColor()
    titleLabel.backgroundColor = UIColor.clearColor()
    titleLabel.textAlignment = NSTextAlignment.Center
    self.navigationItem.titleView = titleLabel
    
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navibg.png"), forBarMetrics: UIBarMetrics.Default)
    self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    
  }
  
  
  private func customInitCamera(){
    
    //init
    self.currentFlashMode = AVCaptureFlashMode.Auto
    self.nextBtn.setTitle("下一步", forState: UIControlState.Normal)
    self.nextBtn.enabled = false
    self.session = AVCaptureSession()

    //设置预览图层
    let previewView:UIView = UIView(frame: self.previewBgView.bounds)
    self.previewBgView.addSubview(previewView)
    self.previewView = previewView
    
    let tapGR:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(focusAndExposeTap(_:)))
    self.previewView?.addGestureRecognizer(tapGR)
    
    let preiewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session!)
    let viewLayer:CALayer = self.previewView!.layer
    viewLayer.masksToBounds = true
    preiewLayer.frame = self.previewView!.bounds
    preiewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    viewLayer.insertSublayer(preiewLayer, above: viewLayer.sublayers![0])
    
    //请求用户使用相机
    self.checkDeviceAuthorizationStatus()
    
    //在子线程加入input output
    self.sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL)
    dispatch_async(self.sessionQueue!) {
      
      //向ios程序请求后台延时
      self.backgroundRecordingID = UIBackgroundTaskInvalid
      
      //获取device
      let videoDevice:AVCaptureDevice = DGCHeaderPhotoVC.deviceWithMediaType(AVMediaTypeVideo, preferringPosition: AVCaptureDevicePosition.Back)
      
      //input
      do{
        let videoDeviceInput:AVCaptureDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
        if self.session!.canAddInput(videoDeviceInput){
          self.session?.addInput(videoDeviceInput)
          self.videoDeviceInput = videoDeviceInput
        }
      }catch let err as NSError{
        dlog("获取camera input error \(err.localizedDescription)")
      }
      
      //设置图像output
      let stillImageOutput:AVCaptureStillImageOutput = AVCaptureStillImageOutput()
      if self.session!.canAddOutput(stillImageOutput){
        stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        self.session?.addOutput(stillImageOutput)
        self.stillImageOutput = stillImageOutput
      }
    }
    
  }
  
  private func showActionSheet(){
        

    let ac:UIAlertController = UIAlertController(title: "请选择", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
    let aa:UIAlertAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (action) in
      self.customInitCamera()
      self.session?.stopRunning()
    }
    let aa1:UIAlertAction = UIAlertAction(title: "相册", style: UIAlertActionStyle.Default) { (action) in
      self.type = DGCTakePhotoStateType.Alubm
      let vc:DGCPhotoLibraryVC = DGCPhotoLibraryVC(nibName: "DGCPhotoLibraryVC", bundle: nil)
      vc.isTakeHeaderOrBanner = self.isTakeHeaderOrBanner
      self.navigationController?.pushViewController(vc, animated: true)
    }
    let aa2:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Default) { (action) in
      self.navigationController?.popViewControllerAnimated(true)
    }
    ac.addAction(aa)
    ac.addAction(aa1)
    ac.addAction(aa2)
    
    self.navigationController?.presentViewController(ac, animated: true, completion: nil)
  }
  
  //MARK:- 旋屏
  override func shouldAutorotate() -> Bool {
    return false
  }
  
  override func supportedInterfaceOrientations()->UIInterfaceOrientationMask{
    return UIInterfaceOrientationMask.All
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    
    // Note that the app delegate controls the device orientation notifications required to use the device orientation.
    let deviceOrientation:UIDeviceOrientation = UIDevice.currentDevice().orientation
    if UIDeviceOrientationIsPortrait(deviceOrientation) || UIDeviceOrientationIsLandscape(deviceOrientation) {
      let previewLayer:AVCaptureVideoPreviewLayer = self.previewView!.layer as! AVCaptureVideoPreviewLayer
      previewLayer.connection.videoOrientation = AVCaptureVideoOrientation(ui: deviceOrientation)
    }
    
  }
  //MARK:- kvo/kvc 通知
  private var CapturingStillImageContext = "CapturingStillImageContext"
  private var RecordingContext = "CapturingStillImageContext"
  private var SessionRunningAndDeviceAuthorizedContext = "SessionRunningAndDeviceAuthorizedContext"
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    
    if context == &CapturingStillImageContext {
      let isCapturingStillImage:Bool = change![NSKeyValueChangeNewKey]!.boolValue
      if isCapturingStillImage == true {
        self.runStillImageCaptureAnimation()
      }
    }else if context == &RecordingContext{
      let isRecording:Bool = change![NSKeyValueChangeNewKey]!.boolValue
      
      dispatch_async(dispatch_get_main_queue(), { 
        if isRecording == true{
          self.cameraButton.enabled = false;
        }else{
          self.cameraButton.enabled = true;
        }
      })
    }else if context == &SessionRunningAndDeviceAuthorizedContext {
      let isRunning:Bool = change![NSKeyValueChangeNewKey]!.boolValue
      dispatch_async(dispatch_get_main_queue(), { 
        if isRunning == true{
          self.cameraButton.enabled = true;
          self.stillButton.enabled = true;
        }else{
          self.cameraButton.enabled = false;
          self.stillButton.enabled = false;
        }
      })
      
    }else{
      super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context);
    }
    
  }
  
  @objc private func subjectAreaDidChange(notification:NSNotification) {

    let devicePoint:CGPoint = CGPointMake(0.5, 0.5)
    self.focusWithMode(AVCaptureFocusMode.ContinuousAutoFocus, exposeWithMode: AVCaptureExposureMode.ContinuousAutoExposure, atDevicePoint: devicePoint, monitorSubjectAreaChange: false)
  }
  
  

  private func addObserver() {

    self.addObserver(self, forKeyPath: "sessionRunningAndDeviceAuthorized", options: .New, context: &SessionRunningAndDeviceAuthorizedContext)
    self.addObserver(self, forKeyPath: "stillImageOutput.capturingStillImage", options: .New, context: &CapturingStillImageContext)
    self.addObserver(self, forKeyPath: "movieFileOutput.recording", options: .New, context: &RecordingContext)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.subjectAreaDidChange(_:)), name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: self.videoDeviceInput?.device)
  }
  
  private func removeObserver() {
    
    NSNotificationCenter.defaultCenter().removeObserver(self, name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: self.videoDeviceInput?.device)
    self.removeObserver(self, forKeyPath: "stillImageOutput.capturingStillImage", context: &CapturingStillImageContext)
    self.removeObserver(self, forKeyPath: "movieFileOutput.recording", context: &RecordingContext)
    self.removeObserver(self, forKeyPath: "sessionRunningAndDeviceAuthorized", context: &SessionRunningAndDeviceAuthorizedContext)
  }

  //MARK:- ********************* action *********************
  //MARK:跳转到裁剪页面
  @IBAction private func nextBtnTap(sender: AnyObject) {
    
    let vc:VPImageCropperViewController = VPImageCropperViewController()
    vc.originalImage = self.stillImage!
    vc.limitRatio = 3.0
    vc.delegate = self
    if self.isTakeHeaderOrBanner == true {
      vc.cropFrame = CGRectMake(0, (SCREEN_HEIGHT-SCREEN_WIDTH-NAVI_HEIGHT)*0.5, SCREEN_WIDTH, SCREEN_WIDTH)
    }else{
      vc.cropFrame = CGRectMake(0, (SCREEN_HEIGHT-0.3*SCREEN_WIDTH-NAVI_HEIGHT)*0.5, SCREEN_WIDTH, SCREEN_WIDTH*0.3)
    }
    
    self.navigationController?.pushViewController(vc, animated: true)
  }

  //MARK:跳转到相册
  @IBAction private func showActionSheetBtn(sender: AnyObject) {
    
    self.type = DGCTakePhotoStateType.Alubm
    let vc:DGCPhotoLibraryVC = DGCPhotoLibraryVC(nibName: "DGCPhotoLibraryVC", bundle: nil)
    vc.isTakeHeaderOrBanner = self.isTakeHeaderOrBanner
    self.navigationController?.pushViewController(vc, animated: true)
  }
  //MARK:切换前后摄像头
  @IBAction private func changeCamera(sender: AnyObject) {
    
    self.cameraButton.enabled = false;
    self.stillButton.enabled = false;
    
    //获取方向 设置方向 修改input
    dispatch_async(self.sessionQueue!) { 
      
      let currentVideoDevice:AVCaptureDevice = self.videoDeviceInput!.device
      var preferredPosition:AVCaptureDevicePosition = AVCaptureDevicePosition.Unspecified//待设置的方向
      let currentPosition:AVCaptureDevicePosition = currentVideoDevice.position//当前方向
      
      switch currentPosition{
      case .Unspecified:
        preferredPosition = AVCaptureDevicePosition.Back;
      case .Back:
        preferredPosition = AVCaptureDevicePosition.Front;
      case .Front:
        preferredPosition = AVCaptureDevicePosition.Back;
      }
      
      let videoDevice:AVCaptureDevice = DGCHeaderPhotoVC.deviceWithMediaType(AVMediaTypeVideo, preferringPosition: preferredPosition)
      
      do{
        let videoDeviceInput:AVCaptureDeviceInput = try AVCaptureDeviceInput.init(device: videoDevice)
        
        self.session?.beginConfiguration()
        self.session?.removeInput(self.videoDeviceInput)
        
        if self.session!.canAddInput(videoDeviceInput)
        {
          NSNotificationCenter.defaultCenter().removeObserver(self, name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: currentVideoDevice)
          DGCHeaderPhotoVC.setFlashModeForDevice(AVCaptureFlashMode.Auto, device: videoDevice)
          NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.subjectAreaDidChange(_:)), name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: videoDevice)
          self.session?.addInput(videoDeviceInput)
          self.videoDeviceInput = videoDeviceInput
        }
        else
        {
          self.session?.addInput(self.videoDeviceInput)
        }
        
        self.session?.commitConfiguration()

      }catch let err as NSError{
        dlog("切换前后摄像头 error:\(err.localizedDescription)")
      }
      
      dispatch_async(dispatch_get_main_queue(), { 
        self.cameraButton.enabled = true
        self.stillButton.enabled = true
      })
    }
  }
  
  
  //MARK:拍照
  @IBAction private func snapStillImage(sender: AnyObject) {
    
    dispatch_async(self.sessionQueue!) {
      
      let videoConnection:AVCaptureConnection = self.stillImageOutput!.connectionWithMediaType(AVMediaTypeVideo)
      videoConnection.videoOrientation = self.previewLayer!.connection.videoOrientation
      
      DGCHeaderPhotoVC.setFlashModeForDevice(self.currentFlashMode!, device: self.videoDeviceInput!.device)
      
      self.stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (imageDataSampleBuffer:CMSampleBufferRef!, error:NSError!) in
        
        if imageDataSampleBuffer == nil{
          dlog("获取照片失败")
          return
        }
        
        let croppedImg:UIImage = self.cropAndZipImgByBuffer(imageDataSampleBuffer)
        self.stillImage = croppedImg
        self.deleteBtn.hidden = false
        self.stillButton.enabled = false
        self.nextBtn.enabled = true
        self.session?.stopRunning()
      })
    }
  }
  //MARK:闪光控制
  @IBAction private func changeFlashMode(sender: AnyObject) {
    


    switch self.currentFlashMode! {
    case .Auto:
      self.currentFlashMode! = .On
      self.flashButton.setTitle("On", forState: UIControlState.Normal)
      self.flashButton.setImage(UIImage(named: "Share-Button-Flash-on.png")!, forState: UIControlState.Normal)
    case .On:
      self.currentFlashMode! = .Off
      self.flashButton.setTitle("Off", forState: UIControlState.Normal)
      self.flashButton.setImage(UIImage(named: "Share-Button-Flash.png")!, forState: UIControlState.Normal)
    case .Off:
      self.currentFlashMode! = .Auto
      self.flashButton.setTitle("Auto", forState: UIControlState.Normal)
      self.flashButton.setImage(UIImage(named: "Share-Button-Flash-on.png")!, forState: UIControlState.Normal)
    }
    
  }
  //MARK:HDR控制
  @IBAction private func chageHDRMode(sender: AnyObject) {
    


    let HDRButton:UIButton = sender as! UIButton
    HDRButton.selected = !HDRButton.selected
    
    if HDRButton.selected//开启HDR
    {
      self.stillButton.enabled = false
      self.cameraButton.enabled = false
      
      try! self.videoDeviceInput?.device.lockForConfiguration()
      self.videoDeviceInput?.device.activeFormat = self.videoDeviceInput?.device.activeFormat
      self.session?.beginConfiguration()
      self.videoDeviceInput?.device.automaticallyAdjustsVideoHDREnabled = false
      if self.videoDeviceInput?.device.activeFormat.videoHDRSupported == true {
        self.videoDeviceInput?.device.videoHDREnabled = true
      }else{
        self.videoDeviceInput?.device.automaticallyAdjustsVideoHDREnabled = true
      }
      
      self.session?.commitConfiguration()
      self.stillButton.enabled = true
      self.cameraButton.enabled = true
    }
    else//关闭HDR
    {
      self.stillButton.enabled = false
      self.cameraButton.enabled = false
      
      try! self.videoDeviceInput?.device.lockForConfiguration()
      self.videoDeviceInput?.device.activeFormat = self.videoDeviceInput?.device.activeFormat
      self.session?.beginConfiguration()
      self.videoDeviceInput?.device.automaticallyAdjustsVideoHDREnabled = false
      if self.videoDeviceInput?.device.activeFormat.videoHDRSupported == true {
        self.videoDeviceInput?.device.videoHDREnabled = false
      }else{
        self.videoDeviceInput?.device.automaticallyAdjustsVideoHDREnabled = false
      }
      
      self.session?.commitConfiguration()
      self.stillButton.enabled = true
      self.cameraButton.enabled = true
    }
    


  }
  //MARK:删除照片
  @IBAction private func closeImageView(sender: AnyObject) {
    
    self.stillImage = nil
    self.deleteBtn.hidden = true
    self.stillButton.enabled = true
    self.nextBtn.enabled = false
    self.session?.startRunning()
  }
  
  //MARK:UI
  private func runStillImageCaptureAnimation() {
    
    dispatch_async(dispatch_get_main_queue()) { 
      self.previewView!.layer.opacity = 0.0
      UIView.animateWithDuration(0.25, animations: { 
        self.previewView!.layer.opacity = 1.0
      })
    }
  }
  //MARK:预览图点击
  @objc private func focusAndExposeTap(gestureRecognizer:UITapGestureRecognizer) {
    
    let point:CGPoint = gestureRecognizer.locationInView(gestureRecognizer.view)
    let devicePoint:CGPoint = self.previewLayer!.captureDevicePointOfInterestForPoint(point)
    self.focusWithMode(AVCaptureFocusMode.AutoFocus, exposeWithMode: AVCaptureExposureMode.AutoExpose, atDevicePoint: devicePoint, monitorSubjectAreaChange: true)
    
  }
  //MARK:- ********************* callback *********************
  //MARK:- VPImageCropperDelegate
  func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
    
    let vc:DGCPhotoPreviewVC = DGCPhotoPreviewVC(nibName: "DGCPhotoPreviewVC", bundle: nil)
    vc.photo = editedImage
    vc.isTakeHeaderOrBanner = self.isTakeHeaderOrBanner
    cropperViewController.navigationController!.pushViewController(vc, animated: true)
  }
  
  func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
    cropperViewController.navigationController?.popViewControllerAnimated(true)
  }
  
  
}

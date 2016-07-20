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

class DGCHeaderPhotoVC: UIViewController,UIActionSheetDelegate,VPImageCropperDelegate {

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
  private let deviceAutorized:Bool? = false
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
  private let stillImage:UIImage? = nil
  
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
  //MARK:- 设置设备flashMode（前后摄像头）

  static func setFlashModeForDevice(flashMode:AVCaptureFlashMode,device:AVCaptureDevice){
    
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
  //MARK:- 获取device

  static func deviceWithMediaType(mediaType:String,preferringPosition position:AVCaptureDevicePosition) -> AVCaptureDevice {
    
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
  //MARK:- 设置自动曝光、对焦
  func focusWithMode(focusMode:AVCaptureFocusMode,exposeWithMode exposureMode:AVCaptureExposureMode,atDevicePoint point:CGPoint,monitorSubjectAreaChange change:Bool) {
   
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
  //MARK:- 请求允许使用相机
  func checkDeviceAuthorizationStatus(){
    
  }
  //MARK:- 裁剪 压缩 exif提取 修改 插入 （注：要先裁剪再改exif）
  func cropAndZipImgByBuffer(imageDataSampleBuffer:CMSampleBufferRef) -> UIImage? {
    return nil
  }
  
  //保存拍照的照片到相册
  func saveImgToPohotLibrary(imageData:NSData){
    
  }
  
  //MARK:- customInit
  func customInitUI(){
    
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
  
  
  func customInitCamera(){
    
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
  
  func showActionSheet(){
        

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
  
  func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
    
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
  
  func subjectAreaDidChange(notification:NSNotification) {

    let devicePoint:CGPoint = CGPointMake(0.5, 0.5)
    self.focusWithMode(AVCaptureFocusMode.ContinuousAutoFocus, exposeWithMode: AVCaptureExposureMode.ContinuousAutoExposure, atDevicePoint: devicePoint, monitorSubjectAreaChange: false)
  }
  
  

  func addObserver() {

    self.addObserver(self, forKeyPath: "sessionRunningAndDeviceAuthorized", options: .New, context: &SessionRunningAndDeviceAuthorizedContext)
    self.addObserver(self, forKeyPath: "stillImageOutput.capturingStillImage", options: .New, context: &CapturingStillImageContext)
    self.addObserver(self, forKeyPath: "movieFileOutput.recording", options: .New, context: &RecordingContext)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(subjectAreaDidChange(_:)), name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: self.videoDeviceInput?.device)
  }
  
  func removeObserver() {
    
    NSNotificationCenter.defaultCenter().removeObserver(self, name: AVCaptureDeviceSubjectAreaDidChangeNotification, object: self.videoDeviceInput?.device)
    self.removeObserver(self, forKeyPath: "stillImageOutput.capturingStillImage", context: &CapturingStillImageContext)
    self.removeObserver(self, forKeyPath: "movieFileOutput.recording", context: &RecordingContext)
    self.removeObserver(self, forKeyPath: "sessionRunningAndDeviceAuthorized", context: &SessionRunningAndDeviceAuthorizedContext)
  }

  //MARK:- ********************* action *********************
  //MARK:- 跳转到发送页面
  @IBAction func nextBtnTap(sender: AnyObject) {
  }

  //MARK:- 跳转到相册
  @IBAction func showActionSheetBtn(sender: AnyObject) {
  }
  //MARK:- 切换前后摄像头
  @IBAction func changeCamera(sender: AnyObject) {
  }
  //MARK:- 拍照
  @IBAction func snapStillImage(sender: AnyObject) {
  }
  //MARK:- 闪光控制
  @IBAction func changeFlashMode(sender: AnyObject) {
  }
  //MARK:- HDR控制
  @IBAction func chageHDRMode(sender: AnyObject) {
  }
  //MARK:- 删除照片
  @IBAction func closeImageView(sender: AnyObject) {
  }
  //MARK:- UI
  func runStillImageCaptureAnimation() {
    
  }
  //MARK:- 预览图点击
  func focusAndExposeTap(gestureRecognizer:UITapGestureRecognizer) {
    
  }
  //MARK:- ********************* callback *********************
  //MARK:- VPImageCropperDelegate
  func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
    
  }
  
  func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
    
  }
  
  
}

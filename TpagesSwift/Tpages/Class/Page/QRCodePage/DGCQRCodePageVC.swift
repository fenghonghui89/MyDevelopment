//
//  DGCQRCodePageVC.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/8.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation
import AVFoundation

class DGCQRCodePageVC: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
  
  var bgView:UIView?
  var previewView:UIView?
  var overLayerView:UIView?
  var maskView:UIView?
  var session:AVCaptureSession?
  var device:AVCaptureDevice?
  
  
  //MARK:- ****************************** vc lifecycle ******************************
  
  deinit{
    self.session?.stopRunning();
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.customizeInitData()
    self.customizeInitUI()
    self.customizeInitCamera()
  }
  
  override func viewDidAppear(animated: Bool) {
    
    super.viewDidAppear(animated)
    self.session?.startRunning()
  }
  
  override func viewDidDisappear(animated: Bool) {
    
    self.session?.stopRunning()
    super.viewDidDisappear(animated)
  }
  //MARK:- ****************************** method ******************************
  
  func customizeInitData(){
    
    //session
    let session = AVCaptureSession()
    session.sessionPreset = AVCaptureSessionPresetHigh//高质量采集率
    self.session = session
    
    //device
    let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    self.device = device
    
  }
  
  func customizeInitUI(){
    
    self.customizeInitNavi()
    self.customizeInitUIBase()
  }
  
  func customizeInitNavi(){
    
    self.edgesForExtendedLayout = UIRectEdge.None;
    
    let titleLabel = UILabel(frame: CGRectMake(0,0,100,44))
    titleLabel.text = "二维码扫描"
    titleLabel.textColor = UIColor.whiteColor()
    titleLabel.backgroundColor = UIColor.clearColor()
    titleLabel.textAlignment = NSTextAlignment.Center
    self.navigationItem.titleView = titleLabel
    
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navibg.png"), forBarMetrics: UIBarMetrics.Default)
    self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
  }
  
  func customizeInitUIBase(){
    
    //bgview
    let bgView = UIView(frame: CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-STATE_BAR_HEIGHT-NAVI_HEIGHT-TABBAR_HEIGHT))
    self.view.addSubview(bgView)
    self.bgView = bgView
    
    //previewView
    let previewView = UIView(frame:bgView.bounds)
    self.bgView?.addSubview(previewView)
    self.previewView = previewView

    
    //previewLayer
    let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    previewLayer.frame = self.previewView!.bounds
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    
    let viewLayer:CALayer = self.previewView!.layer
    viewLayer.masksToBounds = true
    viewLayer.addSublayer(previewLayer)
    
    
    //overlayerView
    let overlayerView = UIView(frame: bgView.bounds)
    overlayerView.backgroundColor = UIColor.blackColor()
    overlayerView.alpha = 0.5
    self.bgView?.addSubview(overlayerView)
    self.overLayerView = overlayerView
    
    //maskView
    let w = SCREEN_WIDTH*0.7
    let h = SCREEN_WIDTH*0.7
    let x = (SCREEN_WIDTH - w)/2
    let y = (bgView.bounds.size.height - h)*0.5
    let maskView = UIView(frame: CGRectMake(x,y,w,h))
    maskView.backgroundColor = UIColor.clearColor()
    maskView.alpha = 0.3
    maskView.layer.borderColor = UIColor.yellowColor().CGColor
    maskView.layer.borderWidth = 2
    self.bgView?.addSubview(maskView)
    self.maskView = maskView
    
    //使截取框透明
    self.overlayClipping()
    
    //label
    let msgLabel = UILabel()
    msgLabel.text = "将二维码放入框内，即可自动扫描"
    msgLabel.textColor = UIColor.whiteColor()
    msgLabel.sizeToFit()
    self.bgView?.addSubview(msgLabel)
    msgLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.maskView!.snp_bottom).offset(20)
      make.centerX.equalTo(self.maskView!.snp_centerX)
    }
    
    //版本号
    let versionLabel = UILabel()
    versionLabel.text = "2016-07-06 17:17:43"
    versionLabel.font = UIFont.systemFontOfSize(10)
    versionLabel.textColor = UIColor.whiteColor()
    versionLabel.sizeToFit()
    self.bgView?.addSubview(versionLabel)
    versionLabel.snp_makeConstraints { (make) in
      make.bottom.equalTo(self.bgView!).offset(0)
      make.trailing.equalTo(self.bgView!).offset(0)
    }
    
  }
  
  func overlayClipping(){
    
    let maskLayer = CAShapeLayer()
    let path:CGMutablePathRef = CGPathCreateMutable()
    
    // Left side of the ratio view
    CGPathAddRect(path, nil, CGRectMake(0,
    0,
    self.maskView!.frame.origin.x,
    self.bgView!.frame.size.height));
    
    // Right side of the ratio view
    CGPathAddRect(path, nil, CGRectMake(self.maskView!.frame.origin.x + self.maskView!.frame.size.width,
    0,
    self.bgView!.frame.size.width - self.maskView!.frame.origin.x - self.maskView!.frame.size.width,
    self.bgView!.frame.size.height));
    
    // Top side of the ratio view
    CGPathAddRect(path, nil, CGRectMake(0,
    0,
    self.bgView!.frame.size.width,
    self.maskView!.frame.origin.y));
    
    // Bottom side of the ratio view
    CGPathAddRect(path, nil, CGRectMake(0,
    self.maskView!.frame.origin.y + self.maskView!.frame.size.height,
    self.bgView!.frame.size.width,
    self.bgView!.frame.size.height - self.maskView!.frame.origin.y - self.maskView!.frame.size.height));
    
    maskLayer.path = path;
    self.overLayerView!.layer.mask = maskLayer;
    
  }
  
  func customizeInitCamera(){
    
    //创建输入流
    let input = try? AVCaptureDeviceInput(device: self.device)
    self.session?.addInput(input)
    
    //创建输出流
    let output = AVCaptureMetadataOutput()
    
    //设置代理 在主线程里刷新
    output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())

    //要先加入到session
    self.session?.addOutput(output)
    
    //再设置扫码支持的编码格式
    output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    
    //设置响应范围 CGRectMake(Y,X,H,W) 1代表最大值  原点是navi右下角 往左往下为正
    let y = self.maskView!.frame.origin.y/self.bgView!.bounds.size.height;
    let x = (self.bgView!.bounds.size.width-self.maskView!.frame.origin.x-self.maskView!.frame.size.width)/self.bgView!.bounds.size.width;
    let h = self.maskView!.frame.size.height/self.bgView!.bounds.size.height;
    let w = self.maskView!.frame.size.width/self.bgView!.bounds.size.width;
    output.rectOfInterest = CGRectMake(y,x,h,w)

  }
  
  //MARK:- ****************************** callback ******************************
  func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
    
    if (metadataObjects.count>0) {
      
      //获取二维码内容
      let metadataObject:AVMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
      let qrcodeString:String = metadataObject.stringValue
      dlog("qrcodeString:\(qrcodeString)")
      
      self.operateQRCode(qrcodeString)
    }

  }
  
  func operateQRCode(qrcodeString:String) {
    
    //转换为request
    var url:NSURL?
    var scheme:String?
    var host:String?
    
    if let URL:NSURL = NSURL(string: qrcodeString) {
      url = URL
      scheme = url!.scheme
      host = url!.host
      dlog("qrcod: host:\(host),scheme:\(scheme)")
    }
    
    
    //判断
    if scheme == "http" || scheme == "https" {
      if host == HOST_TPAGES_DEV || host == HOST_TPAGES_CN {
        dlog("根据二维码跳转到T视界")
        self.session?.stopRunning()
        self.rdv_tabBarController.selectedIndex = 0
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_TRANSITION_TPAGES, object: nil, userInfo: [NOTI_TRANSITION_TPAGES:qrcodeString])
      }else if host == HOST_MALL_DEV || host == HOST_MALL_CN {
        dlog("根据二维码跳转到商城")
        self.session?.stopRunning()
        self.rdv_tabBarController.selectedIndex = 1
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_TRANSITION_MALL, object: nil, userInfo: [NOTI_TRANSITION_MALL:qrcodeString])
      }else{
        
        self.session?.stopRunning()
        
        let ac:UIAlertController = DGCAlertController.alertControlller("是否使用外部浏览器打开链接？", message: nil, type: DGCAlertType.DGCAlertTypeNoAction, block: nil)
        
        let at1 = UIAlertAction(title: "不用", style: UIAlertActionStyle.Default, handler: { (action) in
          self.session?.startRunning()
        })
        
        let at2 = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default, handler: { (action) in
          let url:NSURL = NSURL(string: qrcodeString)!
          UIApplication.sharedApplication().openURL(url)
          self.session?.startRunning()
        })
        
        ac.addAction(at1)
        ac.addAction(at2)
        
        self.presentViewController(ac, animated: true, completion: nil)
      }
    }else{
      
      self.session?.stopRunning()
      
      let ac:UIAlertController = DGCAlertController.alertControlller("错误：二维码不是指向网址。", message: nil, type: DGCAlertType.DGCAlertTypeNoAction, block: nil)
      let at1 = UIAlertAction(title: "知道了", style: UIAlertActionStyle.Default, handler: { (action) in
        self.session?.startRunning()
      })
      ac.addAction(at1)
      self.presentViewController(ac, animated: true, completion: nil)
    }
    
    
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
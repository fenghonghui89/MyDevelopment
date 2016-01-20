//
//  MD_AVQRCode_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/20.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
@import AVFoundation;
#import "MD_AVQRCode_VC.h"

@interface MD_AVQRCode_VC ()<AVCaptureMetadataOutputObjectsDelegate>//用于处理采集信息的代理
{
  AVCaptureSession * session;//输入输出的中间桥梁
}
@end

@implementation MD_AVQRCode_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //获取摄像设备
  AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  //创建输入流
  AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
  //创建输出流
  AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
  //设置代理 在主线程里刷新
  [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
  
  //初始化链接对象
  session = [[AVCaptureSession alloc]init];
  //高质量采集率
  [session setSessionPreset:AVCaptureSessionPresetHigh];
  
  [session addInput:input];
  [session addOutput:output];
  //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
  output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
  
  AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
  layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
  layer.frame=self.view.layer.bounds;
  [self.view.layer insertSublayer:layer atIndex:0];
  //开始捕获
  [session startRunning];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
  if (metadataObjects.count>0) {
    //[session stopRunning];
    AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
    //输出扫描字符串
    NSLog(@"%@",metadataObject.stringValue);
  }
}

@end

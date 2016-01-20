//
//  MDAVCameraPreviewView.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/7.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//


#import "MDAVCameraPreviewView.h"

@implementation MDAVCameraPreviewView

//让UIView使用不同的CALayer来显示
+(Class)layerClass
{
  return [AVCaptureVideoPreviewLayer class];
}

-(AVCaptureSession *)session
{
  AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
  previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
  return previewLayer.session;
}

-(void)setSession:(AVCaptureSession *)session
{
  AVCaptureVideoPreviewLayer *previewLayer = (AVCaptureVideoPreviewLayer *)self.layer;
  previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
  previewLayer.session = session;
}
@end

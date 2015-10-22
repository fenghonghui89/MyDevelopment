//
//  ZTCameraView.h
//  TCamera
//
//  Created by 苏章桐 on 15/5/14.
//  Copyright (c) 2015年 changheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, DevicePosition) {
    DevicePositionFront,
    DevicePositionBack
};

typedef void(^ShutterCamera)(UIImage *image, NSError *error);

@interface ZTCameraView : UIView

@property (nonatomic,strong) AVCaptureSession *session;   //AVCaptureSession对象用来执行输入设备跟输出设备之间的数据传递
@property (nonatomic,strong) AVCaptureDeviceInput *videoInput; //AVCaptureDeviceInput对象是输入流
@property (nonatomic,strong) AVCaptureStillImageOutput *stillImageOutput; //AVCaptureStillImageOutput对象是照片输出流
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer; //AVCaptureVideoPreviewLayer预览图层,来显示照相机拍摄到的画面
@property (nonatomic,strong) AVCaptureDevice *device;          //摄像头设备
@property (nonatomic,assign) DevicePosition devicePosition;    //前后摄像头

@property (nonatomic,assign) BOOL isSaveMask;      //拍照时是否保存遮罩层

- (instancetype)initWithFrame:(CGRect)frame DevicePosition:(DevicePosition)position;

///切换摄像头
-(void)toggleCamera;
///初始化之后会自动打开
-(void)start;
///停止拍照
-(void)stop;
///拍照
-(void)shutterCameraWithBlock:(ShutterCamera)shutterCamera;
//添加一个遮罩
-(void)addMaskView:(UIView *)view;

@end

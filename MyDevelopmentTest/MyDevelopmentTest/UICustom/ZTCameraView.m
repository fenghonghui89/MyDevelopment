//
//  ZTCameraView.m
//  TCamera
//
//  Created by 苏章桐 on 15/5/14.
//  Copyright (c) 2015年 changheng. All rights reserved.
//自定义相机

#import "ZTCameraView.h"

@implementation ZTCameraView


- (instancetype)initWithFrame:(CGRect)frame DevicePosition:(DevicePosition)position{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _isSaveMask = NO;
        [self initCamera];
        self.devicePosition= position;
    }
    
    return self;
    
}

-(void)initCamera{
    
    _session = [[AVCaptureSession alloc] init];
//    _videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    _stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    //这是输出流的设置参数AVVideoCodecJPEG表示以jpeg的图片格式输出图片
    [_stillImageOutput setOutputSettings:outputSettings];
    
//    if ([_session canAddInput:_videoInput]) {
//        [_session addInput:_videoInput];
//    }
    
    if ([_session canAddOutput:_stillImageOutput]) {
        [_session addOutput:_stillImageOutput];
    }

    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    CALayer * viewLayer = [self layer];
    [viewLayer setMasksToBounds:YES];
    
    CGRect bounds = [self bounds];
    [self.previewLayer setFrame:bounds];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [viewLayer insertSublayer:self.previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
    
    [self.session startRunning];
    
}


-(void)toggleCamera{
//    //翻转动画
//    CATransition *animation = [CATransition animation];
//    animation.delegate = self;
//    animation.duration = .8f;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"oglFlip";
//    if (_device.position == AVCaptureDevicePositionFront) {
//        animation.subtype = kCATransitionFromRight;
//    }
//    else if(_device.position == AVCaptureDevicePositionBack){
//        animation.subtype = kCATransitionFromLeft;
//    }
//    [self.layer addAnimation:animation forKey:@"animation"];
    if (self.devicePosition == DevicePositionBack) {
        self.devicePosition = DevicePositionFront;
    }else{
        self.devicePosition = DevicePositionBack;
    }
    
}

-(void)start{
    
    if (self.session) {
        [self.session startRunning];
    }
    
}

-(void)stop{
    if (self.session) {
        [self.session stopRunning];
    }
}

-(void)shutterCameraWithBlock:(ShutterCamera)shutterCamera{
    
    AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        if (shutterCamera) {
            NSError *error = [NSError errorWithDomain:@"拍照失败" code:0 userInfo:nil];
            shutterCamera(nil,error);
        }
        return;
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        UIImage *image = nil;
        NSError *error2 = nil;
        if (imageDataSampleBuffer == NULL) {
            error2 = [NSError errorWithDomain:@"获取照片失败" code:0 userInfo:nil];
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        image = [UIImage imageWithData:imageData];
        NSLog(@"image size = %@",NSStringFromCGSize(image.size));
        
        if (_isSaveMask) {
            for (UIView *view in self.subviews) {
                if ([view isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView = (UIImageView *)view;
                    image = [self composeImage:imageView.image toImage:image atFrame:imageView.frame];
                }
            }
        }
        
        
        shutterCamera(image,error);
        
    }];
    
}

-(void)addMaskView:(UIView *)view{

    view.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    pan.minimumNumberOfTouches = 1;
    pan.maximumNumberOfTouches = 1;
    [view addGestureRecognizer:pan];
    [self addSubview:view];
    
}

-(void)panAction:(UIPanGestureRecognizer *)sender{
    sender.view.center = [sender locationInView:self];
    
}

-(void)setDevicePosition:(DevicePosition)devicePosition{
    
    if (_devicePosition == devicePosition && self.device) {
        return;
    }
    _devicePosition = devicePosition;
    NSArray *devices = [NSArray new];
    devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (_devicePosition == DevicePositionBack) {
            if ([device position] == AVCaptureDevicePositionBack) {
                self.device = device;
                break;
            }
        }else {
            if ([device position] == AVCaptureDevicePositionFront) {
                self.device = device;
                break;
            }
        }
    }
    
}


-(void)setDevice:(AVCaptureDevice *)device{
    
    _device = device;
    [self updateCamera];
}

//切换摄像头后更新相机
- (void)updateCamera {
    
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        
        if (_device) {
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:&error];
        }else{
            return;
        }
        
        if (newVideoInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                [self setVideoInput:newVideoInput];
            } else {
                [self.session addInput:self.videoInput];
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}


- (UIImage *)composeImage:(UIImage *)subImage toImage:(UIImage *)superImage atFrame:(CGRect)frame
{
    CGSize superSize = superImage.size;
    CGFloat widthScale = frame.size.width / self.frame.size.width;
    CGFloat heightScale = frame.size.height / self.frame.size.height;
    CGFloat xScale = frame.origin.x / self.frame.size.width;
    CGFloat yScale = frame.origin.y / self.frame.size.height;
    CGRect subFrame = CGRectMake(xScale * superSize.width, yScale * superSize.height, widthScale * superSize.width, heightScale * superSize.height);
    
    UIGraphicsBeginImageContext(superSize);
    [superImage drawInRect:CGRectMake(0, 0, superSize.width, superSize.height)];
    [subImage drawInRect:subFrame];
    __autoreleasing UIImage *finish = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finish;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

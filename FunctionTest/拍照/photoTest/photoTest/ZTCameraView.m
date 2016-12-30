//
//  ZTCameraView.m
//  TCamera
//
//  Created by 苏章桐 on 15/5/14.
//  Copyright (c) 2015年 changheng. All rights reserved.
//

/*
 1.创建session
 2.设置output和图层
 3.根据前后摄像头设置input
 */

#import "ZTCameraView.h"
#import <ImageIO/ImageIO.h>
@interface ZTCameraView()

@end
@implementation ZTCameraView

#pragma mark - < init > -
- (instancetype)initWithFrame:(CGRect)frame DevicePosition:(DevicePosition)position
{
  
  self = [super initWithFrame:frame];
  
  if (self) {
    
    [self initCamera];
    [self customInitDataWithDevicePosition:position];
    
  }
  
  return self;
}

-(void)initCamera
{
  //session
  _session = [[AVCaptureSession alloc] init];
  
  //设置output，以jpeg格式输出
  _stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
  NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
  [_stillImageOutput setOutputSettings:outputSettings];
  
  //把output加入到session
  if ([_session canAddOutput:_stillImageOutput]) {
    [_session addOutput:_stillImageOutput];
  }
  
  //预览图层
  _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
  
  CGRect bounds = [self bounds];
  [self.previewLayer setFrame:bounds];
  [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
  
  [self.layer setMasksToBounds:YES];
  [self.layer insertSublayer:self.previewLayer below:[[self.layer sublayers] objectAtIndex:0]];
  
  //启动session
  [self start];
}

-(void)customInitDataWithDevicePosition:(DevicePosition)position
{
  self.isSaveMask = NO;
  _isRun = YES;
  self.devicePosition= position;//设置
  
}

#pragma mark - < set/get > -

-(void)setDevicePosition:(DevicePosition)devicePosition
{
  //拍照方向跟之前一致则推出
  if (_devicePosition == devicePosition && self.device) {
    return;
  }
  
  _devicePosition = devicePosition;
  
  //获取device 设置input
  NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
  for (AVCaptureDevice *device in devices) {
    NSLog(@"Device name: %@", [device localizedName]);

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

-(void)setDevice:(AVCaptureDevice *)device
{
  _device = device;
  
  //修改input
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
      //开始设置session
      [self.session beginConfiguration];
      
      //去掉旧input 插入input
      [self.session removeInput:self.videoInput];
      if ([self.session canAddInput:newVideoInput]) {
        [self.session addInput:newVideoInput];
        self.videoInput = newVideoInput;
      } else {
        [self.session addInput:self.videoInput];
      }
      
      //提交设置
      [self.session commitConfiguration];
    } else if (error) {
      NSLog(@"toggle carema failed, error = %@", error);
    }
  }
  
}


#pragma mark - < method > -
/**
 *  开始session
 */
-(void)start
{
  if (self.session) {
    _isRun = YES;
    [self.session startRunning];
  }
}

/**
 *  停止拍照
 */
-(void)stop{
  if (self.session) {
    _isRun = NO;
    [self.session stopRunning];
  }
}

-(void)changeExif
{
  AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
  [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection
                                                     completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error)
   {
     NSData *imageNSData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
     
     CGImageSourceRef imgSource = CGImageSourceCreateWithData((__bridge_retained CFDataRef)imageNSData, NULL);
     
     //get all the metadata in the image
     NSDictionary *metadata = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(imgSource, 0, NULL);
     
     //make the metadata dictionary mutable so we can add properties to it
     NSMutableDictionary *metadataAsMutable = [metadata mutableCopy];
     
     NSMutableDictionary *EXIFDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyExifDictionary]mutableCopy];
     NSMutableDictionary *GPSDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyGPSDictionary]mutableCopy];
     NSMutableDictionary *RAWDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyRawDictionary]mutableCopy];
     
     if(!EXIFDictionary)
       EXIFDictionary = [[NSMutableDictionary dictionary] init];
     
     if(!GPSDictionary)
       GPSDictionary = [[NSMutableDictionary dictionary] init];
     
     if(!RAWDictionary)
       RAWDictionary = [[NSMutableDictionary dictionary] init];
     
     
     [GPSDictionary setObject:[NSNumber numberWithFloat:37.795]
                       forKey:(NSString*)kCGImagePropertyGPSLatitude];
     
     [GPSDictionary setObject:@"N" forKey:(NSString*)kCGImagePropertyGPSLatitudeRef];
     
     [GPSDictionary setObject:[NSNumber numberWithFloat:122.410]
                       forKey:(NSString*)kCGImagePropertyGPSLongitude];
     
     [GPSDictionary setObject:@"W" forKey:(NSString*)kCGImagePropertyGPSLongitudeRef];
     
     [GPSDictionary setObject:@"2012:10:18"
                       forKey:(NSString*)kCGImagePropertyGPSDateStamp];
     
     [GPSDictionary setObject:[NSNumber numberWithFloat:300]
                       forKey:(NSString*)kCGImagePropertyGPSImgDirection];
     
     [GPSDictionary setObject:[NSNumber numberWithFloat:37.795]
                       forKey:(NSString*)kCGImagePropertyGPSDestLatitude];
     
     [GPSDictionary setObject:@"N" forKey:(NSString*)kCGImagePropertyGPSDestLatitudeRef];
     
     [GPSDictionary setObject:[NSNumber numberWithFloat:122.410]
                       forKey:(NSString*)kCGImagePropertyGPSDestLongitude];
     
     [GPSDictionary setObject:@"W" forKey:(NSString*)kCGImagePropertyGPSDestLongitudeRef];
     
     [EXIFDictionary setObject:@"[S.D.] kCGImagePropertyExifUserComment"
                        forKey:(NSString *)kCGImagePropertyExifUserComment];
     
     [EXIFDictionary setObject:[NSNumber numberWithFloat:69.999]
                        forKey:(NSString*)kCGImagePropertyExifSubjectDistance];
     
     
     //Add the modified Data back into the image’s metadata
     [metadataAsMutable setObject:EXIFDictionary forKey:(NSString *)kCGImagePropertyExifDictionary];
     [metadataAsMutable setObject:GPSDictionary forKey:(NSString *)kCGImagePropertyGPSDictionary];
     [metadataAsMutable setObject:RAWDictionary forKey:(NSString *)kCGImagePropertyRawDictionary];
     
     
     CFStringRef UTI = CGImageSourceGetType(imgSource); //this is the type of image (e.g., public.jpeg)
     
     //this will be the data CGImageDestinationRef will write into
     NSMutableData *newImageData = [NSMutableData data];
     
     CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)newImageData, UTI, 1, NULL);
     
     if(!destination)
       NSLog(@"***Could not create image destination ***");
     
     //add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
     CGImageDestinationAddImageFromSource(destination, imgSource, 0, (__bridge CFDictionaryRef) metadataAsMutable);
     
     //tell the destination to write the image data and metadata into our data object.
     //It will return false if something goes wrong
     BOOL success = NO;
     success = CGImageDestinationFinalize(destination);
     
     if(!success)
       NSLog(@"***Could not create data from image destination ***");
     
     CIImage *testImage = [CIImage imageWithData:newImageData];
     NSDictionary *propDict = [testImage properties];
     NSLog(@"Final properties %@", propDict);
     
   }];
}

#pragma mark - < action > -
/**
 *  切换摄像头
 */
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



/**
 *  拍照
 *
 *  @param shutterCamera block
 */
-(void)shutterCameraWithBlock:(ShutterCamera)shutterCamera{
  
  AVCaptureConnection * videoConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
  __block NSError *returnError = nil;
  __block UIImage *returnImage = nil;
  
  //如果没有设置input，则直接退出
  if (!videoConnection) {
    NSLog(@"take photo failed!");
    if (shutterCamera) {
      returnError = [NSError errorWithDomain:@"拍照失败" code:0 userInfo:nil];
      shutterCamera(nil,returnError);
    }
    return;
  }
  
  //获取照片
  [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
    
    if (imageDataSampleBuffer == NULL) {
      returnError = [NSError errorWithDomain:@"获取照片失败" code:0 userInfo:nil];
      shutterCamera(nil,returnError);
      return;
    }
    
    NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
    returnImage = [UIImage imageWithData:imageData];
    NSLog(@"image size = %@",NSStringFromCGSize(returnImage.size));
    
    if (_isSaveMask) {
      for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
          UIImageView *imageView = (UIImageView *)view;
          returnImage = [self composeImage:imageView.image toImage:returnImage atFrame:imageView.frame];
        }
      }
    }
    
    shutterCamera(returnImage,error);
  }];
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

#pragma mark 添加遮罩
/**
 *  添加遮罩
 *
 *  @param view view
 */
-(void)addMaskView:(UIView *)view
{
  view.userInteractionEnabled = YES;
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
  pan.minimumNumberOfTouches = 1;
  pan.maximumNumberOfTouches = 1;
  [view addGestureRecognizer:pan];
  
  [view setFrame:CGRectMake(10, 10, 50, 50)];
  [self addSubview:view];
  
}

-(void)panAction:(UIPanGestureRecognizer *)sender
{
  sender.view.center = [sender locationInView:self];
}






@end

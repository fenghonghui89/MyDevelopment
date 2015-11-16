//
//  CameraOverlayViewController.m
//  photoTest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//

#import "CameraOverlayViewController.h"
#import "ZTCameraView.h"
@interface CameraOverlayViewController ()
@property(nonatomic,strong)ZTCameraView *cameraView;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation CameraOverlayViewController

#pragma mark - < vc lifecycle > -
-(void)viewDidLoad
{
  [super viewDidLoad];
  [self customInitUI];
}

-(void)customInitUI
{
  [self.view setBackgroundColor:[UIColor whiteColor]];
  self.navigationController.navigationBar.translucent = NO;
  
  CGRect rect = self.view.bounds;
  rect.origin.x = 10;
  rect.origin.y = 10;
  rect.size.width = rect.size.width-20;
  rect.size.height = rect.size.height-20-44-20 - 50;
  ZTCameraView *ztccv = [[ZTCameraView alloc] initWithFrame:rect DevicePosition:DevicePositionBack];
  ztccv.isSaveMask = YES;
  [self.view addSubview:ztccv];
  self.cameraView = ztccv;
  
  CGFloat y = ztccv.frame.origin.y+ztccv.frame.size.height;
  UIButton *btn = [[UIButton alloc] init];
  [btn setTitle:@"拍照" forState:UIControlStateNormal];
  [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [btn setBackgroundColor:[UIColor greenColor]];
  btn.showsTouchWhenHighlighted = YES;
  [btn sizeToFit];
  [btn setFrame:CGRectMake(0, y+10, btn.bounds.size.width, btn.bounds.size.height)];
  [btn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btn];
  
  UIButton *btn1 = [[UIButton alloc] init];
  [btn1 setTitle:@"停止拍照" forState:UIControlStateNormal];
  [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [btn1 setBackgroundColor:[UIColor greenColor]];
  btn1.showsTouchWhenHighlighted = YES;
  [btn1 sizeToFit];
  [btn1 setFrame:CGRectMake(100, y+10, btn1.bounds.size.width, btn1.bounds.size.height)];
  [btn1 addTarget:self action:@selector(stopTakePhoto) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btn1];
  
  UIButton *btn2 = [[UIButton alloc] init];
  [btn2 setTitle:@"切换摄像头" forState:UIControlStateNormal];
  [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [btn2 setBackgroundColor:[UIColor greenColor]];
  btn2.showsTouchWhenHighlighted = YES;
  [btn2 sizeToFit];
  [btn2 setFrame:CGRectMake(250, y+10, btn2.bounds.size.width, btn2.bounds.size.height)];
  [btn2 addTarget:self action:@selector(changeCamera) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btn2];
  

//  CGRect rect1 = self.view.bounds;
//  rect1.origin.x = 10;
//  rect1.origin.y = 10;
//  rect1.size.width = rect1.size.width-20;
//  rect1.size.height = rect1.size.height-20-44-20;
//
//  UIImageView *iv = [[UIImageView alloc] initWithFrame:rect1];
//  [iv setBackgroundColor:[UIColor orangeColor]];
//  [iv setFrame:rect1];
//  iv.contentMode = UIViewContentModeScaleAspectFit;
//  [self.view addSubview:iv];
}

#pragma mark - < action > -
-(void)takePhoto
{
  [self.cameraView shutterCameraWithBlock:^(UIImage *image, NSError *error) {
    if (error) {
      NSLog(@"收到error:%@",error.domain);
    }else{
      CGRect rect1 = [[UIScreen mainScreen] bounds];
      rect1.origin.x = 10;
      rect1.origin.y = 10;
      rect1.size.width = rect1.size.width-20;
      rect1.size.height = rect1.size.height-20-44-20;
      UIImageView *iv = [[UIImageView alloc] initWithImage:image];
      [iv setBackgroundColor:[UIColor orangeColor]];
      [iv setFrame:rect1];
      iv.contentMode = UIViewContentModeScaleAspectFit;
      [self.view addSubview:iv];
      self.imageView = iv;
      
      UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap11:)];
      [iv setUserInteractionEnabled:YES];
      [iv addGestureRecognizer:tapGR];
      
//      //保存到相册
//      UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
//      
//      //获取图片大小
//      NSData* data = UIImageJPEGRepresentation(image, 1.0);
//      NSInteger dataSize = data.length/1000;
//      NSLog(@"图片大小JPG:%d",dataSize);
//      
//      data = UIImagePNGRepresentation(image);
//      dataSize = data.length/1000;
//      NSLog(@"图片大小PNG:%d",dataSize);
    }
  }];
}

-(void)stopTakePhoto
{
  if (_cameraView.isRun == YES) {
    [_cameraView stop];
  }else{
    [_cameraView start];
  }
}

-(void)changeCamera
{
  [_cameraView toggleCamera];
}

-(void)tap11:(UITapGestureRecognizer *)sender
{
  [sender.view removeFromSuperview];
}
#pragma mark - < callback > -
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
  NSLog(@"保存到相册成功");
}
@end

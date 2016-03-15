//
//  ViewController.m
//  CropImage
//
//  Created by 杨 烽 on 12-10-24.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "UIImage+Resize.h"
#import "VPImageCropperViewController.h"
@interface ViewController ()<VPImageCropperDelegate>

@end

@implementation ViewController

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad{
  [super viewDidLoad];
  [self customInitUI];
}

#pragma mark - < method > -
-(void)customInitUI{
  
//  UIImage *img = [UIImage imageNamed:@"5682x.png"];
//  NSLog(@"img:%@ screen:%@",NSStringFromCGSize(img.size),NSStringFromCGSize([[UIScreen mainScreen] bounds].size));
//  
//  _cropImageView = [[KICropImageView alloc] initWithFrame:self.view.bounds];
//  [_cropImageView setCropSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width-20, [[UIScreen mainScreen] bounds].size.width-20)];
//  [_cropImageView setImage:img];
//  
//  
//  [self.view addSubview:_cropImageView];
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [btn setFrame:CGRectMake(80, 31, 150, 31)];
  [btn setTitle:@"crop and save" forState:UIControlStateNormal];
  [self.view addSubview:btn];
  [btn addTarget:self action:@selector(btnTap) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - < action > -
- (void)btnTap {
//  NSData *data = UIImagePNGRepresentation([_cropImageView cropImage]);
//  NSLog(@"%@",[NSString stringWithFormat:@"%@/Documents/test.png", NSHomeDirectory()]);
//  [data writeToFile:[NSString stringWithFormat:@"%@/Documents/test.png", NSHomeDirectory()] atomically:YES];
  
  
//  UIImage *img = [UIImage imageNamed:@"systemphoto.jpg"];
//  NSLog(@"img:%@ screen:%@ imageOrientation:%d",NSStringFromCGSize(img.size),NSStringFromCGSize([[UIScreen mainScreen] bounds].size),img.imageOrientation);
//  
//  if (img.imageOrientation == UIImageOrientationUp || img.imageOrientation == UIImageOrientationDown) {
//    
//  }else{
//    //最终尺寸
//    CGFloat r = img.size.width/1080.f;
//    CGFloat w = img.size.width/r;
//    CGFloat h = img.size.height/r;
//    CGSize size = CGSizeMake(w, h);
//    img = [img resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:size interpolationQuality:kCGInterpolationHigh];
//  }
//  
//  VPImageCropperViewController *vc = [[VPImageCropperViewController alloc] initWithImage:img cropFrame:CGRectMake(50, 100, [[UIScreen mainScreen] bounds].size.width-100, [[UIScreen mainScreen] bounds].size.width-100) limitScaleRatio:2];
//  vc.delegate = self;
//  [self presentViewController:vc animated:YES completion:nil];
  
  
  UIImage *img = [UIImage imageNamed:@"systemphoto.jpg"];
  VPImageCropperViewController *vc = [[VPImageCropperViewController alloc] init];
  vc.originalImage = img;
  vc.cropFrame = CGRectMake(20, 100, [[UIScreen mainScreen] bounds].size.width-40, [[UIScreen mainScreen] bounds].size.width-2.0);
  vc.limitRatio = 2;
  vc.delegate = self;
  [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - < callback > -

-(void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
  [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage{
//  NSData *data = UIImageJPEGRepresentation(editedImage, 1);
//  [data writeToFile:[NSString stringWithFormat:@"%@/Documents/test.png",NSHomeDirectory()] atomically:YES];
  
  ViewController1 *vc1 = [[ViewController1 alloc] initWithNibName:@"ViewController1" bundle:nil];
  vc1.photo = [editedImage copy];
  
  [cropperViewController dismissViewControllerAnimated:YES completion:nil];
  [self presentViewController:vc1 animated:YES completion:nil];
  
  
  NSLog(@"%@",[NSString stringWithFormat:@"%@/Documents/test.png", NSHomeDirectory()]);
}
@end

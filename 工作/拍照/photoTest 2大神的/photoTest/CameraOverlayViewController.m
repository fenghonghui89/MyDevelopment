//
//  CameraOverlayViewController.m
//  photoTest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//
// Transform values for full screen support:
#define CAMERA_TRANSFORM_X 1
// this works for iOS 4.x
#import "CameraOverlayViewController.h"

@interface CameraOverlayViewController ()

@end

@implementation CameraOverlayViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    UIImage *image = [UIImage imageNamed:@"IMG_0015.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    imageView.frame = self.view.frame;
    imageView.contentMode = UIViewContentModeScaleAspectFit;//缩放居中，保留全图，保持宽高比

}

@end

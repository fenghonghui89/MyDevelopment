//
//  ViewController.m
//  CropImage
//
//  Created by 杨 烽 on 12-10-24.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "ViewController.h"
#import "VPImageCropperViewController.h"
@interface ViewController ()<VPImageCropperDelegate>

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
//  UIImage *img = [UIImage imageNamed:@"5682x.png"];
//  NSLog(@"img:%@ screen:%@",NSStringFromCGSize(img.size),NSStringFromCGSize([[UIScreen mainScreen] bounds].size));
//
//  
//  
//  
//  
//    _cropImageView = [[KICropImageView alloc] initWithFrame:self.view.bounds];
//    [_cropImageView setCropSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width-20, [[UIScreen mainScreen] bounds].size.width-20)];
//    [_cropImageView setImage:img];
//    
//    
//    [self.view addSubview:_cropImageView];
  
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(80, 31, 150, 31)];
    [btn setTitle:@"crop and save" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(aa) forControlEvents:UIControlEventTouchUpInside];
}

- (void)aa {
//    NSData *data = UIImagePNGRepresentation([_cropImageView cropImage]);
//  NSLog(@"%@",[NSString stringWithFormat:@"%@/Documents/test.png", NSHomeDirectory()]);
//    [data writeToFile:[NSString stringWithFormat:@"%@/Documents/test.png", NSHomeDirectory()] atomically:YES];
  
  
  UIImage *img = [UIImage imageNamed:@"5682x.png"];
  NSLog(@"img:%@ screen:%@",NSStringFromCGSize(img.size),NSStringFromCGSize([[UIScreen mainScreen] bounds].size));

  VPImageCropperViewController *vc = [[VPImageCropperViewController alloc] initWithImage:img cropFrame:CGRectMake(50, 100, [[UIScreen mainScreen] bounds].size.width-100, [[UIScreen mainScreen] bounds].size.width-100) limitScaleRatio:3];
  vc.delegate = self;
  [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
  [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage{
  NSData *data = UIImageJPEGRepresentation(editedImage, 1);
  [data writeToFile:[NSString stringWithFormat:@"%@/Documents/test.png",NSHomeDirectory()] atomically:YES];
  [cropperViewController dismissViewControllerAnimated:YES completion:nil];
  NSLog(@"%@",[NSString stringWithFormat:@"%@/Documents/test.png", NSHomeDirectory()]);
}
@end

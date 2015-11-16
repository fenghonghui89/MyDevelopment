//
//  ViewController.m
//  imgtest
//
//  Created by 冯鸿辉 on 15/11/9.
//  Copyright © 2015年 DGC. All rights reserved.
//

#import "ViewController.h"
#import "SvImageInfoUtils.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iv;


@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"IMG_0015" withExtension:@"jpg"];
  
  SvImageInfoUtils *utils = [[SvImageInfoUtils alloc] initWithURL:fileUrl];
  
  NSLog(@"tiff %@",[utils tiffDictonary]);
  NSLog(@"exif %@",[utils exifDictionary]);
  NSLog(@"gps %@",[utils gpsDictionary]);
  NSLog(@"ip %@",[utils imageProperty]);
  UIImage *newiv = [utils getZipImageWithSourceExif:@"new"];
  [self.iv setImage:newiv];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end

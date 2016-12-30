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

- (void)viewDidLoad
{
  [super viewDidLoad];

  
  NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"IMG_0015" withExtension:@"jpg"];
  SvImageInfoUtils *utils = [[SvImageInfoUtils alloc] initWithURL:fileUrl];
  
  NSLog(@"tiff %@",[utils tiffDictonary]);
  NSLog(@"exif %@",[utils exifDictionary]);
  NSLog(@"gps %@",[utils gpsDictionary]);
  NSLog(@"ip %@",[utils imageProperty]);
  NSData *newiv = [utils getZipImageWithSourceExif:@"new"];
  
  
  
  
  UIImage *image = [UIImage imageNamed:@"IMG_0015.jpg"];
  NSData *imgData = UIImageJPEGRepresentation(image, 1);
  //Documents
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSLog(@"app_home_doc: %@",documentsDirectory);
  
  
  //保存图片
  NSFileManager *fm = [NSFileManager defaultManager];
  NSString *newZipPath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",@"lalala1"]];
  [fm createFileAtPath:newZipPath contents:imgData attributes:nil];

  
  
//  [utils removeBufferImg];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end

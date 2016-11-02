//
//  MD_UIActivityVC_VC.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/2.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_UIActivityVC_VC.h"
#import "ZSCustomActivity.h"

@interface MD_UIActivityVC_VC ()

@end

@implementation MD_UIActivityVC_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnTap:(id)sender {
  
  NSString *message = [NSString stringWithFormat:@"this is message"];
  NSString *subject = [NSString stringWithFormat:@"this is subject"];
  NSURL *url = [NSURL URLWithString:[@"http://tpages.cn" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
  UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://o9ivu69va.bkt.clouddn.com/images/testimg.jpg"]]];
  UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://o9ivu69va.bkt.clouddn.com/images/testimg1.jpg"]]];
  NSArray *files = @[img
//                     ,img1
                     ];
  NSArray *activityItems = @[message,subject,img,url];
  
  UIActivityViewController *ac = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[[[ZSCustomActivity alloc] init]]];
  ac.excludedActivityTypes = @[UIActivityTypeAirDrop];
//  [ac setValue:subject forKey:@"subject"];
  
  [self presentViewController:ac animated:YES completion:NULL];
}

@end

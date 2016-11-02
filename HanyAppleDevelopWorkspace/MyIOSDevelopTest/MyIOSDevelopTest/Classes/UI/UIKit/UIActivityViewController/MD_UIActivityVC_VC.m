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
  
  NSString *message = @"this is message..";
  NSString *subject = @"this is subject..";
  NSURL *url = [NSURL URLWithString:@"http://tpages.cn"];
  NSArray *files = @[
                     [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://o9ivu69va.bkt.clouddn.com/images/testimg1.jpg"]]],
                     [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://o9ivu69va.bkt.clouddn.com/images/testimg.jpg"]]]
                     ];
  NSArray *activityItems = @[message,subject,url,files];
  
  UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[[[ZSCustomActivity alloc] init]]];
  activity.excludedActivityTypes = @[UIActivityTypeAirDrop];
  
  
  [self presentViewController:activity animated:YES completion:NULL];
}

@end

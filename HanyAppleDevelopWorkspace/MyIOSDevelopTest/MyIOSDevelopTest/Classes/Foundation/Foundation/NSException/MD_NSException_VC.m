//
//  MD_NSException_VC.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/12/7.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSException_VC.h"

@interface MD_NSException_VC ()

@end

@implementation MD_NSException_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

-(void)test{
  [NSException raise:NSGenericException
              format:@"Set kFacebookAppId constant to your application subdomain"
           arguments:nil];
}

@end

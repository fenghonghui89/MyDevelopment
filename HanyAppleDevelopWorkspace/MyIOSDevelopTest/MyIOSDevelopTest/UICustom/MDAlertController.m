//
//  DGCAlertController.m
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/12/21.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import "MDAlertController.h"

@interface MDAlertController ()

@end

@implementation MDAlertController

+(MDAlertController *)alertDefaultControllerWithMessage:(NSString *)message{

  MDAlertController *vc = [super alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
  [vc addActionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:nil];
  return vc;
}

+(MDAlertController *)alertControllerWithTitle:(NSString * __nullable)title
                                        message:(NSString * __nullable)message
                                           type:(MDAlertType)type
                                          block:(void(^ __nullable)(bool run))block;
{
  MDAlertController *vc = [super alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

  __block MDAlertController *ac = vc;
  
  switch (type) {
    case MDAlertTypeTwoSelect:
    {
      [vc addActionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ac dismissViewControllerAnimated:YES completion:nil];
      }];
      [vc addActionWithTitle:NSLocalizedString(@"打开", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        block(YES);
      }];
    }
      break;
    case MDAlertTypeJustConfirm:
    {
      [vc addActionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:nil];
    }
      break;
    case MDAlertTypeNoAction:
      break;
    default:
      break;
  }
  
  return vc;
}

-(void)addActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler{
  
  UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:handler];
  [self addAction:action];
}


@end

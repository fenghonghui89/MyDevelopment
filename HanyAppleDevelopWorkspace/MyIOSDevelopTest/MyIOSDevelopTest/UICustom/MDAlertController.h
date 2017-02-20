//
//  MDAlertController.h
//  TpagesSNS
//
//  Created by 冯鸿辉 on 15/12/21.
//  Copyright © 2015年 NearKong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MDAlertType)
{
  MDAlertTypeJustConfirm = 1,
  MDAlertTypeNoAction = 2,
  MDAlertTypeTwoSelect = 3
};

NS_ASSUME_NONNULL_BEGIN
@interface MDAlertController : UIAlertController

-(void)addActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler;

+(MDAlertController *)alertDefaultControllerWithMessage:(NSString *)message;

+(MDAlertController *)alertControllerWithTitle:(NSString * __nullable)title
                                        message:(NSString * __nullable)message
                                           type:(MDAlertType)type
                                          block:(void(^ __nullable)(bool run))block;
@end
NS_ASSUME_NONNULL_END

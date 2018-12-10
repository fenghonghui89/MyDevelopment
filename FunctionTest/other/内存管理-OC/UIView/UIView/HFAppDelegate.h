//
//  HFAppDelegate.h
//  UIView
//
//  Created by hanyfeng on 14-3-27.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//
//页面跳转、单例、添加子view到父view或顶层window、删除子view

#import <UIKit/UIKit.h>
#import "HFViewController.h"
@interface HFAppDelegate : UIResponder <UIApplicationDelegate>
@property (retain, nonatomic) UIWindow *window;
@property(retain,nonatomic)HFViewController *vc;
@end

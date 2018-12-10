//
//  HFAppDelegate.h
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.

//网络请求时的内存管理-经过1个对象传递数据-MRC

#import <UIKit/UIKit.h>
#import "HFViewController.h"
@interface HFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)HFViewController *vc;
@end

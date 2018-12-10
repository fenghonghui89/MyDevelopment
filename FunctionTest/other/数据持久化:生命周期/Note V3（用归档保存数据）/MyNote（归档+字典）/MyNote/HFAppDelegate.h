//
//  HFAppDelegate.h
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//归档
//把数组归档，数组里面每一个元素是可变字典，用setValue:forKey:或setValue:forKeyPath:都可以
//用不可变字典会崩
#import <UIKit/UIKit.h>

@interface HFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

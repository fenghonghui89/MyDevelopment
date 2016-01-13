//
//  UIDeviceAdditionAppDelegate.h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//
//获取UDID（mac+bundleID）和UGDID（mac）
//把两者经过MD5加密后返回

#import <UIKit/UIKit.h>

@class UIDeviceAdditionViewController;

@interface UIDeviceAdditionAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIDeviceAdditionViewController *viewController;

@end

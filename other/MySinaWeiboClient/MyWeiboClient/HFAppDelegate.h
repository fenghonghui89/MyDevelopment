//
//  AppDelegate.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-14.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFLoginViewController.h"

@interface HFAppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>
@property(nonatomic,retain)UIWindow *window;
@property (retain,nonatomic)HFLoginViewController *loginVC;
@end

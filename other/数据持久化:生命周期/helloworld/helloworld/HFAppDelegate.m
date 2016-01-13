//
//  HFAppDelegate.m
//  helloworld
//
//  Created by hanyfeng on 14-5-21.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//


#import "HFAppDelegate.h"
#import "HFViewController.h"
@implementation HFAppDelegate

//由非活动状态进入前台
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"由非活动状态进入前台");
    UIApplicationDidFinishLaunchingNotification;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[HFViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

//准备离开前台
- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"准备离开前台");
    UIApplicationWillResignActiveNotification;
}

//已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"已经进入后台");
    UIApplicationDidEnterBackgroundNotification;
}

//准备进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"准备进入前台");
    UIApplicationWillEnterForegroundNotification;
}

//已经进入到前台
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"已经进入到前台");
    UIApplicationDidBecomeActiveNotification;
}

//应用被终止（不包括内存清除时）
- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"应用被终止（不包括内存清除时）");
    UIApplicationWillTerminateNotification;
}

@end

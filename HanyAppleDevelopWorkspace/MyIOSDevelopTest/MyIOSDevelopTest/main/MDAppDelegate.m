//
//  AppDelegate.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/12.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDClassesViewController.h"
#import "MDNavigationController.h"
#import "MDRootDefine.h"
#import "MDGlobalManager.h"
#import "MDLocalNotificationManager.h"
#import <stdio.h>
@import UserNotifications;

@interface MDAppDelegate ()

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *myTimer;

@end
@implementation MDAppDelegate

#pragma mark - < customize method >

#pragma mark * 推送

-(void)registerNotification:(NSDictionary *)launchOptions{
  
  //如果app处于未运行时收到推送，点击通知打开app之后会有userInfo
  NSDictionary *remoteNotiUserInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
  if (remoteNotiUserInfo) {
    ULog(@"未运行时收到推送 remoteNotiUserInfo..%@",remoteNotiUserInfo);
  }
  
  NSDictionary *localNotiUserInfo = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
  if (localNotiUserInfo) {
    ULog(@"未运行时收到推送 localNotiUserInfo..%@",localNotiUserInfo);
  }
  
  if ([MDGlobalManager sharedInstance].hasFirstLaunch == NO) {
    [[MDLocalNotificationManager sharedInstance] registerLocalNotification];
  }

}




#pragma mark * 后台延时
- (void) endBackgroundTask{
  
  dispatch_queue_t mainQueue = dispatch_get_main_queue();
  
  dispatch_async(mainQueue, ^(void) {
    
    [self.myTimer invalidate];
    
    //标记任务停止
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
    
    //销毁后台任务标识符
    self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    
  });
}


/**
 模拟的一个 Long-Running Task 方法
 
 @param paramSender paramSender
 */
- (void)timerMethod:(NSTimer *)paramSender{
  
  //backgroundTimeRemaining 属性包含了程序留给的我们的时间
  NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
  if (backgroundTimeRemaining == DBL_MAX){
    NSLog(@"Background Time Remaining = Undetermined");
  } else {
    NSLog(@"Background Time Remaining = %.02f Seconds", backgroundTimeRemaining);
  }
}

#pragma mark - < callback >
#pragma mark UIApplicationDelegate
#pragma mark * app lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  
  //开启日志输出
  [MDGlobalManager sharedInstance].openLog = YES;
  
  //默认启动摇晃
  [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
  
  //输出设备信息
  [[MDTool sharedInstance] showDeviceInfo];
  
  //注册推送
  [self registerNotification:launchOptions];
  
  //修改标识
  if ([MDGlobalManager sharedInstance].hasFirstLaunch == NO) {
    ULog(@"第一次运行，初始化完成");
    [MDGlobalManager sharedInstance].hasFirstLaunch = YES;
  }else{
    ULog(@"不是第一次运行，初始化完成");
  }
  
  //setup rootvc
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window setBackgroundColor:[UIColor whiteColor]];
  
  MDClassesViewController *vc = [[MDClassesViewController alloc] init];
  vc.data = [MDTool getPlistDataByName:@"TitleList"];
  MDNavigationController *navi = [[MDNavigationController alloc] initWithRootViewController:vc];
  
  self.window.rootViewController = navi;
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  
  //后台延时
  
  //  self.backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^(void) {
  //    NSLog(@"停止后台任务");
  //    [self endBackgroundTask];
  //  }];
  //
  //  //模拟一个Long-Running Task
  //  self.myTimer =[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
  
}


#pragma mark * 推送（ios9 or earlier）
//推送授权
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
  
  [[MDLocalNotificationManager sharedInstance] application:application didRegisterUserNotificationSettings:notificationSettings];
}

//远程推送
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  
  [[MDLocalNotificationManager sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
  [[MDLocalNotificationManager sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
  [[MDLocalNotificationManager sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
  [[MDLocalNotificationManager sharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

//本地推送
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  
  [[MDLocalNotificationManager sharedInstance] application:application didReceiveLocalNotification:notification];
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
  
  [[MDLocalNotificationManager sharedInstance] application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
}

@end

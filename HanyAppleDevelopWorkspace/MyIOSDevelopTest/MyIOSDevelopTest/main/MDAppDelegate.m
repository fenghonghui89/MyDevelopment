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
#import "MDPushNotificationManager.h"
#import <stdio.h>
@import UserNotifications;

@interface MDAppDelegate ()

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *myTimer;

@end
@implementation MDAppDelegate

#pragma mark - < customize method >


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
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

  //开启日志输出
  [MDGlobalManager sharedInstance].openLog = YES;
  
  //默认启动摇晃
  [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
  
  //输出设备信息
  [[MDTool sharedInstance] showDeviceInfo];
  
  /*
   第一次运行时，向用户获取通知授权
    - 允许，系统推送打开，服务器发送推送，本地作标识
    - 不允许，系统推送不打开，服务器不发送推送，本地作标识
   */
  if ([MDGlobalManager sharedInstance].hasFirstLaunch == NO) {
    [[MDPushNotificationManager sharedInstance] registerNotification];
  }
  
  //修改标识
  if ([MDGlobalManager sharedInstance].hasFirstLaunch == NO) {
    ULog(@"第一次运行，初始化完成");
    [MDGlobalManager sharedInstance].hasFirstLaunch = YES;
  }else{
    ULog(@"不是第一次运行，初始化完成");
  }

  //
  
  return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  
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
  ULog(@"applicationWillResignActive..");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  ULog(@"applicationDidEnterBackground..");
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
  ULog(@"applicationWillEnterForeground..");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  ULog(@"applicationDidBecomeActive..");
}

- (void)applicationWillTerminate:(UIApplication *)application {
  ULog(@"applicationWillTerminate..");
}


#pragma mark * 推送（ios9 or earlier）
//推送授权
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
  
  [[MDPushNotificationManager sharedInstance] application:application didRegisterUserNotificationSettings:notificationSettings];
}

//远程推送
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  
  [[MDPushNotificationManager sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
  [[MDPushNotificationManager sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
  [[MDPushNotificationManager sharedInstance] application:application didReceiveRemoteNotification:userInfo];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
  [[MDPushNotificationManager sharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

//本地推送
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  
  [[MDPushNotificationManager sharedInstance] application:application didReceiveLocalNotification:notification];
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
  
  [[MDPushNotificationManager sharedInstance] application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
}

@end

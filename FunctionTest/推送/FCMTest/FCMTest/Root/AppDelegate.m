//
//  AppDelegate.m
//  FCMTest
//
//  Created by 冯鸿辉 on 2016/11/22.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "AppDelegate.h"
#import "MDPushNotificationManager.h"
#import "MDGlobalManager.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

  //开启日志记录
  [MDGlobalManager sharedInstance].openLog = YES;
  
  /*
   第一次运行时，向用户获取通知授权
   - 允许，系统推送打开，服务器发送推送，本地作标识
   - 不允许，系统推送不打开，服务器不发送推送，本地作标识
   */
  if ([MDGlobalManager sharedInstance].hasFirstLaunch == NO) {
    [[MDPushNotificationManager sharedInstance] registerNotification];
  }
  
  //修改标识
  if([MDGlobalManager sharedInstance].hasFirstLaunch == NO) {
    ULog(@"第一次运行，初始化完成");
    [MDGlobalManager sharedInstance].hasFirstLaunch = YES;
  }else{
    ULog(@"不是第一次运行，初始化完成");
  }
  
  //如果app处于未运行时收到推送，点击通知打开app之后会有userInfo，点击appicon不会有
  NSDictionary *remoteNotiUserInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
  if (remoteNotiUserInfo) {
    ULog(@"未运行时收到推送 remoteNotiUserInfo..%@",remoteNotiUserInfo);
    [[MDGlobalManager sharedInstance] storeData:launchOptions];
  }else{
    ULog(@"未运行时未收到推送 remoteNotiUserInfo..%@",remoteNotiUserInfo);
  }

  return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.window setBackgroundColor:[UIColor orangeColor]];
  ViewController *vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
  UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
  self.window.rootViewController = nc;
  [self.window makeKeyAndVisible];
  
  return YES;
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
  
  [[MDPushNotificationManager sharedInstance] application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
  
  [[MDPushNotificationManager sharedInstance] application:application didReceiveRemoteNotification:userInfo];
  
}

- (void)applicationWillResignActive:(UIApplication *)application {
  
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  
  [[MDPushNotificationManager sharedInstance] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  
  [[MDPushNotificationManager sharedInstance] applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//  
//  [[MDPushNotificationManager sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
//}
//
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//  
//  [[MDPushNotificationManager sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
//}



@end

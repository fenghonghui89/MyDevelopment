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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  [MDGlobalManager sharedInstance].openLog = YES;
  
  [[MDPushNotificationManager sharedInstance] registerLocalNotification];
  
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

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  
  [[MDPushNotificationManager sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  
  [[MDPushNotificationManager sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}



@end

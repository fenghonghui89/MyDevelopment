//
//  AppDelegate.m
//  UMengPush
//
//  Created by 冯鸿辉 on 16/3/31.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "AppDelegate.h"
#import "UMessage.h"
#import "UMengPushManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark app vclifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  [[UMengPushManager sharedManager] startPush:launchOptions];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark remote noti
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
  
  NSLog(@"~didRegisterUserNotificationSettings");
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  
  NSString *dt = [[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""];
  dt = [dt stringByReplacingOccurrencesOfString:@">" withString:@""];
  dt = [dt stringByReplacingOccurrencesOfString:@" " withString:@""];
  NSLog(@"~device token:%@",dt);
  
  NSString *dtOld = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
  if ([dt isEqualToString:dtOld]) {
    NSLog(@"一样");
  }else{
    NSLog(@"不一样");
    [[NSUserDefaults standardUserDefaults] setObject:dt forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:@"initUI" object:nil];
  
  [[UMengPushManager sharedManager] registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
  
  NSLog(@"~useInfo:%@ %@",[userInfo objectForKey:@"k2"],[userInfo objectForKey:@"k22"]);
  
//  NSInteger w = [[UIScreen mainScreen] bounds].size.width;
//  NSInteger h = [[UIScreen mainScreen] bounds].size.height;
//  CGFloat x = arc4random()%(w-100);
//  CGFloat y = arc4random()%(h-50);
//  UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 100, 50)];
//  [lab setBackgroundColor:[UIColor blueColor]];
//  [lab setTextColor:[UIColor whiteColor]];
//  [lab setText:[NSString stringWithFormat:@"%@ - %@",[userInfo objectForKey:@"k2"],[userInfo objectForKey:@"k22"]]];
//  [self.window.rootViewController.view addSubview:lab];
  
  [[UMengPushManager sharedManager] didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
  
  NSLog(@"~application:didFailToRegisterForRemoteNotificationsWithError: %@", [error localizedDescription]);
}
@end

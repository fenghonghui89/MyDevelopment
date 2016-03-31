//
//  AppDelegate.m
//  pushTest
//
//  Created by hanyfeng on 15/3/24.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  UIUserNotificationSettings *setting =[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
  [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
  [application registerForRemoteNotifications];
  return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  NSString *decToken = [NSString stringWithFormat:@"%@", deviceToken];
  NSLog(@"decToken get:%@",decToken);
  
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  NSString *dt = [ud objectForKey:@"deviceToken"];

  if ([dt isEqualToString:decToken]) {
    NSLog(@"一样");
  }else{
    NSLog(@"不一样");
    [ud setObject:decToken forKey:@"deviceToken"];
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"不一样" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [av show];
  }
//  
//  
//  //获取到之后要去掉尖括号和中间的空格
//  NSMutableString *st = [NSMutableString stringWithString:decToken];
//  [st deleteCharactersInRange:NSMakeRange(0, 1)];
//  [st deleteCharactersInRange:NSMakeRange(st.length-1, 1)];
//  NSString *string1 = [st stringByReplacingOccurrencesOfString:@" " withString:@""];
//  NSLog(@"decToken change:%@",string1);
//  
//  
//  [ud setObject:string1 forKey:@"deviceTokenChange"];
  [ud synchronize];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
  NSString *errorStr = [NSString stringWithFormat:@"%@",[error description]];
  NSLog(@"error:%@",errorStr);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
  NSLog(@"Receive remote notification : %@",userInfo);
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
  [alert show];
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

@end

//
//  MDPushNotificationManager+RemoteNotification.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2017/3/9.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//
/*
 在info.plist添加以下，则就算用户关闭本地推送开关，依然能请求到device token：
 Required background modes - App downloads content in response to push notifications
 */

#import "MDPushNotificationManager+RemoteNotification.h"
#import "MDRootDefine.h"

@implementation MDPushNotificationManager (RemoteNotification)

#pragma mark - < customize method >
/**
 注册远程推送以token
 支持设备：all ios version
 */
-(void)registerForRemoteNotifications{
  
  [[UIApplication sharedApplication] registerForRemoteNotifications];
}

#pragma mark * hook
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  
  NSString *decToken = [NSString stringWithFormat:@"%@", deviceToken];
  ULog(@"decToken get..:%@",decToken);
  
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  NSString *dt = [ud objectForKey:@"deviceToken"];
  
  if ([dt isEqualToString:decToken]) {
    ULog(@"decToken一样..");
  }else{
    ULog(@"decToken不一样..");
    [ud setObject:decToken forKey:@"deviceToken"];
  }
  
  [ud synchronize];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
  
  ULog(@"fail to register remote noti error..:%@",error.localizedDescription);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
  
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
  
  completionHandler(UIBackgroundFetchResultNoData);
}



@end

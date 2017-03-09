//
//  MDPushNotificationManager+RemoteNotification.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2017/3/9.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "MDPushNotificationManager.h"

@interface MDPushNotificationManager (RemoteNotification)


-(void)registerForRemoteNotifications;



-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
@end

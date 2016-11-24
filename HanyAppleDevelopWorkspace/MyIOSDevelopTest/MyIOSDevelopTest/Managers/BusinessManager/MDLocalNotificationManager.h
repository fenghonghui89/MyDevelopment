//
//  MDNotificationManager.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MDLocalNotificationManager : NSObject
+(MDLocalNotificationManager *)sharedInstance;
-(void)registerLocalNotification;
-(void)cancleAllNotifications;
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings;
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler;
@end

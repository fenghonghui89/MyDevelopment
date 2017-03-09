//
//  MDPushNotificationManager+LocalNotification.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2017/3/9.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "MDPushNotificationManager.h"

@interface MDPushNotificationManager (LocalNotification)

-(void)scheduleLocalNotification;

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler;
@end

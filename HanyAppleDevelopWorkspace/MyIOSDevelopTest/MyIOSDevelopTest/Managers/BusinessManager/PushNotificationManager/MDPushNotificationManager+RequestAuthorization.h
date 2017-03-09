//
//  MDPushNotificationManager+RequestAuth.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2017/3/9.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "MDPushNotificationManager.h"

@interface MDPushNotificationManager (RequestAuthorization)

-(void)requestAuthorization;

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings;
@end

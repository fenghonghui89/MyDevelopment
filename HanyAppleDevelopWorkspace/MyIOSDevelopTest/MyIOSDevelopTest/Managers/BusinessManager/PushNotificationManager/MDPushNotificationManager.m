//
//  MDNotificationManager.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDPushNotificationManager.h"
#import "MDRootDefine.h"
#import "MDGlobalManager.h"

#import "MDPushNotificationManager+RequestAuthorization.h"
#import "MDPushNotificationManager+RemoteNotification.h"

@import UserNotifications;
@interface MDPushNotificationManager()<UNUserNotificationCenterDelegate>

@end

@implementation MDPushNotificationManager

#pragma mark - < customize method >
+(MDPushNotificationManager *)sharedInstance{
  
  static MDPushNotificationManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}


-(void)start{
  
  //请求授权，打开通知开关以接收推送信息
  [self requestAuthorization];
  
  //注册远程推送
  [self registerForRemoteNotifications];
}



/**
 关闭推送
 */
-(void)cancleAllNotifications{
  
  if ((floor)(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_9_x_Max)
  {
    ULog(@"ios9 or earlier cancleAllNotifications..");
    [UIApplication sharedApplication].scheduledLocalNotifications = nil;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
  }
  else
  {
    ULog(@"ios10 or later cancleAllNotifications..");
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
  }
}




@end

//
//  MDPushNotificationManager+LocalNotification.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2017/3/9.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "MDPushNotificationManager+LocalNotification.h"
#import "MDRootDefine.h"
@import UserNotifications;
@implementation MDPushNotificationManager (LocalNotification)


#pragma mark - < customize method >
-(void)scheduleLocalNotification{
  
  if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max)
  {
    ULog(@"[8,9] schedule localNoti..");
    
    [self scheduleLocalNotification_old];
  }

  else
  {
    ULog(@"[10,~] schedule localNoti..");
    
    [self scheduleLocalNotification_new];
    
  }
}


/**
 调度本地推送
 支持设备：ios4 or later
 注意：重复推送时，只会在第一次进入方法
 */
-(void)scheduleLocalNotification_old{
  
  UILocalNotification* noti = [[UILocalNotification alloc] init];
  
  noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];//设置第一条的触发时间，不设置就会马上触发
  noti.repeatInterval = NSCalendarUnitMinute;//重复间隔
  noti.alertBody = [NSString stringWithFormat:@"this is ios9 alertBody.."];
  noti.alertAction = [NSString stringWithFormat:@"this is ios9 alertAction.."];
  noti.timeZone = [NSTimeZone defaultTimeZone];
  noti.hasAction = YES;
  noti.applicationIconBadgeNumber = 1;//设置应用图标右上角显示的数字
  noti.soundName = UILocalNotificationDefaultSoundName;//通知被触发时播放的声音
  noti.userInfo = @{@"name":[NSString stringWithFormat:@"ios9 zhansan"]};//传参
  noti.category = @"category1";//不设置则无法下拉出action
  
  
  //调度
  [[UIApplication sharedApplication] scheduleLocalNotification:noti];
}

/**
 调度本地推送
 支持设备：ios10 or later
 注意：重复推送时，只会在第一次进入方法
 */
-(void)scheduleLocalNotification_new{
  //设置推送内容
  UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
  content.title = [NSString stringWithFormat:@"this is ios10 title.."];
  content.subtitle = [NSString stringWithFormat:@"this is ios10 subtitle.."];
  content.body = [NSString stringWithFormat:@"this is ios10 body.."];
  content.badge = @1;
  content.userInfo = @{@"name":[NSString stringWithFormat:@"ios10 zhansan"]};
  content.sound = [UNNotificationSound defaultSound];
  
  UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60 repeats:YES];//最少60s
  
  NSString *requestIdentifier = @"ios10localnoti";
  
  UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier
                                                                        content:content
                                                                        trigger:timeTrigger];
  
  
  //调度推送
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    if (error)
    {
      ULog(@"ios10 addNotificationRequest error..%@",error);
    }
    else
    {
      ULog(@"ios10 addNotificationRequest success..");
    }
  }];
}

#pragma mark * hook
/*
 app在前台，直接回调该方法
 app在后台，点击通知返回应用时会调用该方法
 */
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  
  //获取数据
  NSString* value = [notification.userInfo objectForKey:@"name"];
  ULog(@"[8,9] value = %@",value);
  
  //角标清零
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  
}

//点击下拉的action后
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
  
  //获取action和数据
  NSString* value = [notification.userInfo objectForKey:@"name"];
  ULog(@"[8,9] identifier..%@ value = %@",identifier,value);
  
  //角标清零
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  
  completionHandler();
}

@end

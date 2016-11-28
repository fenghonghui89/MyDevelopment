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
@import UserNotifications;
@interface MDPushNotificationManager()<UNUserNotificationCenterDelegate>

@end

@implementation MDPushNotificationManager

#pragma mark - < method >
+(MDPushNotificationManager *)sharedInstance{
  
  static MDPushNotificationManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

//注册推送
-(void)registerNotification{
  
  //ios9 or earlier register
  if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max)
  {
    ULog(@"ios9 or earlier auth..");
    
    //type
    UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    
    //categories
    //点击action不会自动取消角标和通知
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = @"action1_identifier";
    action1.title=@"Accept..";
    action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
    action2.identifier = @"action2_identifier";
    action2.title=@"Reject..";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action2.destructive = YES;
    
    UIMutableUserNotificationCategory *actionCategory = [[UIMutableUserNotificationCategory alloc] init];
    actionCategory.identifier = @"category1";//这组动作的唯一标示
    [actionCategory setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
    NSSet *categories = [NSSet setWithObject:actionCategory];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
  }
  
  //ios10 or later register
  else
  {
    ULog(@"ios10 or later auth..");
    
    //category
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"reply" title:@"Reply.." options:UNNotificationActionOptionNone];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"cancle" title:@"Cancle.." options:UNNotificationActionOptionNone];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"category"
                                                                              actions:@[action1,action2]
                                                                    intentIdentifiers:@[]
                                                                              options:UNNotificationCategoryOptionCustomDismissAction];
    NSSet *categorys = [NSSet setWithArray:@[category]];
    
    //center
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center setNotificationCategories:categorys];
    center.delegate = self;
    
    //授权
    UNAuthorizationOptions allAuthorizationOptions = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
    [center requestAuthorizationWithOptions:allAuthorizationOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
      if (error)
      {
        ULog(@"ios10 requestAuthorizationWithOptions error..%@",error.localizedDescription);
      }
      else
      {
        if (granted)
        {
          ULog(@"ios10 requestAuthorizationWithOptions granted..");
          
          //设置标识
          [MDGlobalManager sharedInstance].isOpenNotification = YES;

          //调度本地推送推送
//          [self scheduleLocalNotification];
          
          //获取当前的通知设置
          [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            ULog(@"ios10 getNotificationSettingsWithCompletionHandler type..%ld",(long)settings.authorizationStatus);
          }];
        }
        else
        {
          ULog(@"ios10 requestAuthorizationWithOptions no granted..");
          
          //设置标识
          [MDGlobalManager sharedInstance].isOpenNotification = NO;
          
          //清空推送
          [self cancleAllNotifications];
        }
      }
    }];
    
    
  }
  
  //注册token
  [[UIApplication sharedApplication] registerForRemoteNotifications];
  
}



/**
 调度推送 注意：重复推送时，只会在第一次进入方法
 */
-(void)scheduleLocalNotification{

  //ios9 or earlier
  if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max)
  {
    ULog(@"ios9 or earlier schedule localNoti..");
    
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
    
    
    //调度推送
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
  }
  
  //ios10 or later
  else
  {
    ULog(@"ios10 or later schedule localNoti..");
    
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
}

//关闭推送
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

#pragma mark - < action >
#pragma mark ios9 or earlier
//请求授权后
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
  
  ULog(@"ios9 didRegisterUserNotificationSettings type..%lu",(unsigned long)notificationSettings.types);
  if (notificationSettings.types>0)
  {
    //设置标识
    [MDGlobalManager sharedInstance].isOpenNotification = YES;
    
    //调度本地推送
//    [self scheduleLocalNotification];
  }
  else
  {
    //设置标识
    [MDGlobalManager sharedInstance].isOpenNotification = NO;
    
    //清空推送
    [self cancleAllNotifications];
  }
}

/*
 app在前台，直接调用该方法
 app在后台，点击通知返回应用时会调用该方法
 */
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  
  //获取数据
  NSString* value = [notification.userInfo objectForKey:@"name"];
  ULog(@"ios9 value = %@",value);
  
  //角标清零
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

}

//点击下拉的action后
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
  
  //获取action和数据
  NSString* value = [notification.userInfo objectForKey:@"name"];
  ULog(@"ios9 identifier..%@ value = %@",identifier,value);
  
  //角标清零
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

  completionHandler();
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  
  NSString *decToken = [NSString stringWithFormat:@"%@", deviceToken];
  ULog(@"ios9/10 decToken get:%@",decToken);
  
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  NSString *dt = [ud objectForKey:@"deviceToken"];
  
  if ([dt isEqualToString:decToken]) {
    ULog(@"decToken一样");
  }else{
    ULog(@"decToken不一样");
    [ud setObject:decToken forKey:@"deviceToken"];
  }
  
  [ud synchronize];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
  
  ULog(@"ios9/10 fail to register remote noti error..%@",error.localizedDescription);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
  
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
  
  completionHandler(UIBackgroundFetchResultNoData);
}

#pragma mark - < callback >
#pragma mark * ios10 or later UNUserNotificationCenterDelegate
/*
 app在前台:在展示通知前进行处理，即有机会在展示通知前再修改通知内容(有时候不会触发？)
 app在后台:不会触发
 */
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{

  //获取数据
  NSString* value = [notification.request.content.userInfo objectForKey:@"name"];
  ULog(@"ios10 willPresentNotification value = %@",value);
  
  //处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
  completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound);
}

//无论app在前台还是后台，点击推送或按钮的响应
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
  
  //获取数据
  NSString* value = [response.notification.request.content.userInfo objectForKey:@"name"];
  ULog(@"ios10 didReceiveNotificationResponse value = %@",value);
  
  //角标清零 清除该通知
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[response.notification]];
  
  completionHandler();

}


@end

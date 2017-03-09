//
//  MDPushNotificationManager+RequestAuth.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2017/3/9.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "MDPushNotificationManager+RequestAuthorization.h"
#import "MDRootDefine.h"
@import UserNotifications;


@interface MDPushNotificationManager ()<UNUserNotificationCenterDelegate>

@end

@implementation MDPushNotificationManager (RequestAuthorization)


#pragma mark - < customize method >
#pragma mark * requestAuthorization
-(void)requestAuthorization{
  
//  if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max)
//  {
//    ULog(@"[8,9] device's auth..");
//    [self requestAuthorization_old];
//  }
//
//  else
//  {
//    ULog(@"[10,~] device's auth..");
//    [self requestAuthorization_new];
//  }

  [self requestAuthorization_old];
}

/**
 请求用户授权 远程推送/本地推送都要
 支持设备：ios8 or later
 */
-(void)requestAuthorization_old{
  
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

/**
 请求用户授权 远程推送/本地推送都要
 支持设备：ios10 or later
 */
-(void)requestAuthorization_new{
  
  
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
      ULog(@"[10,~] requestAuthorizationWithOptions error..%@",error.localizedDescription);
    }
    else
    {
      if (granted)
      {
        ULog(@"[10,~] requestAuthorizationWithOptions granted..");
        
        //设置标识
        [MDGlobalManager sharedInstance].isOpenNotification = YES;
        
        //调度本地推送
        //          [self scheduleLocalNotification];
        
        //获取当前的通知设置
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
          ULog(@"[10,~] getNotificationSettingsWithCompletionHandler type..%ld",(long)settings.authorizationStatus);
        }];
      }
      else
      {
        ULog(@"[10,~] requestAuthorizationWithOptions no granted..");
        
        //设置标识
        [MDGlobalManager sharedInstance].isOpenNotification = NO;
        
        //清空推送
        [self cancleAllNotifications];
      }
    }
  }];

}

#pragma mark * hook
#pragma mark -- [8,9]
/**
 请求授权后
 支持设备：ios8 or later
 */
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
  
  ULog(@"[8,9] didRegisterUserNotificationSettings type..%lu",(unsigned long)notificationSettings.types);
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


#pragma mark - < callback >
#pragma mark * UNUserNotificationCenterDelegate
#pragma mark -- [10,~]
/*
 app在前台:在展示通知前进行处理，即有机会在展示通知前再修改通知内容(有时候不会触发？)
 app在后台:不会触发
 */
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
  
  //获取数据
  NSString* value = [notification.request.content.userInfo objectForKey:@"name"];
  ULog(@"[10,~] willPresentNotification value = %@",value);
  
  //处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
  completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound);
}

//无论app在前台还是后台，点击推送或按钮的响应
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
  
  //获取数据
  NSString* value = [response.notification.request.content.userInfo objectForKey:@"name"];
  ULog(@"[10,~] didReceiveNotificationResponse value = %@",value);
  
  //角标清零 清除该通知
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[response.notification]];
  
  completionHandler();
  
}
@end

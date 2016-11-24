//
//  MDNotificationManager.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDLocalNotificationManager.h"
#import "MDRootDefine.h"
#import "MDGlobalManager.h"
@import UserNotifications;
@interface MDLocalNotificationManager()<UNUserNotificationCenterDelegate>

@end

@implementation MDLocalNotificationManager

#pragma mark - < method >
+(MDLocalNotificationManager *)sharedInstance{
  
  static MDLocalNotificationManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

-(void)registerLocalNotification{
  
  //ios9 or earlier
  if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max)
  {
    ULog(@"ios9 or earlier auth..");
    
    //ios8以后提示授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
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
  }
  
  //ios10 or later
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
        ULog(@"requestAuthorizationWithOptions error..%@",error);
      }
      else
      {
        if (granted)
        {
          ULog(@"requestAuthorizationWithOptions granted..");
          
          [MDGlobalManager sharedInstance].isOpenNotification = YES;

          [self scheduleLocalNotification];
          
          //获取当前的通知设置
          [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            ULog(@"getNotificationSettingsWithCompletionHandler type..%ld",(long)settings.authorizationStatus);
          }];
        }
        else
        {
          ULog(@"requestAuthorizationWithOptions error..");
          
          [MDGlobalManager sharedInstance].isOpenNotification = NO;
          [self cancleAllNotifications];
        }
      }
    }];
    
    
  }
  
}

-(void)scheduleLocalNotification{

  //ios9 or earlier
  if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max)
  {
    ULog(@"ios9 or earlier set localNoti..");
    
    UILocalNotification* noti = [[UILocalNotification alloc] init];
    
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];//设置触发时间
    noti.repeatInterval = NSCalendarUnitMinute;//重复间隔
    noti.alertBody = @"this is ios9 alertBody..";
    noti.alertAction = @"this is ios9 alertAction..";
    noti.timeZone = [NSTimeZone defaultTimeZone];
    noti.hasAction = YES;
    noti.applicationIconBadgeNumber = 1;//设置应用图标右上角显示的数字
    noti.soundName = UILocalNotificationDefaultSoundName;//通知被触发时播放的声音
    noti.userInfo = @{@"name":@"zhangsan"};//传参
    noti.category = @"category1";//不设置则无法下拉出action
    
    //把通知添加进日程
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
  }
  
  //ios10 or later
  else
  {
    ULog(@"ios10 or later set localNoti..");
    
    //设置推送内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"this is ios10 title..";
    content.subtitle = @"this is ios10 subtitle..";
    content.body = @"this is ios10 body..";
    content.badge = @1;
    content.userInfo = @{@"name":@"zhansan"};
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:61 repeats:YES];
    
    NSString *requestIdentifier = @"ios10localnoti";
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier
                                                                          content:content
                                                                          trigger:timeTrigger];
    
    
    //add
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
      if (error)
      {
        ULog(@"addNotificationRequest error..%@",error);
      }
      else
      {
        ULog(@"addNotificationRequest success..");
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

#pragma mark - ios9 or earlier
//请求授权后
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
  
  ULog(@"typces count..%lu",(unsigned long)notificationSettings.types);
  if (notificationSettings.types>0)
  {
    [MDGlobalManager sharedInstance].isOpenNotification = YES;
    [self scheduleLocalNotification];
  }
  else
  {
    [MDGlobalManager sharedInstance].isOpenNotification = NO;
    [self cancleAllNotifications];
  }
}

//点击通知返回应用时会调用该方法
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  
  //接收传递的参数
  NSString* value = [notification.userInfo objectForKey:@"name"];
  ULog(@"ios9 value = %@",value);
  UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"ios9本地推送消息" message:value preferredStyle:UIAlertControllerStyleAlert];
  [ac addAction:[UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleCancel handler:nil]];
  [[MDTool getCurrentVC] presentViewController:ac animated:YES completion:nil];
  
  //角标清零
  [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  
}

//点击下拉的action后
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
  
  // 我们可以在这里获取标识符，根据标识符进行判断是前台按钮还是后台按钮还是神马按钮，进行相关逻辑处理（如回复消息）
  ULog(@"identifier : %@",identifier);
  // 一旦接受必须调用的方法（告诉系统什么时候结束，系统自己对内部进行资源调配）
  completionHandler();
}

#pragma mark - < callback >
#pragma mark * UNUserNotificationCenterDelegate
//在展示通知前进行处理，即有机会在展示通知前再修改通知内容
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{

  //接收传递的参数
  NSString* value = [notification.request.content.userInfo objectForKey:@"name"];
  ULog(@"value = %@",value);
  
  //处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
  completionHandler(UNNotificationPresentationOptionAlert);
}

//点击推送及按钮的响应
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
  
  NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
  if ([categoryIdentifier isEqualToString:@"category"]) {//识别需要被处理的拓展
    
    if ([response.actionIdentifier isEqualToString:@"reply"]) {//识别用户点击的是哪个 action
      NSString* value = [response.notification.request.content.userInfo objectForKey:@"name"];
      ULog(@"ios10 value = %@",value);
      UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"ios10本地推送消息" message:value preferredStyle:UIAlertControllerStyleAlert];
      [ac addAction:[UIAlertAction actionWithTitle:@"cancle" style:UIAlertActionStyleCancel handler:nil]];
      [[MDTool getCurrentVC] presentViewController:ac animated:YES completion:nil];

    }else{
      
    }
    
  }
  completionHandler();

}


@end

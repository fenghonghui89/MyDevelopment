//
//  MDNotificationManager.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#define ULog(format,...) do{   \
if ([MDGlobalManager sharedInstance].openLog) {NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);} \
}while(0)

#import "MDPushNotificationManager.h"
#import "MDGlobalManager.h"
#import "Firebase.h"

@import UserNotifications;
@interface MDPushNotificationManager()<UNUserNotificationCenterDelegate,FIRMessagingDelegate>

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
  
  
  
  //fcm init
  if ((floor)(NSFoundationVersionNumber)<=NSFoundationVersionNumber_iOS_9_x_Max) {
    
  }else{
    //The callback to handle data message received via FCM for devices running iOS 10 or above.
    [[FIRMessaging messaging] setRemoteMessageDelegate:self];
  }
  
  
  [FIRApp configure];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:)
                                               name:kFIRInstanceIDTokenRefreshNotification object:nil];
  
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

- (void)connectToFcm {
  
  [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error) {
    if (error != nil) {
      NSLog(@"Unable to connect to FCM. %@", error);
    } else {
      NSLog(@"Connected to FCM.");
    }
  }];
}

- (void)tokenRefreshNotification:(NSNotification *)notification {
  
  NSString *refreshedToken = [[FIRInstanceID instanceID] token];
  NSLog(@"InstanceID token: %@", refreshedToken);
  
  [self connectToFcm];
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
  NSLog(@"Message ID: %@", userInfo[@"gcm.message_id"]);
  
  // Print full message.
  NSLog(@"%@", userInfo);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
  
  NSLog(@"Message ID: %@", userInfo[@"gcm.message_id"]);
  
  // Print full message.
  NSLog(@"%@", userInfo);
  
  completionHandler(UIBackgroundFetchResultNoData);
}


#pragma mark app lifecycle
- (void)applicationDidEnterBackground:(UIApplication *)application {
  [[FIRMessaging messaging] disconnect];
  NSLog(@"Disconnected from FCM..");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  
  [self connectToFcm];
}

#pragma mark - < callback >
#pragma mark * ios10 or later UNUserNotificationCenterDelegate
/*
 app在前台:在展示通知前进行处理，即有机会在展示通知前再修改通知内容(有时候不会触发？)
 app在后台:不会触发
 */
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{

  // Print message ID.
  NSDictionary *userInfo = notification.request.content.userInfo;
  NSLog(@"Message ID: %@", userInfo[@"gcm.message_id"]);
  
  // Print full message.
  NSLog(@"%@", userInfo);

}

//无论app在前台还是后台，点击推送或按钮的响应
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
  
  NSDictionary *userInfo = response.notification.request.content.userInfo;
  NSLog(@"userNotificationCenter。。%@", userInfo);
}

#pragma mark * ios10 or later FIRMessagingDelegate
- (void)applicationReceivedRemoteMessage:(FIRMessagingRemoteMessage *)remoteMessage {
  // Print full message
  NSLog(@"ios10 fcm %@", [remoteMessage appData]);
}

@end

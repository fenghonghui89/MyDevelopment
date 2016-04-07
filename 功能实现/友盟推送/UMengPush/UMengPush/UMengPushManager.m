//
//  UMengPushManager.m
//  UMengPush
//
//  Created by 冯鸿辉 on 16/4/1.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "UMengPushManager.h"
#import "UMessage.h"
@implementation UMengPushManager

#pragma mark - start / stop
+(UMengPushManager *)sharedManager{
  
  static UMengPushManager *shareManager = nil;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    shareManager = [[UMengPushManager alloc] init];
  });
  
  return shareManager;
}

-(void)startPush:(NSDictionary *)launchOptions{
  
  //set AppKey and AppSecret
  [UMessage startWithAppkey:@"57034224e0f55a36e300126c" launchOptions:launchOptions];
  
  //log
  [UMessage setLogEnabled:YES];
  
//  //角标清0
//  [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//  
//  //清除所有通知(包含本地通知)
//  [[UIApplication sharedApplication] cancelAllLocalNotifications];
  
  //other
  [UMessage setBadgeClear:YES];
  [UMessage setAutoAlert:YES];//当应用在前台时收到推送会弹出alert
  [UMessage setChannel:@"App Store"];
  
  
  //注册推送
  if([[[UIDevice currentDevice] systemVersion] integerValue]>=8.0)
  {
    [self registerPushForIOS8OrLater];
  }else{
    [self registerPushForIOS8Before];
  }
}

-(void)stopPush{

  [UMessage unregisterForRemoteNotifications];
  
}
#pragma mark - 注册推送服务
-(void)registerPushForIOS8OrLater{
  
  //Types
  UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
  
  //Categories(Actions)
  UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
  action1.identifier = @"action1_identifier";
  action1.title=@"Accept";
  action1.activationMode = UIUserNotificationActivationModeForeground;
  
  UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
  action2.identifier = @"action2_identifier";
  action2.title=@"Reject";
  action2.activationMode = UIUserNotificationActivationModeBackground;
  action2.authenticationRequired = YES;
  action2.destructive = YES;
  
  UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
  categorys.identifier = @"category1";
  [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
  NSSet *set = [NSSet setWithObjects:categorys, nil];
  
  //UserNotificationSettings(Types+Categories(Actions))
  UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:types categories:set];
  
  //注册
//  [[UIApplication sharedApplication] registerUserNotificationSettings:userSettings];
//  [[UIApplication sharedApplication] registerForRemoteNotifications];
  [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];//或者直接这个
}

-(void)registerPushForIOS8Before{
  
  //注册
  UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
  [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
//  [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];//或者直接这个
}

#pragma mark - 注册 device token
- (void)registerDeviceToken:(NSData *)deviceToken{
  
  [UMessage registerDeviceToken:deviceToken];
}

#pragma mark - 接收到推送
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
  
  [UMessage didReceiveRemoteNotification:userInfo];
}

#pragma mark - tag
-(void)addTag:(id)tag response:(void (^)(id responseObject,NSInteger remain,NSError *error))handle{

  [UMessage addTag:tag response:handle];
}

-(void)removeTag:(id)tag response:(void (^)(id responseObject,NSInteger remain,NSError *error))handle;
{
  
  [UMessage removeTag:tag response:handle];
}

-(void)removeAllTag:(void (^)(id responseObject,NSInteger remain,NSError *error))handle{
  
  [UMessage removeAllTags:handle];
}

-(void)getTags:(void (^)(NSSet *responseTages,NSInteger remain,NSError *error))handle{
  
  [UMessage getTags:handle];
}
@end

//
//  AppDelegate.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/12.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDClassesViewController.h"
#import "MDNavigationController.h"
#import "MDRootDefine.h"
#import "MDGlobalManager.h"
#import <stdio.h>
@import UserNotifications;
@interface MDAppDelegate ()

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *myTimer;

@end
@implementation MDAppDelegate

#pragma mark - < customize method >

#pragma mark * 推送

-(void)registerForNotification:(NSDictionary *)launchOptions{
  
  //如果app处于未运行时收到推送，点击通知打开app之后会有userInfo
  NSDictionary *remoteNotiUserInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
  if (remoteNotiUserInfo) {
    
  }
  
  NSDictionary *localNotiUserInfo = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
  if (localNotiUserInfo) {
    
  }
}

/**
 注册远程推送
 */
-(void)registerForRemoteNotification{
  
  UIUserNotificationType allUserNotificationTypes = (UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge);
  UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:allUserNotificationTypes categories:nil];
  [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
  
  
  //ios10
  UNAuthorizationOptions allAuthorizationOptions = (UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert);
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  [center requestAuthorizationWithOptions:allAuthorizationOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
    if (!error) {
      NSLog(@"request authorization succeeded!");
    }
  }];
  
  [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
    NSLog(@"%@",settings);
  }];
  
  //注册token
  [[UIApplication sharedApplication] registerForRemoteNotifications];
}

/**
 注册本地推送
 */
-(void)registerForLocalNotification{
  
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
  NSLog(@"~~~");
#else
  NSLog(@"~~~");
#endif
  
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
 	NSLog(@"~~~");
#else
  NSLog(@"~~~");
#endif
  
#if defined(__IPHONE_10_0)
  NSLog(@"~~~");
#else
  NSLog(@"~~~");
#endif
  
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

  //Local Notification
  UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
  content.title = @"Introduction to Notifications";
  content.subtitle = @"Session 707";
  content.body = @"Woah! These new notifications look amazing! Don’t you agree?";
  content.badge = @1;
  
  //2 分钟后提醒
  UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:120 repeats:NO];
  NSString *requestIdentifier = @"sampleRequest";
  
  UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier
                                                                        content:content
                                                                        trigger:trigger1];
  
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    
  }];

#endif
  
  UILocalNotification* noti = [[UILocalNotification alloc] init];
  
  //设置发射时间为5s之后
  NSDate* date = [NSDate new];
  noti.fireDate = [date dateByAddingTimeInterval:5];
  
  //设置弹出内容
  noti.alertBody = @"alertBody..";
  noti.alertAction = @"alertAction..";
  
  noti.applicationIconBadgeNumber = 3;//设置应用图标右上角显示的数字
  noti.userInfo = @{@"name":@"zhangsan"};//传参
  noti.repeatInterval = NSCalendarUnitMinute;//设置每隔1分钟弹出通知
  
  //把通知添加进日程
  [[UIApplication sharedApplication] scheduleLocalNotification:noti];
  
  
  
}

#pragma mark * 后台延时
- (void) endBackgroundTask{
  
  dispatch_queue_t mainQueue = dispatch_get_main_queue();
  
  dispatch_async(mainQueue, ^(void) {
    
    [self.myTimer invalidate];
    
    //标记任务停止
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
    
    //销毁后台任务标识符
    self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    
  });
}


/**
 模拟的一个 Long-Running Task 方法
 
 @param paramSender paramSender
 */
- (void)timerMethod:(NSTimer *)paramSender{
  
  //backgroundTimeRemaining 属性包含了程序留给的我们的时间
  NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
  if (backgroundTimeRemaining == DBL_MAX){
    NSLog(@"Background Time Remaining = Undetermined");
  } else {
    NSLog(@"Background Time Remaining = %.02f Seconds", backgroundTimeRemaining);
  }
}

#pragma mark - < callback >
#pragma mark UIApplicationDelegate
#pragma mark * app lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  
  
  //默认启动摇晃
  [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
  
  
  //setup rootvc
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window setBackgroundColor:[UIColor whiteColor]];
  //  self.window.tintColor = [UIColor purpleColor];
  
  MDClassesViewController *vc = [[MDClassesViewController alloc] init];
  vc.data = [MDTool getPlistDataByName:@"TitleList"];
  MDNavigationController *navi = [[MDNavigationController alloc] initWithRootViewController:vc];
  
  self.window.rootViewController = navi;
  [self.window makeKeyAndVisible];
  
  //输出设备信息
  [[MDTool sharedInstance] showDeviceInfo];
  
  //注册远程推送
  [self registerForRemoteNotification];
  
  //开启日志输出
  [MDGlobalManager sharedInstance].openLog = NO;
  
  
  
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  
  //后台延时
  
  //  self.backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^(void) {
  //    NSLog(@"停止后台任务");
  //    [self endBackgroundTask];
  //  }];
  //
  //  //模拟一个Long-Running Task
  //  self.myTimer =[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerMethod:) userInfo:nil repeats:YES];
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark * remote noti
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
  
  NSString *decToken = [NSString stringWithFormat:@"%@", deviceToken];
  NSLog(@"decToken get:%@",decToken);
  
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  NSString *dt = [ud objectForKey:@"deviceToken"];
  
  if ([dt isEqualToString:decToken]) {
    NSLog(@"decToken一样");
  }else{
    NSLog(@"decToken不一样");
    [ud setObject:decToken forKey:@"deviceToken"];
  }
  
  [ud synchronize];
}

#pragma mark * local noti
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  
  //点击通知返回应用时会调用该方法
  //接收传递的参数
  NSString* name = [notification.userInfo objectForKey:@"name"];
  NSLog(@"name = %@",name);
  
  //删除通知：全部或者指定某一个，不删除的话就算应用删除了也会一直弹出来
  [[UIApplication sharedApplication] cancelAllLocalNotifications];
  //[[UIApplication sharedApplication] cancelLocalNotification:notification];
  
}
@end

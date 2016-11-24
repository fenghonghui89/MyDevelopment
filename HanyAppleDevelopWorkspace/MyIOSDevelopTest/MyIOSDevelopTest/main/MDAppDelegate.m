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
#import "MDLocalNotificationManager.h"
#import <stdio.h>
@import UserNotifications;

@interface MDAppDelegate ()

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *myTimer;

@end
@implementation MDAppDelegate

#pragma mark - < customize method >

#pragma mark * 推送

-(void)registerNotification:(NSDictionary *)launchOptions{
  
  //如果app处于未运行时收到推送，点击通知打开app之后会有userInfo
  NSDictionary *remoteNotiUserInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
  if (remoteNotiUserInfo) {
    ULog(@"未运行时收到推送 remoteNotiUserInfo..%@",remoteNotiUserInfo);
  }
  
  NSDictionary *localNotiUserInfo = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
  if (localNotiUserInfo) {
    ULog(@"未运行时收到推送 localNotiUserInfo..%@",localNotiUserInfo);
  }
  
  if ([MDGlobalManager sharedInstance].hasFirstLaunch == NO) {
    [[MDLocalNotificationManager sharedInstance] registerLocalNotification];
  }

}

/**
 注册远程推送
 */
-(void)registerForRemoteNotification{
  
  UIUserNotificationType allUserNotificationTypes = UIUserNotificationTypeSound|UIUserNotificationTypeAlert|UIUserNotificationTypeBadge;
  UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:allUserNotificationTypes categories:nil];
  [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
  
  
  //ios10
  UNAuthorizationOptions allAuthorizationOptions = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
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
  
  //开启日志输出
  [MDGlobalManager sharedInstance].openLog = YES;
  
  //默认启动摇晃
  [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
  
  //输出设备信息
  [[MDTool sharedInstance] showDeviceInfo];
  
  //注册推送
  [self registerNotification:launchOptions];
  
  //修改标识
  if ([MDGlobalManager sharedInstance].hasFirstLaunch == NO) {
    ULog(@"第一次运行，初始化完成");
    [MDGlobalManager sharedInstance].hasFirstLaunch = YES;
  }else{
    ULog(@"不是第一次运行，初始化完成");
  }
  
  //setup rootvc
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window setBackgroundColor:[UIColor whiteColor]];
  
  MDClassesViewController *vc = [[MDClassesViewController alloc] init];
  vc.data = [MDTool getPlistDataByName:@"TitleList"];
  MDNavigationController *navi = [[MDNavigationController alloc] initWithRootViewController:vc];
  
  self.window.rootViewController = navi;
  [self.window makeKeyAndVisible];
  
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


#pragma mark * 推送授权
//ios9 or earlier
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
  
  [[MDLocalNotificationManager sharedInstance] application:application didRegisterUserNotificationSettings:notificationSettings];
}

#pragma mark * 远程推送
//ios9 or earlier
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



#pragma mark * 本地推送
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  
  [[MDLocalNotificationManager sharedInstance] application:application didReceiveLocalNotification:notification];
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
  
  [[MDLocalNotificationManager sharedInstance] application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
}

@end

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
#import "MDTool.h"
@interface MDAppDelegate ()

@end
@implementation MDAppDelegate

#pragma mark - <<<<< customize method >>>>>
#pragma mark - < 推送 >
#pragma mark 注册远程推送
-(void)registerForRemoteNotification:(UIApplication *)application{
  
  UIUserNotificationSettings *setting =[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
  [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
  [application registerForRemoteNotifications];
}

#pragma mark 注册本地推送
-(void)localNotification{

  UILocalNotification* noti = [[UILocalNotification alloc] init];
  
  //设置发射时间为5s之后
  NSDate* date = [NSDate new];
  noti.fireDate = [date dateByAddingTimeInterval:5];
  
  //设置弹出内容
  noti.alertBody = @"好久没来玩啦~";
  
  noti.alertAction = @"alertAction";
  
  //设置应用图标右上角显示的数字
  noti.applicationIconBadgeNumber = 3;
  
  //传参（在AppDelegate）
  noti.userInfo = @{@"name":@"zhangsan"};
  
  //把通知添加进日程
  [[UIApplication sharedApplication]scheduleLocalNotification:noti];
  
  //设置每隔1分钟弹出通知
  [noti setRepeatInterval:NSCalendarUnitMinute];
}

#pragma mark - <<<<< callback >>>>>
#pragma mark - < UIApplicationDelegate >
#pragma mark app lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  
  MDClassesViewController *cVC = [[MDClassesViewController alloc] init];
  cVC.data = [MDTool getPlistDataByName:@"TitleList"];
  MDNavigationController *navi = [[MDNavigationController alloc] initWithRootViewController:cVC];
  
  [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window setBackgroundColor:[UIColor whiteColor]];
//  self.window.tintColor = [UIColor purpleColor];
  self.window.rootViewController = navi;
  [self.window makeKeyAndVisible];
  
  [[MDTool sharedInstance] showDeviceInfo];
  
  [self registerForRemoteNotification:application];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

#pragma mark remote noti
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

#pragma mark local noti
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

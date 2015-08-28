//
//  AppDelegate.m
//  XGPushTest
//
//  Created by hanyfeng on 15/3/24.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "AppDelegate.h"
#import "MDXGPushManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[MDXGPushManager share] startXGPush];
    [[MDXGPushManager share]application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"~~~DidEnterBackground");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"~~~applicationDidBecomeActive");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - 1.注册苹果推送服务

- (void)registerPush
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

- (void)registerPushForIOS8
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Categories(Actions)
    UIMutableUserNotificationAction *acceptAction1 = [[UIMutableUserNotificationAction alloc] init];
    acceptAction1.identifier = @"ACCEPT_IDENTIFIER1";
    acceptAction1.title = @"Accept1";
    acceptAction1.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction1.destructive = NO;
    acceptAction1.authenticationRequired = NO;
    
    UIMutableUserNotificationAction *acceptAction2 = [[UIMutableUserNotificationAction alloc] init];
    acceptAction2.identifier = @"ACCEPT_IDENTIFIER2";
    acceptAction2.title = @"Accept2";
    acceptAction2.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction2.destructive = NO;
    acceptAction2.authenticationRequired = NO;

    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    inviteCategory.identifier = @"INVITE_CATEGORY";
    [inviteCategory setActions:@[acceptAction1,acceptAction2] forContext:UIUserNotificationActionContextDefault];
    [inviteCategory setActions:@[acceptAction1,acceptAction2] forContext:UIUserNotificationActionContextMinimal];
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    
    //UserNotificationSettings(Types+Categories(Actions))
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    
    //注册
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}



#pragma mark - 2.注册设备信息
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * deviceTokenStr = [XGPush registerDevice:deviceToken successCallback:^{
        NSLog(@"~~~[XGPush]register successBlock");
    } errorCallback:^{
        NSLog(@"~~~[XGPush]register errorBlock");
    }];
    
    NSLog(@"~~~deviceTokenStr is %@",deviceTokenStr);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    NSLog(@"~~~error:%@",str);
}

#pragma mark - 3.收到远程推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    NSLog(@"~~~didReceiveRemote--fetch");
    
    switch (application.applicationState) {
        case UIApplicationStateActive:
            NSLog(@"~~~active");
            break;
        case UIApplicationStateInactive:
            NSLog(@"~~~inactive");
            break;
        case UIApplicationStateBackground:
            NSLog(@"~~~Background");
            break;
        default:
            break;
    }
    
    NSDictionary *dic = userInfo;
    [XGPush handleReceiveNotification:dic successCallback:^{
        NSLog(@"~~~[XGPush]ReceiveRemoteNotification successBlock");
    } errorCallback:^{
        NSLog(@"~~~[XGPush]ReceiveRemoteNotification errorBlock");
    } completion:^{
        NSLog(@"~~~[XGPush]ReceiveRemoteNotification completionBlock");
    }];
    
    if(completionHandler){
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

#pragma mark - 弹出远程推送弹窗
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"~~~didReceiveLocalNotification");
    
    //默认App在前台运行时不会进行弹窗，通过此接口可实现指定的推送弹窗
    [XGPush localNotificationAtFrontEnd:notification userInfoKey:@"clockID" userInfoValue:@"myid"];
    
    //删除推送列表中的这一条
    [XGPush delLocalNotification:@"clockID" userInfoValue:@"myid"];
//    [XGPush delLocalNotification:notification];
    
    //清空推送列表
    //[XGPush clearLocalNotifications];
}

#pragma mark - 按钮点击事件回调
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER1"]){
        NSLog(@"~~~ACCEPT_IDENTIFIER1 is clicked");
    }
    
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER2"]){
        NSLog(@"~~~ACCEPT_IDENTIFIER2 is clicked");
    }
    
    if (completionHandler) {
        completionHandler();
    }
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{

}
@end

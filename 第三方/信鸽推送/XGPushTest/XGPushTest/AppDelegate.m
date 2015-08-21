//
//  AppDelegate.m
//  XGPushTest
//
//  Created by hanyfeng on 15/3/24.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "AppDelegate.h"
#import "XGPush.h"
#import "XGSetting.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"~~~didFinishLaunching");
    
    //TODO:启动信鸽推送
    [XGPush startApp:2200097828 appKey:@"I3B1ULI2S95H"];
    
    
    //TODO:注销之后需要再次注册前的准备
    void (^successCallback)(void) = ^(void){
        if(![XGPush isUnRegisterStatus])
        {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
            float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
            if(sysVer < 8){
                [self registerPush];
            }
            else{
                [self registerPushForIOS8];
            }
#else
            [self registerPush];
#endif
        }
    };
    [XGPush initForReregister:successCallback];
    
    
    //TODO:如果收到推送时程序还没有启动，则在这里处理推送消息
    if(launchOptions){
        NSLog(@"launchOptions:%@",launchOptions);
        NSDictionary* launchOptionsDic = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        if (launchOptionsDic){
            NSDictionary *apsInfo = [launchOptionsDic objectForKey:@"aps"];
            if(apsInfo){
                NSLog(@"~~处理推送");
            }
            
        }
    }
    
    
    //TODO:推送反馈
    void (^successBlock)(void) = ^(void){
        NSLog(@"~~~[XGPush]handleLaunching's successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        NSLog(@"~~~[XGPush]handleLaunching's errorBlock");
    };
    
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //清除所有通知(包含本地通知)
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [XGPush handleLaunching:launchOptions successCallback:successBlock errorCallback:errorBlock];
    
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
- (void)registerPushForIOS8
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Categories(Actions)
    UIMutableUserNotificationAction *acceptAction1 = [[UIMutableUserNotificationAction alloc] init];
    acceptAction1.identifier = @"ACCEPT_IDENTIFIER1";
    acceptAction1.title = @"Accept";
    acceptAction1.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction1.destructive = NO;
    acceptAction1.authenticationRequired = NO;
    
    UIMutableUserNotificationAction *acceptAction2 = [[UIMutableUserNotificationAction alloc] init];
    acceptAction2.identifier = @"ACCEPT_IDENTIFIER2";
    acceptAction2.title = @"Accept";
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

- (void)registerPush
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

#pragma mark - 2.注册设备信息
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    void (^successBlock)(void) = ^(void){
        NSLog(@"~~~[XGPush]register successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        NSLog(@"~~~[XGPush]register errorBlock");
    };
    
    NSString * deviceTokenStr = [XGPush registerDevice:deviceToken successCallback:successBlock errorCallback:errorBlock];
    
    NSLog(@"~~~deviceTokenStr is %@",deviceTokenStr);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    NSLog(@"~~~error:%@",str);
}

#pragma mark - 3.收到远程推送
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    NSLog(@"~~~didReceiveRemote");
//    if (application.applicationState == UIApplicationStateActive) {
//        NSLog(@"~~~active");
//    }else if(application.applicationState == UIApplicationStateInactive){
//        NSLog(@"~~~inactive");
//    }else if(application.applicationState == UIApplicationStateBackground){
//        NSLog(@"~~~Background");
//    }
//    
//    void (^successBlock)(void) = ^(void){
//        NSLog(@"~~~[XGPush]ReceiveRemoteNotification successBlock");
//    };
//    
//    void (^errorBlock)(void) = ^(void){
//        NSLog(@"~~~[XGPush]ReceiveRemoteNotification errorBlock");
//    };
//    
//    void (^completionBlock)(void) = ^(void){
//        NSLog(@"~~~[XGPush]ReceiveRemoteNotification completionBlock");
//    };
//    NSDictionary *dic = userInfo;
//    [XGPush handleReceiveNotification:dic successCallback:successBlock errorCallback:errorBlock completion:completionBlock];
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    NSLog(@"~~~didReceiveRemote--fetch");
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"~~~active");
    }else if(application.applicationState == UIApplicationStateInactive){
        NSLog(@"~~~inactive");
    }else if(application.applicationState == UIApplicationStateBackground){
        NSLog(@"~~~Background");
    }
    
    void (^successBlock)(void) = ^(void){
        NSLog(@"~~~[XGPush]ReceiveRemoteNotification successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        NSLog(@"~~~[XGPush]ReceiveRemoteNotification errorBlock");
    };
    
    void (^completionBlock)(void) = ^(void){
        NSLog(@"~~~[XGPush]ReceiveRemoteNotification completionBlock");
    };
    NSDictionary *dic = userInfo;
    [XGPush handleReceiveNotification:dic successCallback:successBlock errorCallback:errorBlock completion:completionBlock];
    
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
    [XGPush delLocalNotification:notification];
    //[XGPush delLocalNotification:@"clockID" userInfoValue:@"myid"];
    
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

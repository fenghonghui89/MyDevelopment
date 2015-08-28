//
//  MDXGPushManager.m
//  XGPushTest
//
//  Created by hanyfeng on 15/8/28.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "MDXGPushManager.h"
#import "XGPush.h"
#import "XGSetting.h"
@interface MDXGPushManager()

@end
@implementation MDXGPushManager

+(MDXGPushManager *)share
{
    static MDXGPushManager *share = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        share = [[self alloc] init];
    });
    
    return share;
}


#pragma mark - < 启动、注册推送 入口> -
-(void)startXGPush
{
    [XGPush startApp:2200097828 appKey:@"I3B1ULI2S95H"];
    [self registerPush];
}

-(void)registerXGPush
{
    //初始化成功后注册信鸽推送
    [XGPush initForReregister:^{
        if(![XGPush isUnRegisterStatus]){
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
            [self registerPushForIOS8];
#else
            [self registerPush];
#endif
        }

    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //如果收到推送时程序还没有启动，则在这里处理推送消息
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
    
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    //清除所有通知(包含本地通知)
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //推送反馈（app没有启动时）
    [XGPush handleLaunching:launchOptions successCallback:^{
        NSLog(@"~~~[XGPush]handleLaunching's successBlock");
    } errorCallback:^{
        NSLog(@"~~~[XGPush]handleLaunching's errorBlock");
    }];
    
    return YES;
}

#pragma mark - < action > -
#pragma mark 1.注册苹果推送服务

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

#pragma mark 2.注册设备信息
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

#pragma mark 接收到远程推送及处理
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
    
    //推送反馈
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

#pragma mark 本地推送弹窗
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"~~~didReceiveLocalNotification");
    
    //默认App在前台运行时不会进行弹窗，通过此接口可实现指定的推送弹窗
    [XGPush localNotificationAtFrontEnd:notification userInfoKey:@"clockID" userInfoValue:@"myid"];
    
    //本地推送
    [XGPush localNotification:[NSDate dateWithTimeInterval:3 sinceDate:[NSDate date]]
                    alertBody:@"3秒后的弹窗"
                        badge:1 alertAction:@"点击"
                     userInfo:nil];
    
    //删除推送列表中的这一条
    [XGPush delLocalNotification:@"clockID" userInfoValue:@"myid"];
//    [XGPush delLocalNotification:notification];
    
    //清空推送列表
//    [XGPush clearLocalNotifications];
}

#pragma mark 按钮点击事件回调
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
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER1"]){
        NSLog(@"~~~!!ACCEPT_IDENTIFIER1 is clicked");
    }
    
    if([identifier isEqualToString:@"ACCEPT_IDENTIFIER2"]){
        NSLog(@"~~~!!ACCEPT_IDENTIFIER2 is clicked");
    }
    
    if (completionHandler) {
        completionHandler();
    }
}
@end

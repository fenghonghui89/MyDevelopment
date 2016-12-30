//
//  AppDelegate.m
//  testSDK
//
//  Created by hanyfeng on 15/1/23.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "AppDelegate.h"

//ShareSDK
#import <ShareSDK/ShareSDK.h>

//QQ空间
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

//微信
#import "WXApi.h"

//腾讯微博
#import "WeiboApi.h"

//新浪微博
#import "WeiboSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //注册ShareSDK
    [ShareSDK registerApp:@"570b1b3a97e3"];
    [ShareSDK setStatPolicy:SSCStatPolicyLimitSize];
    [ShareSDK allowExchangeDataEnabled:YES];
    [ShareSDK useAppTrusteeship:YES];
    
    //添加新浪微博应用
    //注册网址 http://open.weibo.com
    //添加库：ImageIO.framework
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    //other link flag 需要添加 -ObjC
    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
    
    
    
    
    
    //添加QQ空间应用
    //注册网址  http://connect.qq.com/intro/login/
    //添加库：libstdc++.dylib、libsqlite3.dylib
    [ShareSDK connectQZoneWithAppKey:@"1104166439"
                           appSecret:@"LnKhnLAAkAYIrbA3"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1104166439"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加腾讯微博应用 注册网址 http://dev.t.qq.com Social.framework
    //添加库：Social.framework、Accounts.framework
    [ShareSDK connectTencentWeiboWithAppKey:@"1104166439"
                                  appSecret:@"LnKhnLAAkAYIrbA3"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WeiboApi class]];
    
    
    
    
    
    
    
    //添加微信应用
    //注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wxa5bb4447a54fd490"
                           wechatCls:[WXApi class]];
    
    
    
    
    
    
    
    //连接短信分享
    //添加库：MessageUI.framework
    [ShareSDK connectSMS];
    
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

#pragma mark 需要做处理的系统回调
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    //处理请求打开链接,如果集成新浪微博(SSO)、Facebook(SSO)、微信、QQ分享功能需要加入此方法
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //处理请求打开链接,如果集成新浪微博(SSO)、Facebook(SSO)、微信、QQ分享功能需要加入此方法
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


@end

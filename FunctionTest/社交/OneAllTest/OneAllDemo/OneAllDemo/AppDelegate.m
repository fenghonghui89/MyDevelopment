//
//  AppDelegate.m
//  OneAllTest
//
//  Created by 冯鸿辉 on 2016/12/7.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
/*
 暂时只做了facebook登录
 要加-ObjC， FacebookSDK要用OneAll提供的，否则能运行但登录fb时会报错
 要添加LibOneAll.a
 要加OneAllResources.bundle，否则用OneAll页面会崩
 把OneAll.xcodeproj加到OneAllDemo下，添加bundle就不会在左边目录树生成文件引用，看上去更干净
 
 urlscheme加fbauth才能跳到app
 其他看fb接入教程和oneall github接入教程
 */

#import "AppDelegate.h"
#import <OneAll/OneAll.h>
static NSString *const kOneAllSubdomain = @"tpages";
static NSString *const kFacebookAppId = @"1104301926267039";
static NSString *const kTwitterConsumerKey = nil;
static NSString *const kTwitterConsumerSecret = nil;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  
//  [[OAManager sharedInstance] setupWithSubdomain:@"tpages"];
  
  [[OAManager sharedInstance] setupWithSubdomain:kOneAllSubdomain
                                   facebookAppId:kFacebookAppId
                              twitterConsumerKey:kTwitterConsumerKey
                                   twitterSecret:kTwitterConsumerSecret];
  
  [[OAManager sharedInstance] setNetworkActivityIndicatorControlledByOa:true];
  
  return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
  return [[OAManager sharedInstance] handleOpenUrl:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
  return [[OAManager sharedInstance] handleOpenUrl:url sourceApplication:sourceApplication];

}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  [[OAManager sharedInstance] didBecomeActive];
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

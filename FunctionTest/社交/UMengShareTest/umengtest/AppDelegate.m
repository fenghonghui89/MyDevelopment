//
//  AppDelegate.m
//  umengtest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//

#import "AppDelegate.h"

#import "UMShareManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  [[UMShareManager share] startUMShare];
  return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
  BOOL result = [[UMShareManager share] application:application handleOpenURL:url ];
  if (result == FALSE) {
//    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
//    if ([url.host isEqualToString:@"safepay"]) {
//      [[AlipaySDK defaultService] processOrderWithPaymentResult:url
//                                                standbyCallback:^(NSDictionary *resultDic) {
//                                                  NSLog(@"result = %@",resultDic);
//                                                }];
//    }
//    
//    if ([url.host isEqualToString:@"platformapi"]) {
//      //支付宝钱包快登授权返回 authCode
//      [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
//        NSLog(@"result = %@", resultDic);
//      }];
//    }
  }
  
  
  
  //调用其他SDK，例如新浪微博SDK等
//  [WXApi handleOpenURL:url delegate:[NKCThirdSDKPackage shareInstance]];
  
  return result;

}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
  BOOL result = [[UMShareManager share] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
  if (result == FALSE) {
    //    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    //    if ([url.host isEqualToString:@"safepay"]) {
    //      [[AlipaySDK defaultService] processOrderWithPaymentResult:url
    //                                                standbyCallback:^(NSDictionary *resultDic) {
    //                                                  NSLog(@"result = %@",resultDic);
    //                                                }];
    //    }
    //
    //    if ([url.host isEqualToString:@"platformapi"]) {
    //      //支付宝钱包快登授权返回 authCode
    //      [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
    //        NSLog(@"result = %@", resultDic);
    //      }];
    //    }
  }
  
  
  
  //调用其他SDK，例如新浪微博SDK等
  //  [WXApi handleOpenURL:url delegate:[NKCThirdSDKPackage shareInstance]];
  
  return result;

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

@end

//
//  AppDelegate.m
//  WXPayTest
//
//  Created by 冯鸿辉 on 15/12/23.
//  Copyright © 2015年 DGC. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "WXApiManager.h"
@interface AppDelegate ()
@property(nonatomic,strong)UIWebView *webview_ua;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  //向微信注册wxd930ea5d5a258f4f  com.tpages.wxpay.test
//  [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"demo 2.0"];//旧api
//  [WXApi registerApp:@"wxa9cec0d7b7d9d1f1" withDescription:@"demo 2.0"];
  
  [WXApi registerApp:@"wxa9cec0d7b7d9d1f1"];
  
  NSLog(@"wx sdk version :%@",[WXApi getApiVersion]);
  NSLog(@"wx support openapi:%d",[WXApi isWXAppSupportApi]);
  [self getUserAgent];
  return YES;
}

-(void)getUserAgent
{
  //获取userAgent
  UIWebView *webview_ua = [[UIWebView alloc] initWithFrame:CGRectZero];
  self.webview_ua = webview_ua;
  NSURL *url = [[NSURL alloc] initWithString:@"http://tpages.cn/sign/in"];
  [webview_ua loadRequest:[NSURLRequest requestWithURL:url]];
  
  NSString *userAgent;
  NSString *uagent = [webview_ua stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
  NSString *dev = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"iPad" : @"iPhone");
  NSString *ver = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  userAgent = [NSString stringWithFormat:@"%@ (TPages_%@/%@)", uagent, dev, ver];
  
  NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userAgent, @"UserAgent", nil];
  [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
  [[NSUserDefaults standardUserDefaults] synchronize];
  
  NSLog(@"userAgent %@",uagent);
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
  return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
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

//
//  AppDelegate.m
//  GoogleAnalyticsTest
//
//  Created by 冯鸿辉 on 2016/11/14.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "AppDelegate.h"
#import "GAI.h"

static NSString *const kTrackingId = @"UA-87378503-5";


@interface AppDelegate ()

// Used for sending Google Analytics traffic in the background.
@property(nonatomic, copy) void (^dispatchHandler)(GAIDispatchResult result);

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [GAI sharedInstance].dispatchInterval = 120;//每2min发送所有本地跟踪数据到服务器
  [GAI sharedInstance].trackUncaughtExceptions = YES;//跟踪未被捕获的异常
  [GAI sharedInstance].logger.logLevel = kGAILogLevelVerbose;// remove before app release
  [[GAI sharedInstance] setDryRun:YES];//调试时不发送数据给google
  
  id<GAITracker> tracker = [[GAI sharedInstance] trackerWithName:@"CuteAnimals" trackingId:kTrackingId];
  [[GAI sharedInstance] setDefaultTracker:tracker];

  return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  //在应用转入后台时发送匹配
  [self sendHitsInBackground];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  //恢复调度间隔
  [GAI sharedInstance].dispatchInterval = 120;
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 This method sends hits in the background until either we're told to stop background processing,
 we run into an error, or we run out of hits.  We use this to send any pending Google Analytics
 data since the app won't get a chance once it's in the background.
 */
- (void)sendHitsInBackground {
  
  __block BOOL taskExpired = NO;
  
  __block UIBackgroundTaskIdentifier taskId =
  [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
    taskExpired = YES;
  }];
  
  if (taskId == UIBackgroundTaskInvalid) {
    return;
  }
  
  __weak AppDelegate *weakSelf = self;
  self.dispatchHandler = ^(GAIDispatchResult result) {
    // Send hits until no hits are left, a dispatch error occurs, or
    // the background task expires.
    if (result == kGAIDispatchGood && !taskExpired) {
      [[GAI sharedInstance] dispatchWithCompletionHandler:weakSelf.dispatchHandler];
    } else {
      [[UIApplication sharedApplication] endBackgroundTask:taskId];
    }
  };
  
  [[GAI sharedInstance] dispatchWithCompletionHandler:self.dispatchHandler];
}

@end

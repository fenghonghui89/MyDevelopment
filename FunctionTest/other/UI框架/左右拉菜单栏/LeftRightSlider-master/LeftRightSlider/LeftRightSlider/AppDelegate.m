//
//  AppDelegate.m
//  LeftRightSlider
//
//  Created by Zhao Yiqi on 13-11-27.
//  Copyright (c) 2013年 Zhao Yiqi. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [SliderViewController sharedSliderController].MainVC = [[MainViewController alloc] init];
    [SliderViewController sharedSliderController].LeftVC=[[LeftVC alloc] init];
    [SliderViewController sharedSliderController].RightVC=[[RightVC alloc] init];
    
    [SliderViewController sharedSliderController].RightSContentOffset=260;
    [SliderViewController sharedSliderController].RightSContentScale=0.6;
    [SliderViewController sharedSliderController].RightSOpenDuration=0.6;
    [SliderViewController sharedSliderController].RightSCloseDuration=0.6;
    [SliderViewController sharedSliderController].RightSJudgeOffset=160;
    
    [SliderViewController sharedSliderController].LeftSContentOffset=260;
    [SliderViewController sharedSliderController].LeftSContentScale=0.6;
    [SliderViewController sharedSliderController].LeftSOpenDuration=0.6;
    [SliderViewController sharedSliderController].LeftSCloseDuration=0.6;
    [SliderViewController sharedSliderController].LeftSJudgeOffset=160;

//    LRNavigationController *nav=[[LRNavigationController alloc] initWithRootViewController:[SliderViewController sharedSliderController]];
//    nav.contentScale=1;
//    nav.judgeOffset=100;
//    nav.startX=0;

    self.window.rootViewController = [SliderViewController sharedSliderController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

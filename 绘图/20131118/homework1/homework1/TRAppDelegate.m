//
//  TRAppDelegate.m
//  homework1
//
//  Created by HanyFeng on 13-11-19.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRAppDelegate.h"

@implementation TRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIImage* image1 = [UIImage imageNamed:@"playing_volumn_slide_bg.png"];
    [[UISlider appearance] setMinimumTrackImage:image1 forState:UIControlStateNormal];
    
    UIImage* image2 = [UIImage imageNamed:@"playing_volumn_slide_foreground.png"];
    [[UISlider appearance] setMaximumTrackImage:image2 forState:UIControlStateNormal];
    
    UIImage* image3 = [UIImage imageNamed:@"playing_volumn_slide_sound_icon.png"];
    [[UISlider appearance] setThumbImage:image3 forState:UIControlStateNormal];
    
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

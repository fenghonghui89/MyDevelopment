//
//  HFAppDelegate.m
//  KVO_KVC
//
//  Created by hanyfeng on 14-5-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFAppDelegate.h"

@implementation HFAppDelegate

- (void)dealloc
{
    [self.person removeObserver:self.observer forKeyPath:@"age"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.person = [HFPerson new];
    
    self.observer = [HFObserver new];
    
    [self.person addObserver:self.observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"This is context"];
    
    self.person.age = 1;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self.person setValue:[NSNumber numberWithInt:3] forKeyPath:@"age"];
    NSLog(@" --------------- %d",self.person.age);
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.person setValue:[NSNumber numberWithInt:4] forKeyPath:@"age"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    self.person.age = 5;
    NSLog(@" ~~~~~~~~~~~~~~~ %@",[self.person valueForKey:@"age"]);
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.person setValue:[NSNumber numberWithInt:999] forKeyPath:@"age"];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.person setValue:[NSNumber numberWithInt:6] forKeyPath:@"age"];
}

@end

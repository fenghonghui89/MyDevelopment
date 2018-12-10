//
//  HFAppDelegate.m
//  KVO_KVC
//
//  Created by hanyfeng on 14-5-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFAppDelegate.h"

@implementation HFAppDelegate

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"person.name"];
    [self removeObserver:self forKeyPath:@"appStatus"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //被监听对象是自身，监听对象也是自身
    [self addObserver:self forKeyPath:@"person.name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"This is context"];
    [self addObserver:self forKeyPath:@"appStatus" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"This is context"];
    
    self.appStatus = @"didFinishLaunching";
    
    HFPerson *person = [HFPerson new];
    person.name = @"张三";
    person.age = 3;
    self.person = person;
    
    return YES;
}

//键值发生改变后触发
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"\nkeyPath:%@ \nobject:%@ \nchange:%@ \ncontext:%@ \n\n",keyPath,object,change,context);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    self.appStatus = @"WillResignActive";
    self.person.name = @"李四";
    self.person.age = 4;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    self.appStatus = @"DidEnterBackground";
    self.person.name = @"王五";
    self.person.age = 5;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    self.appStatus = @"WillEnterForeground";
    self.person.name = @"赵六";
    self.person.age = 6;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    self.appStatus = @"DidBecomeActive";
    self.person.name = @"张三";
    self.person.age = 3;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end

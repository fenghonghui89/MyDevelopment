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
    [self.person removeObserver:self forKeyPath:@"age"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
     接收者：被监听者
     observer：监听者
     keyPath：被监听者中 需要被监听的属性
     options：监听选项
     context：上下文内容，类型是void*（C语言形式的任何类型指针），所以如果传递空，应该是NULL而不是nil
     */
    self.person = [HFPerson new];
    
    [self.person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"This is context"];
    
    [self.person setValue:[NSNumber numberWithInt:1] forKeyPath:@"age"];
    
    //因为self.person未被创建，为nil，所以无法被监听
//    [self.person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"This is context"];
//    self.person = [HFPerson new];
//    [self.person setValue:[NSNumber numberWithInt:1] forKeyPath:@"age"];
    
    return YES;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"\nkeyPath:%@ \nobject:%@ \nchange:%@ \ncontext:%@ \n\n",keyPath,object,change,context);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self.person setValue:[NSNumber numberWithInt:3] forKeyPath:@"age"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.person setValue:[NSNumber numberWithInt:4] forKeyPath:@"age"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self.person setValue:[NSNumber numberWithInt:5] forKeyPath:@"age"];
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

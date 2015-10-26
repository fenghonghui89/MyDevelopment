//
//  ViewController.m
//  NetWorkTest
//
//  Created by hanyfeng on 15/9/17.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
#import "ReachabilityManager.h"
@interface ViewController ()
@property(nonatomic,strong)Reachability *hostreach;
@property(nonatomic,strong)Reachability *reachInt;
@property(nonatomic,strong)Reachability *reachWifi;
@property(nonatomic,strong)ReachabilityManager *rm;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self reachtest1];
    
}

#pragma mark 官方demo，只监听host
-(void)reachtest0
{
    //addObserver
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(customReachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    //host
    Reachability * hostreach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    hostreach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"host Block Says Reachable");
        });
    };
    
    hostreach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"host Block Says Unreachable");
        });
    };
    
    [hostreach startNotifier];
    _hostreach = hostreach;

}

-(void)customReachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    NSLog(@"reach %@",reach);
    if([reach isReachable])
    {
        NSLog(@"Notification Says Reachable");
    }
    else
    {
        NSLog(@"Notification Says Unreachable");
    }
}

#pragma mark 封装ReachabilityManager
-(void)reachtest1
{
    ReachabilityManager *rm = [ReachabilityManager share];
    [rm startListenNetworkLink];
    NSLog(@"networkType:%d",rm.networkType);
}

@end

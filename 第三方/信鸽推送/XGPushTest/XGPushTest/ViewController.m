//
//  ViewController.m
//  XGPushTest
//
//  Created by hanyfeng on 15/3/24.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "ViewController.h"
#import "XGPush.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//本地推送(会触发本地推送回调)
- (IBAction)pushLocalNoti:(id)sender
{
    NSDate *fireDate = [[NSDate new] dateByAddingTimeInterval:3];
    NSMutableDictionary *dicUserInfo = [[NSMutableDictionary alloc] init];
    [dicUserInfo setValue:@"myid" forKey:@"clockID"];
    [XGPush localNotification:fireDate alertBody:@"测试本地推送" badge:1 alertAction:@"确定" userInfo:dicUserInfo];
}

- (IBAction)logout:(id)sender
{
    void (^successBlock)(void) = ^(void){
        NSLog(@"~~~[XGPush]ReceiveRemoteNotification successBlock");
    };
    
    void (^errorBlock)(void) = ^(void){
        NSLog(@"~~~[XGPush]ReceiveRemoteNotification errorBlock");
    };
    
    [XGPush unRegisterDevice:successBlock errorCallback:errorBlock];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信鸽推送"
                                                    message:@"注销设备"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end

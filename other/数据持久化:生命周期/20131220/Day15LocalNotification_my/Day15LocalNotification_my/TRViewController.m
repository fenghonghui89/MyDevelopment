//
//  TRViewController.m
//  Day15LocalNotification_my
//
//  Created by HanyFeng on 13-12-24.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UILocalNotification* noti = [[UILocalNotification alloc] init];
    
    //设置发射时间为5s之后
    NSDate* date = [NSDate new];
    noti.fireDate = [date dateByAddingTimeInterval:5];
    
    //设置弹出内容
    noti.alertBody = @"好久没来玩啦~";
    
    noti.alertAction = @"alertAction";
    
    //设置应用图标右上角显示的数字
    noti.applicationIconBadgeNumber = 3;
    
    //传参（在AppDelegate）
    noti.userInfo = @{@"name":@"zhangsan"};
    
    //把通知添加进日程
    [[UIApplication sharedApplication]scheduleLocalNotification:noti];
    
    //设置每隔1分钟弹出通知
    [noti setRepeatInterval:NSCalendarUnitMinute];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  TRViewController.m
//  Day13Thread_my
//
//  Created by HanyFeng on 13-12-23.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"aaaaa");
    
//[NSThread sleepForTimeInterval:3];
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [view setBackgroundColor:[UIColor redColor]];
//[NSThread sleepForTimeInterval:3];
    [self.view addSubview:view];//操作界面的代码
    [NSThread sleepForTimeInterval:3];
    
    NSLog(@"bbbbb");
    //界面渲染会在当前线程所有代码执行完才统一执行，所以无论模拟阻塞放哪里，view都在最后才显示
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

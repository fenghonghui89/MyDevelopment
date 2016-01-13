//
//  TRViewController.m
//  Day14NSOperation
//
//  Created by Tarena on 13-12-19.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRMyTask.h"
@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建子线程的方法1：
	NSOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"这里是子线程1代码 开始");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"这里是子线程1代码 结束");
    }];
    
    NSOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"这里是子线程2代码 开始");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"这里是子线程2代码 结束");
    }];
    
    //创建子线程的方法2：
    TRMyTask *task = [[TRMyTask alloc]init];
    
    //创建线程队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //设置允许并发执行的线程数量 默认是-1 -1就是没有限制 大家一起来
   [queue setMaxConcurrentOperationCount:2];
    
    //把子线程加入队列的同时 子线程开启(并非先加进去的先执行，速度不一定，可能主线程先开启或者某个子线程)
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:task];
    
    NSLog(@"这里是主线程");

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

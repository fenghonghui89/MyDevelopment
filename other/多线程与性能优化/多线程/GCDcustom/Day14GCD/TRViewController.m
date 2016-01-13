//
//  TRViewController.m
//  Day14GCD
//
//  Created by Tarena on 13-12-19.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //创建用户自定义队列
    //create参数：1、标识符（推荐反向域名） 2、是串行队列DISPATCH_QUEUE_SERIAL（线程同步）还是并行队列DISPATCH_QUEUE_CONCURRENT（线程异步），低版本系统要传NULL
    dispatch_queue_t myQueue = dispatch_queue_create("com.example.queue", DISPATCH_QUEUE_SERIAL);
    
    
    dispatch_async(myQueue, ^{
        NSLog(@"1号子线程开始");
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"1号子线程结束");
    });
    
    dispatch_async(myQueue, ^{
        NSLog(@"2号子线程开始");
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"2号子线程结束");
    });
    
    dispatch_async(myQueue, ^{
        NSLog(@"3号子线程开始");
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"3号子线程结束");
    });
    
    //MRC下要release线程队列
    dispatch_release(myQueue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

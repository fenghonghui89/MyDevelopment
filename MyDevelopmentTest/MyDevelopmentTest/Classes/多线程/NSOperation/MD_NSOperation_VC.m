//
//  MD_NSOperation_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/11.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSOperation_VC.h"
#import "MyOperation.h"
@interface MD_NSOperation_VC ()

@end
@implementation MD_NSOperation_VC

#pragma mark - < vc lifecycle > -
-(void)viewDidLoad{

  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  [self test];
}

#pragma mark - < method > -
-(void)test{

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
  
  MyOperation *op3 = [[MyOperation alloc] init];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  [queue setMaxConcurrentOperationCount:2];//设置允许并发执行的线程数量 默认是-1 -1就是没有限制 大家一起来
  
  ////把子线程加入队列的同时 子线程开启(并非先加进去的先执行，速度不一定，可能主线程先开启或者某个子线程)
  [queue addOperation:op1];
  [queue addOperation:op2];
  [queue addOperation:op3];
  
  NSLog(@"这里是主线程");
}

@end

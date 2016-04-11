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
@property(nonatomic,assign)NSInteger tickets;
@end
@implementation MD_NSOperation_VC

#pragma mark - < vc lifecycle > -
-(void)viewDidLoad{

  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  [self test_NSOperationQueue];
}

#pragma mark - < method > -

#pragma mark 创建NSOperationObject
-(void)test_NSOperationObject{

  //自定义NSOperation
//  MyOperation *op = [[MyOperation alloc] init];
//  op.completionBlock = ^(){
//    NSLog(@"main finish ~~");
//  };
//  [op start];
  
  //NSBlockOperation
//  NSBlockOperation *opBlock = [NSBlockOperation blockOperationWithBlock:^{
//    NSLog(@"this is opBlock");
//  }];
//  
//  for (int i = 0; i < 5; i++) {
//    [opBlock addExecutionBlock:^{
//      NSLog(@"addExecutionBlock %d",i);
//    }];
//  }
//  
//  [opBlock setCompletionBlock:^{
//    NSLog(@"opBlock finish");
//  }];
//  
//  [opBlock start];
  
  //NSInvocationOperation
  NSInvocationOperation *iop = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(NSInvocationOperationAction) object:nil];
  iop.completionBlock = ^(){
    NSLog(@"iop finish");
  };
  [iop start];
}

-(void)NSInvocationOperationAction{
  NSLog(@"NSInvocationOperationAction");
}

#pragma mark NSOperationQueue
-(void)test_NSOperationQueue{

  NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"这里是子线程1代码 开始");
    [NSThread sleepForTimeInterval:1];
    NSLog(@"这里是子线程1代码 结束");
  }];
  
  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"这里是子线程2代码 开始");
    [NSThread sleepForTimeInterval:1];
    NSLog(@"这里是子线程2代码 结束");
  }];
  [op2 setQueuePriority:NSOperationQueuePriorityHigh];//优先级是相对正在排队的
  
  MyOperation *op3 = [[MyOperation alloc] init];
  
  
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//  [queue setMaxConcurrentOperationCount:2];//设置允许并发执行的线程数量 默认是-1 -1就是没有限制 大家一起来
  [queue addOperation:op1];//把子线程加入队列的同时 子线程开启(并非先加进去的先执行，速度不一定，可能主线程先开启或者某个子线程)
  [queue addOperation:op2];
  [queue addOperation:op3];
  
  NSLog(@"这里是主线程");
}

-(void)test1{
  
  self.tickets = 100;
  
  NSOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    while (YES) {
      NSLog(@"1号窗口售卖了%ld号票",(long)self.tickets);
      [NSThread sleepForTimeInterval:1];
      self.tickets--;
    }
  }];
  
  NSOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    while (YES) {
      NSLog(@"2号窗口售卖了%ld号票",(long)self.tickets);
      [NSThread sleepForTimeInterval:1];
      self.tickets--;
    }
  }];
  
//  MyOperation *op3 = [[MyOperation alloc] init];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  [queue setMaxConcurrentOperationCount:2];//设置允许并发执行的线程数量 默认是-1 -1就是没有限制 大家一起来
  
  //把子线程加入队列的同时 子线程开启(并非先加进去的先执行，速度不一定，可能主线程先开启或者某个子线程)
  [queue addOperation:op1];
  [queue addOperation:op2];
//  [queue addOperation:op3];
  
  NSLog(@"这里是主线程");
}



@end

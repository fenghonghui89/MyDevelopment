//
//  MD_GCD_group_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
/*
 如果某些任务需要更另一些任务完成后才执行，可以使用dispatch_group
 */

#import "MD_GCD_group_VC.h"

@interface MD_GCD_group_VC ()

@end

@implementation MD_GCD_group_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  //任务同步执行，效率大大降低
//  [self sync];
//  [self finish];
  
  //任务异步执行，无法确定顺序
//  [self async];
//  [self finish];
  
  //先异步执行一系列任务（1），完成后再执行特殊任务（2），保证效率，但会阻塞线程
  [self group];
  
  //先异步执行一系列任务（1），完成后再执行特殊任务（2），保证效率，也不会阻塞线程
//  [self group2];
}

#pragma mark - < method > -

#pragma mark 推导
-(void)sync{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(0, 0);
  
  for (int i = 0; i < 100; i++) {
    dispatch_sync(myQueue, ^{
      NSLog(@"下载图片:%d",i);
    });
  }
  
}


-(void)async{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
  for (int i = 0; i < 100; i++) {
    dispatch_async(myQueue, ^{
      NSLog(@"下载图片:%d",i);
    });
  }
  
}

-(void)finish{
  
  NSLog(@"全部完成");
}

#pragma mark dispatch_group_wait
-(void)group{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_group_t myGroup = dispatch_group_create();
  
  for (int i = 0; i < 100; i++) {
    dispatch_group_async(myGroup, myQueue, ^{
      NSLog(@"下载图片:%d",i);//异步
    });
  }
  
  //会阻塞当前线程，所以在主线程下不能调用
//  NSInteger result = dispatch_group_wait(myGroup, DISPATCH_TIME_FOREVER);
//  NSLog(@"result:%@",result == 0?@"success":@"error");
  
  dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*5);
  NSInteger result1 = dispatch_group_wait(myGroup, delayTime);
  NSLog(@"result1:%@",result1 == 0?@"success":@"error");
  
  [self finish];
}

#pragma mark dispatch_group_notify
-(void)group2{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(0, 0);
  dispatch_group_t myGroup = dispatch_group_create();
  
  for (int i = 0; i < 100; i++) {
    dispatch_group_async(myGroup, myQueue, ^{
      NSLog(@"下载图片:%d",i);
    });
  }
  
  dispatch_group_notify(myGroup, myQueue, ^{
    [self finish];
  });
  
}


@end

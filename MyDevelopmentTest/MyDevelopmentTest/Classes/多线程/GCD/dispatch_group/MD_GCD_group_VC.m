//
//  MD_GCD_group_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_GCD_group_VC.h"

@interface MD_GCD_group_VC ()
@property(nonatomic,strong)NSArray *arr;
@end

@implementation MD_GCD_group_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  _arr = @[@"111~",@"222~",@"333~"];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  //2步任务同步执行，效率大大降低
//    [self sync];
//    [self finish];
  
  //2步任务异步执行，无法确定顺序
//    [self async];
//    [self finish];
  
  //先异步执行一系列任务（1），完成后再执行特殊任务（2），保证效率，但会阻塞线程
//    [self group];
//    [self finish];
  
  //先异步执行一系列任务（1），完成后再执行特殊任务（2），保证效率，也不会阻塞线程
  [self group2];
}

#pragma mark - < method > -
-(void)sync{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(0, 0);
  
  for (int i = 0; i < _arr.count; i++) {
    dispatch_sync(myQueue, ^{
      NSLog(@"1:%@",_arr[i]);
    });
  }
}


-(void)async{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(0, 0);
  
  for (int i = 0; i < _arr.count; i++) {
    dispatch_async(myQueue, ^{
      NSLog(@"1:%@",_arr[i]);
    });
  }
}


-(void)group{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(0, 0);
  dispatch_group_t myGroup = dispatch_group_create();
  
  for (int i = 0; i < _arr.count; i++) {
    //把可以异步处理的任务加入到group中
    dispatch_group_async(myGroup, myQueue, ^{
      NSLog(@"1:%@",_arr[i]);
    });
  }
  
  //会阻塞线程，所以在主线程下不能调用
  dispatch_group_wait(myGroup, DISPATCH_TIME_FOREVER);
}


-(void)group2
{
  dispatch_queue_t myQueue = dispatch_get_global_queue(0, 0);
  dispatch_group_t myGroup = dispatch_group_create();
  
  //异步
  for (int i = 0; i < _arr.count; i++) {
    dispatch_group_async(myGroup, myQueue, ^{
      NSLog(@"1:%@",_arr[i]);
    });
  }
  
  dispatch_group_notify(myGroup, myQueue, ^{
    [self finish];
  });
}

-(void)finish
{
  NSLog(@"2:finish");
}
@end

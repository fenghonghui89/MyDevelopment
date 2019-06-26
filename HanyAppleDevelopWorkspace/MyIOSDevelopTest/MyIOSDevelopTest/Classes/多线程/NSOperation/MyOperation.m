//
//  MyOperation.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/11.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MyOperation.h"

@interface MyOperation ()

@end
@implementation MyOperation

-(void)main{
  
  if ([self isCancelled]) {
    return;
  }
  
  NSLog(@"这里是子线程3代码 开始");
  [NSThread sleepForTimeInterval:2];
  NSLog(@"这里是子线程3代码 结束");
}

-(BOOL)isFinished{
    return YES;
}

-(BOOL)isExecuting{
    return YES;
}
@end

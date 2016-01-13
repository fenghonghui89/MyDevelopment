//
//  TRMyTask.m
//  Day14NSOperation
//
//  Created by Tarena on 13-12-19.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRMyTask.h"

@implementation TRMyTask
//创建一个类继承NSOperation类 实现里面的main方法 main方法中写子线程的代码
-(void)main{
    NSLog(@"这里是子线程3代码 开始");
    [NSThread sleepForTimeInterval:2];
    NSLog(@"这里是子线程3代码 结束");
}
@end

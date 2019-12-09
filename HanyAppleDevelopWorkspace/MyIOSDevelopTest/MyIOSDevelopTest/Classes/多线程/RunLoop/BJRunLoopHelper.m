//
//  BJRunLoopHelper.m
//  XTJMall
//
//  Created by hanyfeng on 2019/6/17.
//  Copyright © 2019 hanyfeng. All rights reserved.
//

#import "BJRunLoopHelper.h"

#import "BJRootDefine.h"
#import "BJThread.h"


@interface BJRunLoopHelper ()
@property(nonatomic,strong)BJThread *thread;
@end
@implementation BJRunLoopHelper

-(void)dealloc{
    NSLog(@"♻️dealloc..");
}

#pragma mark - 在子线程开启runloop
-(void)start{
    BJThread *thread = [[BJThread alloc] initWithTarget:self selector:@selector(subThreadEntryPoint) object:nil];
    thread.name = @"BJThread";
    [thread start];
    self.thread = thread;
}

-(void)subThreadEntryPoint{
    @autoreleasepool {
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];

        NSLog(@"启动runloop前..%@",runLoop.currentMode);
        [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
        [runLoop run];
    }
}

#pragma mark - 在子线程执行func
-(void)processSubThread{
    [self performSelector:@selector(subThreadOperation) onThread:self.thread withObject:nil waitUntilDone:NO];
}

-(void)subThreadOperation{
    NSLog(@"启动runloop后...%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"%@..子线程任务开始",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:3];
    NSLog(@"%@..子线程任务结束",[NSThread currentThread]);
}


@end

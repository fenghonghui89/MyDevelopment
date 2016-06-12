//
//  MD_NSTimer_VC1.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_NSTimer_VC1.h"
#define FPS 30
@interface MD_NSTimer_VC1()
@property (nonatomic,assign) NSInteger   count;
@property(nonatomic,weak)NSTimer *timer;
@end
@implementation MD_NSTimer_VC1
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self nstimertest];
}

#pragma mark - < test > -
#pragma mark 基本
-(void)nstimertest
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(timer:)
                                   userInfo:nil
                                    repeats:YES];
    self.count = 0;
}

-(void)timer:(NSTimer *)timer
{
    NSString *str = nil;
    switch (self.count) {
        case 0:
            str = @"连接中";
            break;
        case 1:
            str = @"连接中.";
            break;
        case 2:
            str = @"连接中..";
            break;
        case 3:
            str = @"连接中...";
            break;
            
        default:
            break;
    }
    
    self.count ++;
    self.count %= 4;//等效于下面
//    if (self.count == 4) {
//        self.count = 0;
//    }
    
    NSLog(@"%@",str);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    [super viewWillDisappear:animated];
}

@end

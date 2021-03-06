//
//  MD_Touch_CustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/15.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//基本使用

#import "MD_Touch_CustomView.h"
@interface MD_Touch_CustomView()
@end
@implementation MD_Touch_CustomView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//Began 触发一次
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"began %lu",(unsigned long)[touches count]);
    for (UITouch* touch in touches) {//取出位置
        CGPoint location = [touch locationInView:self.superview];//位置的坐标（相对于指定视图坐标系的）
        NSLog(@"began: %.2f %.2f",location.x,location.y);
    }
}

//Moved 随移动触发多次
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"moved %lu",(unsigned long)[touches count]);
    for (UITouch* touch in touches) {
        CGPoint location = [touch locationInView:self.superview];
        NSLog(@"moved: %.2f %.2f",location.x,location.y);
    }
    
}

//Ended 触发一次
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ended %lu",(unsigned long)[touches count]);
    for (UITouch* touch in touches) {
        CGPoint location = [touch locationInView:self.superview];
        NSLog(@"ended: %.2f %.2f",location.x,location.y);
    }
}
@end

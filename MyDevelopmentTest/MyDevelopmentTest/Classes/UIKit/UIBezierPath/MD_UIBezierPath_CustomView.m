//
//  MD_UIBezierPath_CustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/7.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIBezierPath_CustomView.h"

@implementation MD_UIBezierPath_CustomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    /*注：
     注意代码顺序所造成的图层覆盖
     */
    
    [self customdrawRect:rect];
}

#pragma mark - < ation > -

#pragma mark 画线段
-(void)customdrawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(100, 200)];
    
    path.lineWidth = 10;
    
    [[UIColor greenColor] setStroke];
    
    [path stroke];
}

#pragma mark 画三角形
-(void)custom1drawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(100, 200)];
    [path addLineToPoint:CGPointMake(200, 100)];
//    [path addLineToPoint:CGPointMake(100, 100)];
    [path closePath];
    
    [[UIColor redColor] setFill];
    [[UIColor greenColor] setStroke];
    
    path.lineWidth = 10;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path fill];
    [path stroke];
}


@end

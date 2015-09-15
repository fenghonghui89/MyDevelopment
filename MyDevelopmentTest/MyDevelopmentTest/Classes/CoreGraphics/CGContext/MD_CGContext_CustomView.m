//
//  MD_CGContext_CustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/6.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_CGContext_CustomView.h"

@implementation MD_CGContext_CustomView

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
    
    [self custom3DrawRect:rect];
}
#pragma mark - < action > -
#pragma mark CGContextRef
-(void)customDrawRect:(CGRect)rect
{
    //背景
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置填充颜色、描边（默认黑色）
//    [[UIColor redColor] setFill];
//    [[UIColor greenColor] setStroke];
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    
    //定义路径
    CGContextMoveToPoint(context, 75, 10);
    CGContextAddLineToPoint(context, 10, 150);
    CGContextAddLineToPoint(context, 160, 150);
//    CGContextAddLineToPoint(context, 75, 10);
    CGContextClosePath(context);//闭合
    
    //绘制只能写一个，最后写
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark SaveGState RestoreGState
-(void)custom1DrawRect:(CGRect)rect
{
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 75, 10);
    CGContextAddLineToPoint(context, 10, 150);
    CGContextAddLineToPoint(context, 160, 150);
    CGContextClosePath(context);
    
    [[UIColor greenColor] setStroke];
    [[UIColor redColor] setFill];
    CGContextSaveGState(context);//保存图形上下文设置
    
    [[UIColor orangeColor] setFill];
    CGContextRestoreGState(context);//恢复上下文设置
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark 线段
-(void)custom2DrawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddLineToPoint(context, 30, 100);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextStrokePath(context);
}

#pragma mark 画曲线
-(void)custom3DrawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 50, 10);//起始点p1
    CGContextAddCurveToPoint(context,
                             10, 40,//控制点cp1-起始点的趋向
                             50, 110,//控制点cp2-结束点从哪来
                             10, 110);//结束点p2
    CGContextAddCurveToPoint(context,
                             50, 110,
                             10, 210,
                             50, 210);
    
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextStrokePath(context);
}
@end

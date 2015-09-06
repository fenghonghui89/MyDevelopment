//
//  MD_CGContext_CustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/6.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_CGContext_CustomView.h"

@implementation MD_CGContext_CustomView
-(void)drawRect:(CGRect)rect
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
    
    CGContextDrawPath(context, kCGPathFillStroke);
}
@end

//
//  TRMessageView.m
//  my08
//
//  Created by HanyFeng on 13-11-17.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRMessageView.h"

@implementation TRMessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //计算能容纳字符串的边框大小
    self.text = @"aegaegaegeaagegaegaegaegaeg";
    CGSize size = [self.text sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(200, 9999)];
    
    //绘制对话框背景
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(80, 20)];
    [path addArcWithCenter:CGPointMake(90, 20) radius:10 startAngle:M_PI endAngle:M_PI*1.5 clockwise:YES];
    [path addLineToPoint:CGPointMake(290, 10)];
    [path addArcWithCenter:CGPointMake(290, 20) radius:10 startAngle:M_PI*1.5 endAngle:0 clockwise:YES];
    [path addLineToPoint:CGPointMake(300, (size.height+20))];
    [path addLineToPoint:CGPointMake(310, (size.height+20)+10)];//斜线
    [path addLineToPoint:CGPointMake(90, (size.height+20)+10)];//底部直线
    [path addArcWithCenter:CGPointMake(90, (size.height+20)) radius:10 startAngle:M_PI*0.5 endAngle:M_PI clockwise:YES];
    [path closePath];
    
    //对话框背景上色
    [[UIColor greenColor] setFill];
    [path fill];
    
    //绘制文字
    [[UIColor blackColor] setFill];
    [self.text drawInRect:CGRectMake(90, 20, 200, size.height) withFont:[UIFont systemFontOfSize:20]];
    
    CGContextRestoreGState(context);
}


@end

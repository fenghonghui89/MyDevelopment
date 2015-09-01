//
//  TRView.m
//  my06
//
//  Created by HanyFeng on 13-11-16.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRView.h"

@implementation TRView

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
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 10)];//起始点
    [path addCurveToPoint:CGPointMake(10, 110)//结束点
            controlPoint1:CGPointMake(10, 10)//控制点1-起始点的趋向
            controlPoint2:CGPointMake(50, 110)];//控制点2-结束点从哪来
    
    [path addCurveToPoint:CGPointMake(50, 210)
            controlPoint1:CGPointMake(50, 110)
            controlPoint2:CGPointMake(10, 210)];
    
    [[UIColor grayColor] setStroke];
    path.lineWidth = 2;
    [path stroke];
    
    CGContextRestoreGState(context);
    
    
}


@end

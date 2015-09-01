//
//  TRView.m
//  my03
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
    
    //起点不在圆心
    [path moveToPoint:CGPointMake(100, 100)];
    [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)//圆心
                    radius:100//半径
                startAngle:0//起始角度对应的sin
                  endAngle:M_PI_2//终点角度对应的sin
                 clockwise:YES];//YES：顺时针画 NO：逆时针画
    [path closePath];//闭合路径
    
    //起点在圆心
//    [path moveToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
//    [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
//                    radius:100
//                startAngle:0
//                  endAngle:M_PI_2
//                 clockwise:YES];
//    [path closePath];
    
    [[UIColor redColor] setFill];
    [path fill];
    
    CGContextRestoreGState(context);
}


@end

//
//  TRView.m
//  my01
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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //用OC的API绘制三角形并上色
    
    //1.获取画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.保存状态
    CGContextSaveGState(context);
    
    //3.勾勒
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(100, 200)];
    [path addLineToPoint:CGPointMake(200, 100)];
    [path addLineToPoint:CGPointMake(100, 100)];

    //4.调色
    [[UIColor redColor] setFill];
    [[UIColor blackColor] setStroke];
    
    //5.给边框和图像上色
    [path fill];
    [path stroke];
    
    //6.恢复状态
    CGContextRestoreGState(context);
}


@end

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
    
    //用C语言的函数绘制三角形并上色
    
    //1.获取画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.保存状态
    CGContextSaveGState(context);
    
    //3.勾勒
    CGContextMoveToPoint(context, 100, 100);//移动到某个点
    CGContextAddLineToPoint(context, 100, 200);//画线
    CGContextAddLineToPoint(context, 200, 100);//画线
    CGContextAddLineToPoint(context, 100, 100);//画线
    
    //4.调色
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    //CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);//边框颜色
    
    //5.上色
    CGContextDrawPath(context, kCGPathFill);
    //CGContextDrawPath(context, kCGPathFillStroke);//给边框和图像上色
    
    //6.恢复状态
    CGContextRestoreGState(context);
}


@end

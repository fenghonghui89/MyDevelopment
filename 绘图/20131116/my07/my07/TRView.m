//
//  TRView.m
//  my07
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
    
    //绘制一行文本
    NSString* text = @"abc";
    [[UIColor redColor] setFill];
//    [text drawAtPoint:CGPointMake(10, 10) withFont:[UIFont systemFontOfSize:30]];//参数：起始点 字号
    
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:50.0f], NSFontAttributeName, nil];
    [text drawAtPoint:CGPointMake(10, 10) withAttributes:dic];
    
    //绘制多行文本
    NSString* text2 = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    [text2 drawInRect:CGRectMake(10, 100, 300, 100) withFont:[UIFont systemFontOfSize:20]];//参数：存放文字的矩形 字号
    
    //计算字符串所占空间
    NSString* text3 = @"aegaegaegaegaegiaegoaiaooiarjgaoirgaoirjgaoijga";
    CGSize size = [text3 sizeWithFont:[UIFont systemFontOfSize:24] constrainedToSize:CGSizeMake(200, 9999)];//参数：字号 约束范围（宽、高）
    NSLog(@"%.2f %2.f",size.width,size.height);//输出能存放文字的最小范围
    
    CGContextRestoreGState(context);
}


@end

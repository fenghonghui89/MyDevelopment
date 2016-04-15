//
//  MD_String_CustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//drawRect字符串

#import "MD_String_CustomView.h"

@implementation MD_String_CustomView
-(void)drawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);
    
    //drawAtPoint
    NSString *str = @"我的小狗";
    UIFont *font = [UIFont systemFontOfSize:34];
    UIColor *color = [UIColor redColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    [str drawAtPoint:CGPointMake(100, 20) withAttributes:dic];//设置绘制定点
    
    //drawInRect
    NSString *str1 = @"我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗我的小狗结束~";
    UIFont *font1 = [UIFont systemFontOfSize:14];
    UIColor *color1 = [UIColor greenColor];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:color1,NSForegroundColorAttributeName,font1,NSFontAttributeName, nil];
    CGFloat maxWidth = 200;
    CGRect strRect = [str1 boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic1 context:nil];
    [[UIColor whiteColor] setFill];
    UIRectFill(CGRectMake(10, 100, maxWidth, strRect.size.height));
    [str1 drawInRect:CGRectMake(10, 100, maxWidth, strRect.size.height) withAttributes:dic1];
}
@end

//
//  MD_UIIV_CustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIIV_CustomView.h"

@implementation MD_UIIV_CustomView
-(void)drawRect:(CGRect)rect
{
    [[UIColor orangeColor] setFill];
    UIRectFill(rect);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bg94w100h@2x" ofType:@"png"];
    UIImage *myImageObj = [[UIImage alloc] initWithContentsOfFile:path];
    [myImageObj drawInRect:CGRectMake(0, 40, 320, 400)];//图片绘制在指定矩形内
    [myImageObj drawAtPoint:CGPointMake(10, 10)];//以定点开始绘制
    [myImageObj drawAsPatternInRect:CGRectMake(0, 40, 320, 400)];//平铺
    
    NSString *str = @"我的小狗";
    UIFont *font = [UIFont systemFontOfSize:34];
    UIColor *color = [UIColor redColor];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    [str drawAtPoint:CGPointMake(100, 20) withAttributes:dic];//设置绘制定点
//    [str drawInRect:CGRectMake(100, 20, 100, 20) withAttributes:dic];//无效？
}
@end

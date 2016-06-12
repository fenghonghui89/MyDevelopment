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
}
@end

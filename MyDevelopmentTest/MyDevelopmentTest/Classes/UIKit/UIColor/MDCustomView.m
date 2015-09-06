//
//  MDCustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDCustomView.h"

@implementation MDCustomView
-(void)drawRect:(CGRect)rect
{
    [[UIColor redColor] setFill];//填充当前上下文颜色
    UIRectFill(rect);//填充矩形
    
    [[UIColor greenColor] setStroke];//填充当前上下文描边
    UIRectFrame(CGRectMake(10, 10, 50, 50));//矩形描边
}
@end

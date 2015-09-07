
//
//  MD_UIGraphics_CustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIGraphics_CustomView.h"

@implementation MD_UIGraphics_CustomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [self customdrawRect:rect];
}

#pragma mark - < ation > -
-(void)customdrawRect:(CGRect)rect
{
    [[UIColor redColor] setFill];//填充当前上下文颜色
    UIRectFill(rect);//填充矩形
    
    [[UIColor greenColor] setStroke];//填充当前上下文描边
    UIRectFrame(CGRectMake(10, 10, 50, 50));//矩形描边
}
@end

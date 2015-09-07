//
//  MDCustomView.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDCustomView.h"

@implementation MDCustomView

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
#pragma mark setFill setStroke
-(void)customdrawRect:(CGRect)rect
{
    /*注：
     1.只能对矩形填充或描边 如果对非矩形操作 用CGContext类方法先画路径
     2.注意代码顺序所造成的图层覆盖
     3.setFill setStroke 在drawRect下才有效
     */
    
    //场景1
    [[UIColor redColor] setFill];//填充当前上下文颜色
    UIRectFill(CGRectMake(10, 10, 50, 50));//填充矩形
    
    [[UIColor greenColor] setStroke];//填充当前上下文描边
    UIRectFrame(CGRectMake(10, 10, 50, 50));//矩形描边

//    //场景2
//    [[UIColor redColor] setFill];//填充当前上下文颜色
//    [[UIColor greenColor] setStroke];//填充当前上下文描边
//    UIRectFill(CGRectMake(10, 10, 50, 50));//填充矩形
//    UIRectFrame(CGRectMake(10, 10, 50, 50));//矩形描边
//    
//    //场景3
//    [[UIColor redColor] setFill];//填充当前上下文颜色
//    [[UIColor greenColor] setStroke];//填充当前上下文描边
//    UIRectFrame(CGRectMake(10, 10, 50, 50));//矩形描边
//    UIRectFill(CGRectMake(10, 10, 50, 50));//填充矩形

}
@end

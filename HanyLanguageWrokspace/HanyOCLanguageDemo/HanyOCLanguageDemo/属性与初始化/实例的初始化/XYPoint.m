//
//  XYPoint.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/21.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "XYPoint.h"

@implementation XYPoint
//1.2.不带初始化的类方法
+(id)xypoint
{
    return [[XYPoint alloc]init ];
}


-(void)xpoint:(int) x ypoint:(int)y
{
    self.xpoint = x;
    self.ypoint = y;
}

//2.2(1).工厂方法
+(id)xypointWithXpoint:(int)x yPoint:(int)y
{
    return [[XYPoint alloc]initWithXpoint:x yPoint:y];
}

-(id)initWithXpoint:(int)x yPoint:(int)y
{
    self = [super init];
    if (self = [super init]) {
        self.xpoint = x;
        self.ypoint = y;
    }
    return self;
}

-(void)show
{
    NSLog(@"(x.y):(%d.%d)",self.xpoint,self.ypoint);
}

@end

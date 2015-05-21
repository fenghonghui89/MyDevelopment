//
//  XYPoint.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/21.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYPoint : NSObject
@property int xpoint,ypoint;

+(id)xypoint;//1.不带初始化的类方法，命名方式：与类名称一样
-(void)xpoint:(int) x ypoint:(int)y;

//2.工厂方法-带初始化的类方法
+(id)xypointWithXpoint:(int)x yPoint:(int)y;

-(void)show;

@end

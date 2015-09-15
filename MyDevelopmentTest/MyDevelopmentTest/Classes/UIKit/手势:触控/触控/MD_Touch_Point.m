//
//  MD_Touch_Point.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/15.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MD_Touch_Point.h"

@implementation MD_Touch_Point

-(MD_Touch_Point *)initWithPoint:(CGPoint)point
{
    MD_Touch_Point *pointObj = [[MD_Touch_Point alloc] init];
    pointObj.point = point;
    return pointObj;
}

-(CGPoint)cgpoint
{
    return self.point;
}
@end

//
//  MDNSValueViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNSValueViewController.h"

@interface MDNSValueViewController ()

@end

@implementation MDNSValueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //定义结构体
    typedef struct POINT {
        int x;
        int y;
    }Point;
    
    //声明一个结构体变量并给成员赋值
    Point p;
    p.x=3;
    p.y=4;
    
    //封装成对象
    NSValue* value = [NSValue valueWithBytes:&p objCType:@encode(Point)];
    
    //解封
    Point newPoint;
    [value getValue:&newPoint];
    NSLog(@"point: x:%d,y:%d",newPoint.x,newPoint.y);
}

@end

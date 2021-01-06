//
//  MD_UIBezierPath_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIBezierPath_ViewController.h"
#import "MD_UIBezierPath_CustomView.h"
#import "MD_UIBezierPath_CustomView1.h"
@implementation MD_UIBezierPath_ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self uibezierpathTest1];
}

#pragma mark - < test > -
//基本用法
-(void)uibezierpathTest
{
    MD_UIBezierPath_CustomView *v = [[MD_UIBezierPath_CustomView alloc] initWithFrame:CGRectMake(10, 10, viewW-20, viewH-20)];
    [self.view addSubview:v];
}

//示例：根据进度条的值画圆弧
-(void)uibezierpathTest1
{
    MD_UIBezierPath_CustomView1 *v = [[MD_UIBezierPath_CustomView1 alloc] initWithFrame:CGRectMake(10, 10, viewW-20, viewH-20)];
    [self.view addSubview:v];
}
@end

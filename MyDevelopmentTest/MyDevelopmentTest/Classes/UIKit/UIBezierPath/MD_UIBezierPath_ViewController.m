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
    [self uibezierpathTest];
}

#pragma mark - < test > -
//基本用法
-(void)uibezierpathTest
{
    MD_UIBezierPath_CustomView *v = [[MD_UIBezierPath_CustomView alloc] initWithFrame:[MDTool setRectX:10 y:10 w:viewW-20 h:viewH-20]];
    [self.view addSubview:v];
}

//示例：根据进度条的值画圆弧
-(void)uibezierpathTest1
{
    MD_UIBezierPath_CustomView1 *v = [[MD_UIBezierPath_CustomView1 alloc] initWithFrame:[MDTool setRectX:10 y:10 w:viewW-20 h:viewH-20]];
    [self.view addSubview:v];
}
@end

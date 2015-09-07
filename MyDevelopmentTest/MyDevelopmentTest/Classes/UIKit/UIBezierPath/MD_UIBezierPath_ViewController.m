//
//  MD_UIBezierPath_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIBezierPath_ViewController.h"
#import "MD_UIBezierPath_CustomView.h"
@implementation MD_UIBezierPath_ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self uibezierpathTest];
}

-(void)uibezierpathTest
{
    MD_UIBezierPath_CustomView *v = [[MD_UIBezierPath_CustomView alloc] initWithFrame:[MDTool setRectX:10 y:10 w:viewW-20 h:viewH-20]];
    [self.view addSubview:v];
}
@end

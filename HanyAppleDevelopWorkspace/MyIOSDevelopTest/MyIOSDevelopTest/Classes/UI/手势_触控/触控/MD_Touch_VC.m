//
//  MD_Touch_VC.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/15.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_Touch_VC.h"
#import "MD_Touch_CustomView.h"//基本使用
#import "MD_Touch_CustomView1.h"//练习：点击拖动画出矩形
#import "MD_Touch_CustomView2.h"//练习：画多条线

@implementation MD_Touch_VC
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self customInitUI];
}

-(void)customInitUI
{
    MD_Touch_CustomView2 *v = [[MD_Touch_CustomView2 alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:v];
}
@end

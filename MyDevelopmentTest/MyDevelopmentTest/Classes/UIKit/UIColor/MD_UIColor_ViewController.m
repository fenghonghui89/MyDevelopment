//
//  MD_UIColor_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIColor_ViewController.h"
#import "MDCustomView.h"
@interface MD_UIColor_ViewController()
@end

@implementation MD_UIColor_ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self uicolortest];
}

#pragma mark other
-(void)uicolortest
{
    MDCustomView *view = [[MDCustomView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
}@end

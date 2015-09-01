//
//  MD_UIGraphics_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIGraphics_ViewController.h"
#import "MD_UIGraphics_CustomView.h"
@implementation MD_UIGraphics_ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self uicolortest];
}

#pragma mark other
-(void)uicolortest
{
    MD_UIGraphics_CustomView *view = [[MD_UIGraphics_CustomView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
}

@end

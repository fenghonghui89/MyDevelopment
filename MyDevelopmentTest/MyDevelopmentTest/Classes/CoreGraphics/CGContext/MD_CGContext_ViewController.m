//
//  MD_CGContext_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_CGContext_ViewController.h"
#import "MD_CGContext_CustomView.h"
@implementation MD_CGContext_ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self cgcontexttest0];
}

-(void)cgcontexttest0
{
    MD_CGContext_CustomView *v = [[MD_CGContext_CustomView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:v];
}
@end

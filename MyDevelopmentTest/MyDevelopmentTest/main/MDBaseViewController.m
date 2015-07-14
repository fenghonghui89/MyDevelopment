//
//  MDBaseViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDBaseViewController.h"


@interface MDBaseViewController ()

@end

@implementation MDBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.view/navi/tabbar
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    [self.view setFrame:[MDTool setRectX:0 y:0 w:screenW h:screenH-naviH]];
    NSLog(@"视图尺寸：%@",NSStringFromCGRect(self.view.frame));
}


@end

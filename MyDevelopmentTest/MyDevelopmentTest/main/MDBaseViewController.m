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

    //self.view
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        [self.view setFrame:[MDTool setRectX:0 y:0 w:defaultViewW h:defaultViewH-naviH]];
    }else{
        [self.view setFrame:[MDTool setRectX:0 y:0 w:defaultViewW h:defaultViewH-naviH-stateH]];
    }
    
    NSLog(@"当前view%@",NSStringFromCGRect(self.view.frame));
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //navi
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = nil;
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    
    //tab
    self.tabBarController.tabBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    //navi
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
    self.navigationController.navigationBar.barTintColor = nil;
    
    //tab
    self.tabBarController.tabBar.translucent = NO;
    
    [super viewWillDisappear:animated];
}
@end

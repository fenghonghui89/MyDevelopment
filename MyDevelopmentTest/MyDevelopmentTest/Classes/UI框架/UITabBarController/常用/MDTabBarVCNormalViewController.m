//
//  MDTabBarVCNormalViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/4.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDTabBarVCNormalViewController.h"
#import "MDTBVC1ViewController.h"
#import "MDTBVC2ViewController.h"
@interface MDTabBarVCNormalViewController ()

@end

@implementation MDTabBarVCNormalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MDTBVC1ViewController *vc1 = [[MDTBVC1ViewController alloc] init];
    vc1.navigationItem.title = @"1";
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navi1.tabBarItem.title = @"1";
  
    
    MDTBVC2ViewController *vc2 = [[MDTBVC2ViewController alloc] init];
    vc2.navigationItem.title = @"2";
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    navi2.tabBarItem.title = @"2";
    
    UITabBarController *tbVC = [[UITabBarController alloc] init];
    tbVC.viewControllers = @[navi1,navi2];
    
    [self presentViewController:tbVC animated:YES completion:nil];
}



@end

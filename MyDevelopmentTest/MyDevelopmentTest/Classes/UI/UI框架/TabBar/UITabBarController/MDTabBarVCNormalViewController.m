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
  
  [self test1];
}

-(void)test1{
  MDTBVC1ViewController *vc1 = [[MDTBVC1ViewController alloc] init];
  vc1.navigationItem.title = @"1";
  UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:vc1];
  navi1.tabBarItem.title = @"1";
  
  MDTBVC2ViewController *vc2 = [[MDTBVC2ViewController alloc] init];
  vc2.navigationItem.title = @"2";
  UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:vc2];
  navi2.tabBarItem.title = @"2";
  navi2.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
  
  MDTBVC2ViewController *vc3 = [[MDTBVC2ViewController alloc] init];
  vc3.navigationItem.title = @"3";
  UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:vc3];
  navi3.tabBarItem.title = @"3";
  navi3.tabBarItem.badgeValue = @"哈";
  [navi3.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor purpleColor]} forState:UIControlStateSelected];
  
  MDTBVC2ViewController *vc4 = [[MDTBVC2ViewController alloc] init];
  vc4.navigationItem.title = @"4";
  UINavigationController *navi4 = [[UINavigationController alloc] initWithRootViewController:vc4];
  UITabBarItem *item4 = [[UITabBarItem alloc] init];
  item4.title = @"4";
  item4.image = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  item4.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  navi4.tabBarItem.title = @"4";
//  navi4.tabBarItem.titlePositionAdjustment = UIOffsetMake(5, 5);
//  navi4.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  navi4.tabBarItem.image = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  navi4.tabBarItem = item4;
  
  MDTBVC2ViewController *vc5 = [[MDTBVC2ViewController alloc] init];
  vc5.navigationItem.title = @"5";
  UINavigationController *navi5 = [[UINavigationController alloc] initWithRootViewController:vc5];
  navi5.tabBarItem.title = @"5";
  
  MDTBVC2ViewController *vc6 = [[MDTBVC2ViewController alloc] init];
  vc6.navigationItem.title = @"6";
  UINavigationController *navi6 = [[UINavigationController alloc] initWithRootViewController:vc6];
  navi6.tabBarItem.title = @"6";
  
  MDTBVC2ViewController *vc7 = [[MDTBVC2ViewController alloc] init];
  vc7.navigationItem.title = @"7";
  UINavigationController *navi7 = [[UINavigationController alloc] initWithRootViewController:vc7];
  navi7.tabBarItem.title = @"7";
  
  UITabBarController *tbVC = [[UITabBarController alloc] init];
  tbVC.viewControllers = @[navi1,navi2,navi3,navi4,navi5,navi6,navi7];//默认最多显示5个，超过5个就显示前4个+more
  
  //超过5个不会显示more 只显示5个
//  [tbVC addChildViewController:navi1];
//  [tbVC addChildViewController:navi2];
//  [tbVC addChildViewController:navi3];
//  [tbVC addChildViewController:navi4];
//  [tbVC addChildViewController:navi5];
//  [tbVC addChildViewController:navi6];
//  [tbVC addChildViewController:navi7];
  
  
  [self presentViewController:tbVC animated:YES completion:nil];
}

-(void)test2{

  MDTBVC1ViewController *vc1 = [[MDTBVC1ViewController alloc] init];
  vc1.navigationItem.title = @"1";
  UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:vc1];
  
  MDTBVC2ViewController *vc2 = [[MDTBVC2ViewController alloc] init];
  vc2.navigationItem.title = @"2";
  UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:vc2];
  
  MDTBVC2ViewController *vc3 = [[MDTBVC2ViewController alloc] init];
  vc3.navigationItem.title = @"3";
  UINavigationController *navi3 = [[UINavigationController alloc] initWithRootViewController:vc3];
  
  NSArray *vcs = @[navi1,navi2,navi3];
  
  UITabBarController *tbVC = [[UITabBarController alloc] init];
  tbVC.viewControllers = vcs;
  
  NSArray *imgNames = @[@"tabbar_home",@"tabbar_discover",@"tabbar_profile"];
  NSArray *selectedImgNames = @[@"tabbar_home_selected",@"tabbar_discover_selected",@"tabbar_profile_selected"];
  NSArray *titles = @[@"1",@"2",@"3"];
  
  NSMutableArray *items = [NSMutableArray array];
  for (int i = 0; i<3; i++) {
    UIImage *img = [[UIImage imageNamed:imgNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImg = [[UIImage imageNamed:selectedImgNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i] image:img selectedImage:selectedImg];
    [items addObject:item];
    
    UINavigationController *navi = vcs[i];
    navi.tabBarItem = item;
  }
  
//  [tbVC.tabBar setItems:items];//不能通过[tabvc.tabbar setitems]修改 会崩
  [tbVC.tabBar setBarTintColor:[UIColor redColor]];
  
  [self presentViewController:tbVC animated:YES completion:nil];
}

@end

//
//  DGCMainVC.m
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/6.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import "DGCMainViewController.h"
#import "DGCNavigationViewController.h"
#import "DGCTabBarController.h"
#import "DGCTabBarItem.h"
#import "DGCDefine.h"
#import "DGCTool.h"
#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
@interface DGCMainViewController ()
@property (nonatomic,retain)DGCTabBarController * tabBarController;
@end

@implementation DGCMainViewController

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  [self customInitTabBarViewController];
}

#pragma mark - < method > -
-(void)customInitTabBarViewController{

  ViewController *vc = [[ViewController alloc] init];
  vc.mainViewController = self;
  DGCNavigationViewController *nvc = [[DGCNavigationViewController alloc] initWithRootViewController:vc];
  nvc.mainViewController = self;
  DGCTabBarItem *item = [[DGCTabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon-home.png"]
                                               selectedImage:[UIImage imageNamed:@"icon-home-on.png"]
                                                         tag:0];
  nvc.tabBarItem = item;
  
  ViewController1 *vc1 = [[ViewController1 alloc] init];
  vc1.mainViewController = self;
  DGCNavigationViewController *nvc1 = [[DGCNavigationViewController alloc] initWithRootViewController:vc1];
  nvc1.mainViewController = self;
  DGCTabBarItem *item1 = [[DGCTabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon-spa.png"]
                                               selectedImage:[UIImage imageNamed:@"icon-spa-on.png"]
                                                         tag:1];
  nvc1.tabBarItem = item1;
  
  ViewController2 *vc2 = [[ViewController2 alloc] init];
  vc2.mainViewController = self;
  DGCNavigationViewController *nvc2 = [[DGCNavigationViewController alloc] initWithRootViewController:vc2];
  nvc2.mainViewController = self;
  DGCTabBarItem *item2 = [[DGCTabBarItem alloc] initWithImage:[UIImage imageNamed:@"icon-test.png"]
                                                selectedImage:[UIImage imageNamed:@"icon-test-on.png"]
                                                          tag:2];
  nvc2.tabBarItem = item2;
  
  DGCTabBarController *tbc = [[DGCTabBarController alloc] initWithViewControllers:@[nvc,nvc1,nvc2]];
  tbc.mainViewController = self;
  tbc.view.frame = CGRectMake(0, 0, screenW, screenH);
  [self.view addSubview:tbc.view];
  self.tabBarController = tbc;//防止提前被释放
}
#pragma mark - < action > -

#pragma mark - < callback > -
@end

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
}

-(void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  //navi
  self.navigationController.navigationBar.translucent = NO;
  self.navigationController.navigationBar.backgroundColor = nil;
  self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
  
  //tab
  self.tabBarController.tabBar.translucent = NO;
  
  //self.view
  [self.view setBackgroundColor:[UIColor redColor]];
  
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
    [self.view setFrame:[MDTool setRectX:0 y:0 w:defaultViewW h:defaultViewH-naviH]];
  }else{
    [self.view setFrame:[MDTool setRectX:0 y:0 w:defaultViewW h:defaultViewH-naviH-stateH]];
  }
  [self.view layoutIfNeeded];
  NSLog(@"当前view%@",NSStringFromCGRect(self.view.frame));
}

@end

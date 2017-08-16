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

- (void)viewDidLoad{
  
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;//设置vc不渗透
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  DLog(@"当前screen%@",NSStringFromCGSize([[UIScreen mainScreen] bounds].size));
  DLog(@"当前navi%@",NSStringFromCGSize(self.navigationController.navigationBar.bounds.size));
  DLog(@"当前view%@",NSStringFromCGRect(self.view.frame));
}

-(BOOL)shouldAutorotate{
  
  return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
  
  return UIInterfaceOrientationMaskPortrait;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end

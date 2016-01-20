//
//  MDNavigationController.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/20.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDNavigationController.h"

@interface MDNavigationController ()

@end

@implementation MDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(BOOL)shouldAutorotate
{
  return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return [self.topViewController supportedInterfaceOrientations];
}
@end

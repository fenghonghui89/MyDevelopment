//
//  MDBaseViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDBaseViewController.h"
#import "MDTool.h"
@interface MDBaseViewController ()

@end

@implementation MDBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view setFrame:[MDTool setRectX:0 y:0 w:[MDTool screenWidth] h:[MDTool screenHeight]-[MDTool navigationBarHeight]]];
    
    NSLog(@"视图尺寸：%@",NSStringFromCGRect(self.view.frame));
}


@end

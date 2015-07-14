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
    
//    //bgview
//    UIView *bgView = [[UIView alloc] init];
//    [bgView setBackgroundColor:[UIColor clearColor]];
//    CGFloat bgViewY = 0;
//    CGFloat bgViewW = screenW;
//    CGFloat bgViewH = 0;
//    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if (systemVersion < 7.0) {
//        bgViewY = naviH;
//        bgViewH = screenH - stateH - naviH;
//    }else{
//        bgViewY = naviH;
//        bgViewH = screenH - naviH;
//    }
//    [bgView setFrame:[MDTool setRectX:0 y:bgViewY w:bgViewW h:bgViewH]];
//    [self.view addSubview:bgView];
//    self.bgView = bgView;
    
    NSLog(@"视图尺寸：%@",NSStringFromCGRect(self.view.frame));
}


@end

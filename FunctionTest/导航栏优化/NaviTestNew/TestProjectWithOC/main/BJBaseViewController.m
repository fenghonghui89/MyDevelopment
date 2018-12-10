//
//  BJBaseViewController.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/16.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "BJBaseViewController.h"

@interface BJBaseViewController ()

@end

@implementation BJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    /*
     MARK:
     默认no
     no-vc.view的原点在navi下 yes-vc.view的原点在屏幕左上角
     如果xib顶部的控件，top约束是距离safeArea，则不管yes or no，控件都是在navi下
     如果xib顶部的控件，top约束是距离superView，则no-控件原点在navi下，yes-控件原点在屏幕左上角，即根据superView位置而定
     
     b - 不透明navi的vc
     a - 透明navi的vc
     b push到a，如果a为yes，则a的navi变化会有延迟，所以如果有透明navi的vc，尽量设置为yes
     a push到b，不管a为yes or no，都正常
     */
    self.extendedLayoutIncludesOpaqueBars = YES;
}


//MARK:判断如果是页面是navigationController中的第一个页面就禁止左划手势，不然在第一个页面执行左划手势后在push不到第二个页面
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.firstObject == self) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}



@end

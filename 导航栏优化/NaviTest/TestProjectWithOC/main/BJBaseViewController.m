//
//  BJBaseViewController.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/16.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "BJBaseViewController.h"
#import "UINavigationController+Test.h"
@interface BJBaseViewController ()

@end

@implementation BJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



//-(void)setNavBarBgAlpha:(CGFloat)navBarBgAlpha{
//    _navBarBgAlpha = navBarBgAlpha;
//    [self.navigationController setNeedsNavigationBackground:navBarBgAlpha];
//}
//
////判断如果是页面是navigationController中的第一个页面就禁止左划手势，不然在第一个页面执行左划手势后在push不到第二个页面
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    if (self.navigationController.viewControllers.firstObject == self) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = false;
//    }else{
//        self.navigationController.interactivePopGestureRecognizer.enabled = true;
//    }
//}
//
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}
//
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//
//}


@end

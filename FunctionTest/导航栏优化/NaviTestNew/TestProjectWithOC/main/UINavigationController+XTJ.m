//
//  UINavigationController+XTJ.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/1.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "UINavigationController+XTJ.h"
#import "BJBaseViewController.h"
@implementation UINavigationController (XTJ)


#pragma mark - system
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    UIViewController* topVC = self.topViewController;
    
    return [topVC preferredStatusBarStyle];
    
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    
    return self.topViewController;
}

#pragma mark - push / pop
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated isNeedLogin:(BOOL)isNeedLogin{
    
    BOOL managerIsLogined = NO;
    if (isNeedLogin) {
        if (!managerIsLogined) {//需要登录但未登录
            NSLog(@"需要登录但未登录...");
        }else{//需要登录且已登录
            [self pushViewController:viewController animated:animated];
        }
    }else{//不需要登录
        [self pushViewController:viewController animated:animated];
    }
    
}

#pragma mark - public
//-(instancetype)xa_initWithRootViewController:(UIViewController *)rootViewController{
//    
//    UINavigationController *nc = [self initWithRootViewController:rootViewController];
//    if (nc) {
//        [self configSwipeRight:YES];
//    }
//    return nc;
//}
//
////右滑退出开关
//-(void)configSwipeRight:(BOOL)isNeed{
//    
//    // 使右滑返回手势可用
//    if (isNeed) {
//        [self setNavigationBarHidden:NO animated:NO];
//    }else{
//        [self setNavigationBarHidden:YES animated:NO];
//        
//    }
//    
//}
@end

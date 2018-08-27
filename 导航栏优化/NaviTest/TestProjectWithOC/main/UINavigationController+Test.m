//
//  UINavigationController+Test.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/16.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "UINavigationController+Test.h"
#import "BJBaseViewController.h"
#import <objc/runtime.h>
@implementation UINavigationController (Test)

static char * key_isGrTransitioning = "isGrTransitioning";

-(void)setIsGrTransitioning:(BOOL)isGrTransitioning{
    objc_setAssociatedObject(self, key_isGrTransitioning, @(isGrTransitioning), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isGrTransitioning{
    NSNumber *value = objc_getAssociatedObject(self, key_isGrTransitioning);
    return [value boolValue];
}

- (void)setNeedsNavigationBackground:(CGFloat)alpha{
    
    CGFloat realAlpha = 0;
    if (alpha>1) {
        realAlpha = 1;
    }if (alpha<0) {
        realAlpha = 0;
    }else{
        realAlpha = alpha;
    }

    // 导航栏背景透明度设置
    UIView *barBackgroundView = [[self.navigationBar subviews] objectAtIndex:0];// _UIBarBackground
    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];// UIImageView
    if (self.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = realAlpha;
        } else {
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = realAlpha;
            }
        }
    } else {
        barBackgroundView.alpha = realAlpha;
    }

    // 对导航栏下面那条线做处理
    self.navigationBar.clipsToBounds = realAlpha == 0.0;
}

+ (void)initialize {
    if (self == [UINavigationController self]) {

        // 交换方法
        SEL originalSelector = NSSelectorFromString(@"_updateInteractiveTransition:");
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);

        SEL swizzledSelector = NSSelectorFromString(@"et__updateInteractiveTransition:");
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);

        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


// 交换的方法，监控滑动手势
- (void)et__updateInteractiveTransition:(CGFloat)percentComplete {

    //调用原方法
    [self et__updateInteractiveTransition:(percentComplete)];

    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator > coor = topVC.transitionCoordinator;
        if (coor != nil) {
            // 随着滑动的过程设置导航栏透明度渐变
            BJBaseViewController *fromVC = [coor viewControllerForKey:UITransitionContextFromViewControllerKey];
            CGFloat fromAlpha = fromVC.navBarBgAlpha;

            BJBaseViewController *toVC = [coor viewControllerForKey:UITransitionContextToViewControllerKey];
            CGFloat toAlpha = toVC.navBarBgAlpha;

            CGFloat nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percentComplete;
            
            if (fromAlpha>toAlpha) {
                NSLog(@"变透明from:%f, to:%f, now:%f",fromAlpha, toAlpha, nowAlpha);
                [self setNeedsNavigationBackground:nowAlpha];
            }else{
                NSLog(@"变实色from:%f, to:%f, now:%f",fromAlpha, toAlpha, nowAlpha);
                [self setNeedsNavigationBackground:nowAlpha];
            }
        }
    }

}


@end

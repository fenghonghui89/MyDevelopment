//
//  RotationDismissAnimation.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/21.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "RotationDismissAnimation.h"
#import "UIView+MotionBlur.h"
#import "ViewController.h"
#import "PresentedViewController.h"

@implementation RotationDismissAnimation

//返回动画的时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

//在进行切换的时候将调用该方法，我们对于切换时的UIView的设置和动画都在这个方法中完成
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    PresentedViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];//当前vc
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];//上一个vc
    
    CGRect initRect = [transitionContext initialFrameForViewController:fromVC];//当前vc的初始位置
    CGRect finalRect = CGRectOffset(initRect, 0, [UIScreen mainScreen].bounds.size.height);//dismiss后的位置
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    [fromVC.view enableBlurWithAngle:M_PI_2 completion:^{
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0f
             usingSpringWithDamping:0.6f
              initialSpringVelocity:1.0f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             fromVC.view.frame = finalRect;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }];
}
@end

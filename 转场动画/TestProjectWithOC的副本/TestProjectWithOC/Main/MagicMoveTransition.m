//
//  MagicMoveTransition.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/9/30.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "MagicMoveTransition.h"
#import "ViewController.h"
#import "PresentedViewController.h"
@interface MagicMoveTransition ()


@end
@implementation MagicMoveTransition

#pragma mark - UIViewControllerAnimatedTransitioning
////指定转场动画持续的时长
//- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
//    return 0.3f;
//}
//
////转场动画的具体内容
//-(void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//
//
//    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    ViewController1 *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView *containerView = [transitionContext containerView];
//
//    UIView *fromView = fromVC.bg_image;
//    UIView *snapShotView = [fromView snapshotViewAfterScreenUpdates:NO];
//    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
//    fromView.hidden = YES;
//
//    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
//    toVC.view.alpha = 0;
//
//    [containerView addSubview:snapShotView];
//    [containerView addSubview:toVC.view];
//
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                     animations:^{
//                         toVC.view.alpha = 1;
//                         snapShotView.frame = [containerView convertRect:toVC.view.frame fromView:toVC.view];
//                     }
//                     completion:^(BOOL finished) {
//                         fromView.hidden = NO;
//                     }];
//
//    //告诉系统动画结束
//    [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //1 要呈现的VC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //2
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalRect, 0, [[UIScreen mainScreen]bounds].size.height);//rect 按照（dx,dy）进行平移
    
    //3 将view添加到containerView中
    [[transitionContext containerView] addSubview:toVC.view];
    
    //4
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear animations:^{
                            toVC.view.frame = finalRect;
                        }
                     completion:^(BOOL finished) {
                         //5
                         [transitionContext completeTransition:YES];
                     }];
    
    
}
@end

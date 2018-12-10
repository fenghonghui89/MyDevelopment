//
//  MagicMoveInverseTransition.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/9/30.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "MagicMoveInverseTransition.h"
#import "ViewController.h"
#import "PresentedViewController.h"

@implementation MagicMoveInverseTransition

#pragma mark - UIViewControllerAnimatedTransitioning

//指定转场动画持续的时长
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

//转场动画的具体内容
-(void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    PresentedViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *goodsImageView = fromVC.goodsImageView;
    UIView *snapShotView = [goodsImageView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:goodsImageView.frame fromView:goodsImageView.superview];
    goodsImageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.bg_image.hidden = YES;
    
    //顺序很重要 会影响最终效果
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVC.view.alpha = 0.0f;
                         snapShotView.frame = [containerView convertRect:toVC.bg_image.frame fromView:toVC.view];
                     }
                     completion:^(BOOL finished) {
                         [snapShotView removeFromSuperview];
                         
                         toVC.bg_image.hidden = NO;
                         fromVC.goodsImageView.hidden = NO;
                         
                         //告诉系统动画结束
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}
@end

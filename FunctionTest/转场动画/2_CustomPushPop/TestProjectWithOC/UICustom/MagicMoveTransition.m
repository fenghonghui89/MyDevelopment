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
//指定转场动画持续的时长
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.6f;
}

//转场动画的具体内容
-(void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

    PresentedViewController *toVC  = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    //对Cell上的 imageView 截图，同时将这个 imageView 本身隐藏
    UIView *cellView = fromVC.bg_image;
    UIView *snapShotView = [cellView snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [containerView convertRect:cellView.frame fromView:cellView.superview];//将rect从fromView中转换到当前视图中，返回在当前视图中的rect
    cellView.hidden = YES;

    //设置第二个控制器的位置、透明度
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.goodsImageView.hidden = YES;

    //把动画前后的两个ViewController加到容器中 顺序很重要 会影响最终效果
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    //动起来。第二个控制器的透明度0~1；让截图SnapShotView的位置更新到最新
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:0.6f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [containerView layoutIfNeeded];
                         toVC.view.alpha = 1;
                         snapShotView.frame = [containerView convertRect:toVC.goodsImageView.frame fromView:toVC.view];
                     }
                     completion:^(BOOL finished) {
                         toVC.goodsImageView.hidden = NO;
                         cellView.hidden = NO;
                         [snapShotView removeFromSuperview];
                         
                         //一定要告诉系统动画结束
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
    
}

@end

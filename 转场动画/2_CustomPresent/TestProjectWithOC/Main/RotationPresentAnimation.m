//
//  RotationPresentAnimation.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/21.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "RotationPresentAnimation.h"


@interface RotationPresentAnimation ()

@end
@implementation RotationPresentAnimation

//返回动画的时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

//在进行切换的时候将调用该方法，我们对于切换时的UIView的设置和动画都在这个方法中完成
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //对于要呈现的VC，我们希望它从屏幕下方出现，因此将初始位置设置到屏幕下边缘
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalRect, 0, [[UIScreen mainScreen] bounds].size.height);//rect 按照（dx,dy）进行平移
    
    //将view添加到containerView中
    [[transitionContext containerView] addSubview:toVC.view];
    
    //开始动画。这里的动画时间长度和切换时间长度一致
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVC.view.frame = finalRect;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];//在动画结束后我们必须向context报告VC切换完成，是否成功。系统在接收到这个消息后，将对VC状态进行维护
                     }];
}
@end

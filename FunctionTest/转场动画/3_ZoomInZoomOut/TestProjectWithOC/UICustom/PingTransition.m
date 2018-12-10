//
//  PingTransition.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/26.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "PingTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"
@interface PingTransition()
<
CAAnimationDelegate
>
@property(nonatomic,strong)id<UIViewControllerContextTransitioning> transitionContext;
@end
@implementation PingTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    ViewController * fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *contView = [transitionContext containerView];
    
    UIButton *button = fromVC.button;
    
    [contView addSubview:fromVC.view];
    [contView addSubview:toVC.view];
    
    
    //创建两个圆形的 UIBezierPath 实例；一个是 button 的 size ，另外一个则拥有足够覆盖屏幕的半径。最终的动画则是在这两个贝塞尔路径之间进行的
    UIBezierPath *maskStartBP =  [UIBezierPath bezierPathWithOvalInRect:button.frame];
    
    //判断触发点在那个象限 一般在初始点的正上方或正下方
    CGPoint finalPoint;
    if(button.frame.origin.x > (toVC.view.bounds.size.width / 2)){
        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第一象限
            finalPoint = CGPointMake(button.center.x - 0, button.center.y - CGRectGetMaxY(toVC.view.bounds)+30);
        }else{
            //第四象限
            finalPoint = CGPointMake(button.center.x - 0, button.center.y - 0);
        }
    }else{
        if (button.frame.origin.y < (toVC.view.bounds.size.height / 2)) {
            //第二象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - CGRectGetMaxY(toVC.view.bounds)+30);
        }else{
            //第三象限
            finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - 0);
        }
    }
    
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));//通过勾股定理计算半径
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
    
    
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    toVC.view.layer.mask = maskLayer;
    
    //创建一个关于 path 的 CABasicAnimation 动画来从 circleMaskPathInitial.CGPath 到 circleMaskPathFinal.CGPath 。同时指定它的 delegate 来在完成动画时做一些清除工作
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

#pragma mark - CABasicAnimation的Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:![self. transitionContext transitionWasCancelled]];
    
    //清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    
}
@end

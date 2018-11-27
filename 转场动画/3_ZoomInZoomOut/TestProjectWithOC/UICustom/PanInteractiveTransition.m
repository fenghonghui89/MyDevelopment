//
//  PanInteractiveTransition.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/27.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "PanInteractiveTransition.h"

@interface PanInteractiveTransition()
@property(nonatomic,weak)UIViewController *pushedVC;//pushed后显示的vc，注意是weak

@end
@implementation PanInteractiveTransition

-(void)panToPop:(UIViewController *)viewcontroller{
    self.pushedVC = viewcontroller;
    
    //自定义pop后 没有了右滑返回 要自己添加手势？
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePan:)];
    edgeGes.edges = UIRectEdgeLeft;
    [self.pushedVC.view addGestureRecognizer:edgeGes];
}

-(void)edgePan:(UIScreenEdgePanGestureRecognizer *)recognizer{
    
    CGFloat per = [recognizer translationInView:self.pushedVC.view].x / (self.pushedVC.view.bounds.size.width);
    per = MIN(1.0,(MAX(0.0, per)));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        [self.pushedVC.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:per];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        self.interacting = NO;
//        if (per > 0.05) {
//            [self finishInteractiveTransition];
//        }else{
//            [self cancelInteractiveTransition];//如果是cancle状态 动画结束后页面不会消失
//        }
        [self finishInteractiveTransition];
    }
    
}
@end

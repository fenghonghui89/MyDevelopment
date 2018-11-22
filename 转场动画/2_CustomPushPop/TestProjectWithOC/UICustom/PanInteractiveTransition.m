//
//  PanInteractiveTransition.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/22.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "PanInteractiveTransition.h"

@interface PanInteractiveTransition ()
@property(nonatomic,weak)UIViewController *pushedVC;//pushed后显示的vc，注意是weak
@end
@implementation PanInteractiveTransition
-(void)panToPop:(UIViewController *)viewcontroller{
    self.pushedVC = viewcontroller;
    
    //自定义pop后 没有了右滑返回 要自己添加手势？
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;//设置从什么边界滑入
    [self.pushedVC.view addGestureRecognizer:edgePanGestureRecognizer];
}

-(void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer{
    
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.pushedVC.view].x / self.pushedVC.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
    
    //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        [self.pushedVC.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded){
        //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        self.interacting = NO;
        if (progress > 0.1) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
    
}
@end

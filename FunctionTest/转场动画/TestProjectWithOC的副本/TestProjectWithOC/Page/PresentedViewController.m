//
//  PresentedViewController.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/9/30.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "PresentedViewController.h"
#import "MagicMoveInverseTransition.h"
@interface PresentedViewController ()
<
UINavigationControllerDelegate
>
@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
//    //设置从什么边界滑入
//    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
//    [self.view addGestureRecognizer:edgePanGestureRecognizer];
}

#pragma mark - action
-(void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer{
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / self.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
    
    //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded){
        //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }else{
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
    }
    
}

- (IBAction)tap:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPresentedVC:)]) {
        [self.delegate didPresentedVC:self];
    }
}

#pragma mark - UINavigationControllerDelegate
//- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
//    if ([animationController isKindOfClass:[MagicMoveInverseTransition class]]) {
//        return self.percentDrivenTransition;
//    }else{
//        return nil;
//    }
//}

@end

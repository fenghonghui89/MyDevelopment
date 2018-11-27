//
//  PresentedViewController1.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/9/30.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "PresentedViewController1.h"
#import "MagicMoveInverseTransition.h"
#import "ViewController.h"
@interface PresentedViewController1 ()
<
UINavigationControllerDelegate
>
@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation PresentedViewController1

-(void)dealloc{
    NSLog(@"dealloc...");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义pop后 没有了右滑返回 要自己添加手势？
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
    //设置从什么边界滑入
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

#pragma mark - action
-(void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer{
    
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / self.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间

    //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象;如果点击导航栏或按钮返回，要返回nil，所以滑动才创建对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded){
        //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.9) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }else{
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
    
}

- (IBAction)tap:(id)sender {
    self.percentDrivenTransition = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{

    if ([toVC isKindOfClass:[ViewController class]]) {
        MagicMoveInverseTransition *transition = [[MagicMoveInverseTransition alloc] init];
        return transition;
    }else{
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    if ([animationController isKindOfClass:[MagicMoveInverseTransition class]]) {
        //MARK:如果点击导航栏或按钮返回，要返回nil，如果依然返回对象，会无效。因此在滑动开始时才赋值属性
        return self.percentDrivenTransition ? self.percentDrivenTransition:nil;
    }else{
        return nil;
    }
}

@end

//
//  ViewController.m
//  TestProjectWithOC
//
//  Created by 冯鸿辉 on 2017/3/7.
//  Copyright © 2017年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController.h"

#import "RotationPresentAnimation.h"
#import "PanInteractiveTransition.h"
#import "RotationDismissAnimation.h"

#import "PresentedViewController.h"
@interface ViewController ()
<
PresentedVCDelegate,UIViewControllerTransitioningDelegate
>
@property(nonatomic,strong)RotationPresentAnimation *presentAnimation;
@property(nonatomic,strong)RotationDismissAnimation *dismissAnimation;
@property(nonatomic,strong)PanInteractiveTransition *panInteractiveTransition;
@end

@implementation ViewController


#pragma mark - life
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.presentAnimation = [[RotationPresentAnimation alloc] init];
        self.dismissAnimation = [[RotationDismissAnimation alloc] init];
        self.panInteractiveTransition = [[PanInteractiveTransition alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - action
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PresentedViewController *pvc = segue.destinationViewController;
    pvc.delegate = self;
    pvc.transitioningDelegate = self;
    [self.panInteractiveTransition panToDismiss:pvc];
}

#pragma mark - PresentedVCDelegate
-(void)didPresentedVC:(PresentedViewController *)viewcontroller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
//自定义present
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source{
    return self.presentAnimation;
}

//自定义dismiss 会跟手势diss冲突 只能二选一
//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    return self.dismissAnimation;
//}

//手势diss 会跟自定义dismiss冲突 只能二选一
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    
    return self.panInteractiveTransition.interacting ? self.panInteractiveTransition : nil;
}
@end

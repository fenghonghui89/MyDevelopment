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
//present action
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PresentedViewController *pvc = segue.destinationViewController;
    pvc.delegate = self;
    pvc.transitioningDelegate = self;//不设置就不会触发自定义present和自定义dismiss
    [self.panInteractiveTransition panToDismiss:pvc];//手势dismiss
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

//自定义dismiss
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.dismissAnimation;
}

//手势diss
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{

    //不需要？
//    if (self.panInteractiveTransition.interacting) {
//        NSLog(@"yes..%@",self.panInteractiveTransition);
//        return self.panInteractiveTransition;
//    }else{
//        NSLog(@"no..%@",self.panInteractiveTransition);
//        return nil;
//    }
    
    return nil;
}
@end

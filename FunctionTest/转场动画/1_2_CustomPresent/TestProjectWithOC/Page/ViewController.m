//
//  ViewController.m
//  TestProjectWithOC
//
//  Created by 冯鸿辉 on 2017/3/7.
//  Copyright © 2017年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController.h"

#import "RotationPresentAnimation.h"

#import "PresentedViewController.h"
@interface ViewController ()
<
PresentedVCDelegate,UIViewControllerTransitioningDelegate
>
@property(nonatomic,strong)RotationPresentAnimation *presentAnimation;
@end

@implementation ViewController


#pragma mark - life
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.presentAnimation = [[RotationPresentAnimation alloc] init];
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
    pvc.transitioningDelegate = self;
}

#pragma mark - PresentedVCDelegate
-(void)didPresentedVC:(PresentedViewController *)viewcontroller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                 presentingController:(UIViewController *)presenting
                                                                     sourceController:(UIViewController *)source{
    return self.presentAnimation;
}

@end

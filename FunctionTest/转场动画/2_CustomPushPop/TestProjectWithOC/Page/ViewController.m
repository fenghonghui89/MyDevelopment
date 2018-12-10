//
//  ViewController.m
//  TestProjectWithOC
//
//  Created by 冯鸿辉 on 2017/3/7.
//  Copyright © 2017年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController.h"

#import "XTJRootDefine.h"

#import "MagicMoveTransition.h"

#import "PresentedViewController.h"
@interface ViewController ()
<
UINavigationControllerDelegate
>

@end

@implementation ViewController


#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
}


#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{

    if ([toVC isKindOfClass:[PresentedViewController class]]) {
        MagicMoveTransition *transition = [[MagicMoveTransition alloc] init];
        return transition;
    }else{
        return nil;
    }
}

@end

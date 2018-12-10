//
//  PresentedViewController.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/9/30.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "PresentedViewController.h"
#import "MagicMoveInverseTransition.h"
#import "PanInteractiveTransition.h"
#import "ViewController.h"
@interface PresentedViewController ()
<
UINavigationControllerDelegate
>
@property(nonatomic,strong)PanInteractiveTransition *percentDrivenTransition;

@end

@implementation PresentedViewController

-(void)dealloc{
    NSLog(@"dealloc...");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.percentDrivenTransition = [[PanInteractiveTransition alloc] init];
    [self.percentDrivenTransition panToPop:self];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

#pragma mark - action

- (IBAction)tap:(id)sender {
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
        if (self.percentDrivenTransition.interacting) {
            NSLog(@"yes滑动~%@",self.percentDrivenTransition);
            return self.percentDrivenTransition;
        }else{
            NSLog(@"yes非滑动...%@",self.percentDrivenTransition);
            return nil;
        }
    }else{
        NSLog(@"no~%@",self.percentDrivenTransition);
        return nil;
    }
}

@end

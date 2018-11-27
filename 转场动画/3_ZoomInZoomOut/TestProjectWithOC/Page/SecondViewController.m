//
//  PresentedViewController.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/9/30.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "SecondViewController.h"

#import "XTJRootDefine.h"

#import "ViewController.h"
#import "PingInvertTransition.h"
#import "PanInteractiveTransition.h"

@interface SecondViewController ()
<
UINavigationControllerDelegate
>
@property(nonatomic,strong)PanInteractiveTransition *percentDrivenTransition;
@end

@implementation SecondViewController

-(void)dealloc{
    
    NSLog(@"dealloc...");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.percentDrivenTransition = [[PanInteractiveTransition alloc] init];
    [self.percentDrivenTransition panToPop:self];
    
    self.view.backgroundColor = [UIColor randomColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

#pragma mark - action
- (IBAction)popClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPop) {
        PingInvertTransition *pingInvert = [PingInvertTransition new];
        return pingInvert;
    }else{
        return nil;
    }
}

//MARK:手势滑动转场 有时候vc不会消失？
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    if ([animationController isKindOfClass:[PingInvertTransition class]]) {
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

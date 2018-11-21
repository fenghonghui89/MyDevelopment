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
UINavigationControllerDelegate,PresentedVCDelegate
>
@property(nonatomic,strong)MagicMoveTransition *presentAnimation;
@end

@implementation ViewController


#pragma mark - life
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        self.presentAnimation = [[MagicMoveTransition alloc] init];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PresentedViewController *pvc = segue.destinationViewController;
    pvc.delegate = self;
}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    
//    self.navigationController.delegate = self;
//}

#pragma mark - PresentedVCDelegate
-(void)didPresentedVC:(PresentedViewController *)viewcontroller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate
//- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                   animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                fromViewController:(UIViewController *)fromVC
//                                                  toViewController:(UIViewController *)toVC{
//
////    if ([toVC isKindOfClass:[ViewController1 class]]) {
////        MagicMoveTransition *transition = [[MagicMoveTransition alloc] init];
////        return transition;
////    }else{
////        return nil;
////    }
//
//    if (operation == UINavigationControllerOperationPush) {
//        MagicMoveTransition *transition = [[MagicMoveTransition alloc] init];
//        return transition;
//    }else{
//        return nil;
//    }
//}

@end

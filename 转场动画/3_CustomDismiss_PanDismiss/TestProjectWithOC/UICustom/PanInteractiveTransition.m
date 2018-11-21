//
//  PanInteractiveTransition.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/21.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "PanInteractiveTransition.h"

@interface PanInteractiveTransition ()
@property(nonatomic,strong)UIViewController *presentedVC;//present后显示的vc
@property(nonatomic,assign)BOOL critical;//是否超过临界值
@end

@implementation PanInteractiveTransition

-(void)panToDismiss:(UIViewController *)viewcontroller{
    self.presentedVC = viewcontroller;
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [self.presentedVC.view addGestureRecognizer:panGR];
}

-(void)panGestureAction:(UIPanGestureRecognizer *)gesture{
    
    CGPoint translation = [gesture translationInView:self.presentedVC.view];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            self.interacting =  YES;
            break;
        }
        case UIGestureRecognizerStateChanged:{
            //1.这里数据可以自己慢慢调
            CGFloat percent = (translation.y/100) <= 1 ? (translation.y/100):1;
            self.critical = (percent > 0.5);
            [self updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            //2
            self.interacting = NO;
            if (gesture.state == UIGestureRecognizerStateCancelled || !self.critical) {
                [self cancelInteractiveTransition];
            }else{
                [self finishInteractiveTransition];
                if (self.critical) {
                    [self.presentedVC dismissViewControllerAnimated:YES completion:nil];
                }
            }
            break;
        }
            
        default:
            break;
    }
}
@end

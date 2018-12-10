//
//  ViewController.m
//  TestProjectWithOC
//
//  Created by 冯鸿辉 on 2017/3/7.
//  Copyright © 2017年 JiepengZhengDevExtend. All rights reserved.
//

/*
 要隐藏navibar，在sb的navigationController的第四个检查器，把show navigation bar的勾去掉
 */

#import "ViewController.h"

#import "XTJRootDefine.h"
#import "PingTransition.h"
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

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

- (IBAction)buttonTap:(id)sender {
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {

        PingTransition *ping = [PingTransition new];
        return ping;
    }else{
        return nil;
    }
}

@end

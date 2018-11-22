//
//  ViewController.m
//  TestProjectWithOC
//
//  Created by 冯鸿辉 on 2017/3/7.
//  Copyright © 2017年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController.h"


#import "PresentedViewController.h"
@interface ViewController ()
<
PresentedVCDelegate
>

@end

@implementation ViewController


#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    PresentedViewController *pvc = segue.destinationViewController;
    pvc.delegate = self;
}

#pragma mark - PresentedVCDelegate
-(void)didPresentedVC:(PresentedViewController *)viewcontroller{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

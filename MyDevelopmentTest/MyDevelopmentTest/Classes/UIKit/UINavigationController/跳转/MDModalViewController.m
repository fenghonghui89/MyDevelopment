//
//  MDModalViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/2.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDModalViewController.h"
#import "MDModal1ViewController.h"
@interface MDModalViewController ()

@end

@implementation MDModalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    [btn setTitle:@"改变" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)tap
{
    MDModal1ViewController *vc = [[MDModal1ViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

@end

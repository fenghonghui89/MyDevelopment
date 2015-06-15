//
//  MDModal1ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/2.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDModal1ViewController.h"

@interface MDModal1ViewController ()

@end

@implementation MDModal1ViewController

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
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

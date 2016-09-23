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
}

- (IBAction)presentTap:(id)sender {
  
  MDModal1ViewController *vc = [[MDModal1ViewController alloc] initWithNibName:@"MDModal1ViewController" bundle:nil];
  vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)pushTap:(id)sender {
  MDModal1ViewController *vc = [[MDModal1ViewController alloc] initWithNibName:@"MDModal1ViewController" bundle:nil];
  UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
  [self presentViewController:nc animated:YES completion:nil];
}

@end

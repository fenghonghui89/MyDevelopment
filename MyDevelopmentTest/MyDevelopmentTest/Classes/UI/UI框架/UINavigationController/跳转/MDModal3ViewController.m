//
//  MDModal3ViewController.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/9/20.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDModal3ViewController.h"

@interface MDModal3ViewController ()

@end

@implementation MDModal3ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (IBAction)btnTap:(id)sender {
  
//  [self.navigationController popToRootViewControllerAnimated:YES];
  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end

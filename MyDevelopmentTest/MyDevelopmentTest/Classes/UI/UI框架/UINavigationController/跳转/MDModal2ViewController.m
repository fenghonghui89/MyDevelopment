//
//  MDModal2ViewController.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/14.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDModal2ViewController.h"
#import "MDModal3ViewController.h"
@interface MDModal2ViewController ()

@end

@implementation MDModal2ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)naviPopBtnTap:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)naviPushBtnTap:(id)sender {
  
  MDModal3ViewController *vc3 = [[MDModal3ViewController alloc] initWithNibName:@"MDModal3ViewController" bundle:nil];
  [self.navigationController pushViewController:vc3 animated:YES];
}

@end

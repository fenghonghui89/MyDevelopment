//
//  MDModal1ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/2.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//修改返回键

#import "MDModal1ViewController.h"
#import "MDModal2ViewController.h"

@interface MDModal1ViewController ()

@end

@implementation MDModal1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
  /*
   方法1 - 看以下代码 在vc重新设置返回键
   方法2 - 看UINavigationItem+MDCustom.h，重写方法
   方法3 - 看UINavigationItem+MDCustom.h，替换方法
   */
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"方法1" style:UIBarButtonItemStylePlain target:nil action:NULL];
  
  NSLog(@"title..%@",self.navigationItem.backBarButtonItem.title);
}


- (IBAction)dismissTap:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)naviPushTap:(id)sender
{
  MDModal2ViewController *vc2 = [[MDModal2ViewController alloc] initWithNibName:@"MDModal2ViewController" bundle:nil];
  [self.navigationController pushViewController:vc2 animated:YES];
}

@end

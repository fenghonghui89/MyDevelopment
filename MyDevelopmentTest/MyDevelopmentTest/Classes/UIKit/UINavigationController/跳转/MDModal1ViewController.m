//
//  MDModal1ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/2.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDModal1ViewController.h"
#import "MDModal2ViewController.h"
@interface MDModal1ViewController ()

@end

@implementation MDModal1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
//  //方法1
//  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"方法1" style:UIBarButtonItemStylePlain target:nil action:NULL];
//  NSLog(@"%@",self.navigationItem.backBarButtonItem.title);
}


- (IBAction)dismissTap:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)navipresentTap:(id)sender
{
  MDModal2ViewController *vc2 = [[MDModal2ViewController alloc] initWithNibName:@"MDModal2ViewController" bundle:nil];
  [self.navigationController pushViewController:vc2 animated:YES];
}

@end

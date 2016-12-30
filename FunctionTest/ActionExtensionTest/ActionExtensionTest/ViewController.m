//
//  ViewController.m
//  ActionExtensionTest
//
//  Created by 冯鸿辉 on 2016/11/3.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)btnTap:(id)sender {
  
  NSArray *itemArray = @[[UIImage imageNamed:@"alert.png"],@"demoLogo",[NSURL URLWithString:@"http://tpages.cn"]];
  UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:itemArray applicationActivities:nil];
  [self presentViewController:activityViewController animated:YES completion:nil];
}

@end

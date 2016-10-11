//
//  ViewController.m
//  LBSMapTest
//
//  Created by 冯鸿辉 on 16/3/21.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController3.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

//地图 定位
- (IBAction)btn1Tap:(id)sender {
  ViewController1 *vc1 = [[ViewController1 alloc] initWithNibName:@"ViewController1" bundle:nil];
  [self.navigationController pushViewController:vc1 animated:YES];
}

//搜索
- (IBAction)btn2Tap:(id)sender {
  ViewController3 *vc3 = [[ViewController3 alloc] initWithNibName:@"ViewController3" bundle:nil];
  [self.navigationController pushViewController:vc3 animated:YES];
}

@end

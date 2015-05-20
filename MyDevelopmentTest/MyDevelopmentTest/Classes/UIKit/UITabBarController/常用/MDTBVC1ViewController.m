//
//  MDTBVC1ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/4.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDTBVC1ViewController.h"
#import "MDTBVC3ViewController.h"
@interface MDTBVC1ViewController ()

@end

@implementation MDTBVC1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    [btn setTitle:@"改变" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

-(void)tap
{
    MDTBVC3ViewController *vc3 = [[MDTBVC3ViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;//跳转时隐藏tabbar
    [self.navigationController pushViewController:vc3 animated:YES];
    self.hidesBottomBarWhenPushed = NO;//返回时显示tabbar
}

@end

//
//  MD_UIControl_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/5/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_UIControl_VC.h"
#import "MDSubclassUIControl.h"
@interface MD_UIControl_VC ()

@end

@implementation MD_UIControl_VC

- (void)viewDidLoad {
  
  [super viewDidLoad];
  [self customizeInitUI];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self customizeInitUI];
}
-(void)customizeInitUI{
  
  UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
  [bgView setBackgroundColor:[UIColor orangeColor]];
  [self.view addSubview:bgView];
  
  MDSubclassUIControl *btn = [[MDSubclassUIControl alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
  btn.img = [UIImage imageNamed:@"000.jpg"];
  [bgView addSubview:btn];
}

@end

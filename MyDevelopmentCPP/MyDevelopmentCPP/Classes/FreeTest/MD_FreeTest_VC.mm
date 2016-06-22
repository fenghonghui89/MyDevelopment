//
//  MD_FreeTest_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/26.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_FreeTest_VC.h"
#import "CPPFreeTest.hpp"
@interface MD_FreeTest_VC ()<UIGestureRecognizerDelegate>


@end

@implementation MD_FreeTest_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  test_root_freetest();
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  
}

#pragma mark - < method > -

-(void)customInitUI{
  
}

#pragma mark - < action > -
- (IBAction)btnTap:(id)sender {
  
}

#pragma mark - < callback > -

@end

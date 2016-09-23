//
//  MD_Runtime_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
/*
 initialize不是init
 运行时间的行为之一就是initialize。虽然看起来有点像大家常见的init，但是他们并不相同。
 在程序运行过程中，它会在你程序中每个类调用一次initialize。这个调用的时间发生在你的类接收到消息之前，但是在它的超类接收到initialize之后。
 */
#import "MD_Runtime_VC.h"
#import "TRXYZ.h"
#import "TRPoint.h"
@interface MD_Runtime_VC ()

@end
@implementation MD_Runtime_VC

#pragma mark - ************** override **************
-(void)viewDidLoad{

  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [self test_initialize];
}

#pragma mark - ************** method **************
-(void)test_initialize{
  
  TRPoint *p = [TRPoint new];
  TRPoint *p1 = [TRPoint new];
  
  TRXYZ *xyz = [TRXYZ new];

}
@end

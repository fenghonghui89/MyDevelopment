//
//  MD_FreeTest_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/26.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_FreeTest_VC.h"

@interface MD_FreeTest_VC ()

@end

@implementation MD_FreeTest_VC
#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self tttest];
}

#pragma mark - < method > -
-(void)customInitUI{
  NSString *str = NSStringFromSelector(@selector(tttest));
  NSLog(@"%@",str);
}

-(void)tttest{
  int i = 0;
  switch (i) {
    case 0:
    case 1:
    case 2:
    {
      NSLog(@"i");
    }
      break;
      
    default:
      break;
  }
}
#pragma mark - < callback > -

@end

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
  [self customInitUI];
}

#pragma mark - < method > -
-(void)customInitUI{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  NSString *str1 = [paths objectAtIndex:0];
  NSString *path = [str1 stringByAppendingString:@"responsesInfo.plist"];
  NSLog(@"pat");
}

#pragma mark - < callback > -

@end

//
//  MDPredicateViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/4.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDPredicateViewController.h"

@interface MDPredicateViewController ()

@end

@implementation MDPredicateViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSArray *array = [[NSArray alloc]initWithObjects:@"beijing",@"shanghai",@"guangzou",@"wuhan", nil];
  
//  //包含xxx字符
//  NSString *str1 = @"ang";
//  NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"self contains[c] %@",str1];
//  NSArray *resultArr1 = [array filteredArrayUsingPredicate:pred1];
//  NSLog(@"---1:%@",resultArr1);
//  
//  //以xxx开头
//  NSString *str2 = @"b";
//  NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"self beginswith[c] %@",str2];
//  NSArray *resultArr2 = [array filteredArrayUsingPredicate:pred2];
//  NSLog(@"---2:%@",resultArr2);
  
  NSPredicate *pred3 = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//    NSString *str = (NSString *)evaluatedObject;
//    return [str isEqualToString:@"guangzhou"];
    return YES;
  }];
  
  NSArray *arr3 = [array filteredArrayUsingPredicate:pred3];
  if (arr3 && arr3.count>0) {
    NSLog(@"%@",arr3[0]);
  }else{
    NSLog(@"have no..");
  }
}

//正则表达式判断
-(BOOL)test0{
    NSString *ipRegex = @"(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])";
    NSPredicate *ipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ipRegex];
    return [ipTest evaluateWithObject:self];
}

@end

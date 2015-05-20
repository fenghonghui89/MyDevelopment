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
    
    //包含xxx字符
    NSString *str1 = @"ang";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"self contains[c] %@",str1];
    NSArray *resultArr1 = [array filteredArrayUsingPredicate:pred1];
    NSLog(@"---1:%@",resultArr1);
    
    //以xxx开头
    NSString *str2 = @"b";
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"self beginswith[c] %@",str2];
    NSArray *resultArr2 = [array filteredArrayUsingPredicate:pred2];
    NSLog(@"---2:%@",resultArr2);

}



@end

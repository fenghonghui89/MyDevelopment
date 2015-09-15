//
//  MDObject1ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDObject1ViewController.h"
#import "TRStudent1.h"
@interface MDObject1ViewController ()

@end

@implementation MDObject1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TRStudent1* student = [[TRStudent1 alloc] init];//类都是先加载再初始化
    
    student.age = 18;
    student.name = @"张三";
    TRStudent1* student2 = [student copy];
    
    NSLog(@"student:%p %@ %d",student,student.name,student.age);
    NSLog(@"student2:%p %@ %d",student2,student2.name,student2.age);

}


@end

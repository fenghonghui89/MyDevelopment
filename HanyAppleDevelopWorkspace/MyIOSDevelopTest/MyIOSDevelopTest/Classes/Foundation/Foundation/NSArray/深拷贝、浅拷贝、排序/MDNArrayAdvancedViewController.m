//
//  MDNArrayAdvancedViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNArrayAdvancedViewController.h"
#import "MD_Model3.h"
#import "MD_Model2.h"
@interface MDNArrayAdvancedViewController ()

@end

@implementation MDNArrayAdvancedViewController

#pragma mark - < overwrite >
#pragma mark * vc lifecycle
- (void)viewDidLoad{
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  [self advanced_NSArrayCopy];
}

#pragma mark - < method >
#pragma mark 数组的深拷贝、浅拷贝
-(void)advanced_NSArrayCopy{
  
  TRStudent *student1 = [TRStudent studentWithName:@"zhangsan" age:13];
  TRStudent *student2 = [TRStudent studentWithName:@"lisi" age:14];
  NSArray* arr = @[student1,student2];
  NSLog(@"arr:%@,%p",arr,arr[0]);
  /*
   arr:(
   "<TRStudent: 0x170227680>",
   "<TRStudent: 0x1702275e0>"
   ),0x170227680
   */
  
  
  //数组的浅拷贝-以下都是
  NSArray *arr_shallow = arr;
//  NSArray *arr_shallow = [NSArray arrayWithArray:arr];
//  NSArray* arr_shallow = [[NSArray alloc] initWithArray:arr copyItems:NO];
  NSLog(@"arr_shallow:%@,%p",arr_shallow,arr_shallow[0]);
  /*
   arr_shallow:(
   "<TRStudent: 0x170227680>",
   "<TRStudent: 0x1702275e0>"
   ),0x170227680
   */
  
  
  //数组的深拷贝-NSCopying协议
  NSArray* arr_deep = [[NSArray alloc] initWithArray:arr copyItems:YES];
  NSLog(@"arr_deep:%@,%p",arr_deep,arr_deep[0]);
  /*
   arr_deep:(
   "<TRStudent: 0x1742290c0>",
   "<TRStudent: 0x1742295e0>"
   ),0x1742290c0
   */
  
}

#pragma mark 数组的排序
-(void)advanced_NSArraySort{
  
  NSArray* array = @[@"zhangsan",@"lisi",@"wangwu"];
  NSLog(@"array:%@",array);
  NSArray* newarray =  [array sortedArrayUsingSelector:@selector(compare:)];
  //默认按从小到大排序，注意冒号是方法名的一部分
  //compare只负责返回0，1(升序)或者-1(降序)，然后sorted方法根据返回的结果进行排序
  //sorted方法会自动对第一二个元素进行比较、排序，然后会自动循环
  NSLog(@"newarray:%@",newarray);
}

#pragma mark 数组排序练习：输入三个学生对象，1.按照姓名排序输出2.按照年龄排序3.年龄相同的情况下按照姓名排序
-(void)test_NSArraySort
{
  //创建三个对象并放入数组
  TRStudent* student = [TRStudent studentWithName:@"zhangsan" age:20];
  TRStudent* student2 = [TRStudent studentWithName:@"lisi" age:10];
  TRStudent* student3 = [TRStudent studentWithName:@"wangwu" age:30];
  NSArray* array = @[student,student2,student3];
  NSLog(@"array:%@",array);
  
  NSArray* array2 = [array sortedArrayUsingSelector:@selector(compareStudentWithName:)];//根据选择的方法进行排序
  NSLog(@"array2:%@",array2);
}

@end

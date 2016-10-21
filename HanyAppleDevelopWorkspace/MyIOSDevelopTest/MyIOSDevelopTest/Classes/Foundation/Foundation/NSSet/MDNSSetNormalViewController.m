//
//  MDNSSetNormalViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

/*
 集合:1.不允许重复 2.无序
 可以存在于集合里面元素：不同类的对象，同类或子类但实例变量值不同的(要注意重写hash和isEqual方法)
 
 hash
 有可能相等
 （来自api说明）如果isEqual返回yes则hash则一定相等，可变对象放在容器中一定要确保对象状态不变或者hash不根据于对象状态
 
 如果a对象的父类实现了hash和isEqual，只要hash和isEqual通用，则子类不用实现
 如果a对象有属性是自定义类型 或者是“元素是自定义类型”的容器类型 则自定义类型也要实现hash和isEqual 否则无法正确判断
 */

#import "MDNSSetNormalViewController.h"
#import "MD_Model3.h"


@interface MDNSSetNormalViewController ()

@end

@implementation MDNSSetNormalViewController

- (void)viewDidLoad{
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  [self test_NSSet];
}
#pragma mark - < method >
#pragma mark * NSSet hash方法 isEqual方法
-(void)test_NSSet{
  
  NSArray *arr = [TRMidStudent testData];
  TRMidStudent *student = arr[0];
  TRMidStudent *student2 = arr[1];

  
  DRLog(@"student hash:%ld student2 hash:%ld",(unsigned long)[student hash],(unsigned long)[student2 hash]);
  DRLog(@"is equal..%d",[student isEqual:student2]);
 
  NSSet *set = [NSSet setWithObjects:student,student2,nil];
  NSLog(@"set..%@",set);
  NSLog(@"finish...");
}

#pragma mark * 用NSSet重构练习：1学校-2学院-4班级-8学生 遍历所有学生
-(void)test_NSSet1{
  
  TRStudent* student1 = [TRStudent studentWithName:@"a1" age:1];
  TRStudent* student2 = [TRStudent studentWithName:@"a2" age:2];
  TRStudent* student3 = [TRStudent studentWithName:@"a3" age:3];
  TRStudent* student4 = [TRStudent studentWithName:@"a4" age:4];
  TRStudent* student5 = [TRStudent studentWithName:@"a6" age:5];
  TRStudent* student6 = [TRStudent studentWithName:@"a6" age:6];
  TRStudent* student7 = [TRStudent studentWithName:@"a7" age:7];
  TRStudent* student8 = [TRStudent studentWithName:@"a8" age:8];
  
  NSSet* class1 = [NSSet setWithObjects:student1,student2, nil];
  NSSet* class2 = [NSSet setWithObjects:student3,student4, nil];
  NSSet* class3 = [NSSet setWithObjects:student5,student6, nil];
  NSSet* class4 = [NSSet setWithObjects:student7,student8, nil];
  
  NSSet* college1 = [NSSet setWithObjects:class1,class2, nil];
  NSSet* college2 = [NSSet setWithObjects:class3,class4, nil];
  
  NSSet* school = [NSSet setWithObjects:college1,college2, nil];
  
  for (NSSet* tempcollege in school) {
    for (NSSet* tempclass in tempcollege) {
      for (TRStudent* tempstudent in tempclass) {
        NSLog(@"name:%@,age:%ld",tempstudent.name,(long)tempstudent.age);
      }
    }
  }
  
}
@end

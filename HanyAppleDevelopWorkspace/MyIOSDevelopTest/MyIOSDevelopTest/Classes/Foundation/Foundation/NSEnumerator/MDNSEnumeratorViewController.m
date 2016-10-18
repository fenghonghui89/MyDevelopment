//
//  MDNSEnumeratorViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//
/*
 迭代器用完一次后不会回到原来的位置
 每循环一次下移一位
 对于可变数组进行枚举操作时，主要不要添加或删除数组中的对象
 */

#import "MDNSEnumeratorViewController.h"
#import "MD_Model2.h"
@interface MDNSEnumeratorViewController ()

@end

@implementation MDNSEnumeratorViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self normal_NSEnumerator];
  
}

#pragma mark 遍历或反向遍历
-(void)normal_NSEnumerator
{
  TRStudent6* student1 = [TRStudent6 new];
  student1.name = @"张三";
  student1.age = 18;
  TRStudent6* student2 = [TRStudent6 new];
  student2.name = @"李四";
  student2.age = 20;
  TRStudent6* student3 = [TRStudent6 new];
  student3.name = @"王五";
  student3.age = 30;
  NSArray* students = [NSArray arrayWithObjects:student1,student2,student3, nil];
  
//  NSEnumerator* enumerator = [students objectEnumerator];
//  id obj;
//  while (obj = [enumerator nextObject]) {
//    TRStudent5* student = obj;
//    NSLog(@"---name:%@ age:%d",student.name,student.age);
//  }
//  
//  enumerator = [students reverseObjectEnumerator];
//  while (obj = [enumerator nextObject]) {
//    TRStudent5* student = obj;
//    NSLog(@"反向---name:%@ age:%d",student.name,student.age);
//  }
  
  NSEnumerator* enumerator = [students reverseObjectEnumerator];
  for (TRStudent6 *student in enumerator) {
    NSLog(@"反向---name:%@ age:%d",student.name,student.age);
  }
  
}

#pragma mark 练习：1学校-2学院-4班级-8学生 遍历所有学生
-(void)test_NSEnumerator
{
  TRStudent6* student1 = [TRStudent6 studentInitWithName:@"a1" AndAge:1];
  TRStudent6* student2 = [TRStudent6 studentInitWithName:@"a2" AndAge:2];
  TRStudent6* student3 = [TRStudent6 studentInitWithName:@"a3" AndAge:3];
  TRStudent6* student4 = [TRStudent6 studentInitWithName:@"a4" AndAge:4];
  TRStudent6* student5 = [TRStudent6 studentInitWithName:@"a5" AndAge:5];
  TRStudent6* student6 = [TRStudent6 studentInitWithName:@"a6" AndAge:6];
  TRStudent6* student7 = [TRStudent6 studentInitWithName:@"a7" AndAge:7];
  TRStudent6* student8 = [TRStudent6 studentInitWithName:@"a8" AndAge:8];
  
  NSMutableArray* class1 = [NSMutableArray arrayWithObjects:student1,student2, nil];
  NSMutableArray* class2 = [NSMutableArray arrayWithObjects:student3,student4, nil];
  NSMutableArray* class3 = [NSMutableArray arrayWithObjects:student5,student6, nil];
  NSMutableArray* class4 = [NSMutableArray arrayWithObjects:student7,student8, nil];
  
  NSMutableArray* college1 = [NSMutableArray arrayWithObjects:class1,class2, nil];
  NSMutableArray* college2 = [NSMutableArray arrayWithObjects:class3,class4, nil];
  
  NSMutableArray* school = [NSMutableArray arrayWithObjects:college1,college2, nil];
  
  
  printf("用快速枚举遍历所有学生信息======================================================\n");
  for (NSMutableArray* tempcollege in school) {
    for (NSMutableArray* tempclass in tempcollege) {
      for (TRStudent6* tempstudent in tempclass) {
        NSLog(@"name:%@,age:%d",tempstudent.name,tempstudent.age);
      }
    }
  }
  
  printf("用迭代器遍历学生信息===========================================================\n");
  
  printf("遍历college1学生信息----------------------\n");
  NSEnumerator* enumratorCollege1 = [college1 objectEnumerator];
  id classID1And2;
  int classNo1And2 = 1;
  while (classID1And2 = [enumratorCollege1 nextObject]) {
    NSLog(@"第%i班的学生信息如下",classNo1And2);
    NSEnumerator* enumratorClass = [classID1And2 objectEnumerator];
    id studentID1And2;
    while (studentID1And2 = [enumratorClass nextObject]) {
      TRStudent6 *tempStudent1And2 = studentID1And2;
      NSLog(@"name:%@,age:%d",tempStudent1And2.name,tempStudent1And2.age);
    }
    classNo1And2++;
  }
  printf("遍历college2学生信息----------------------\n");
  NSEnumerator* enumratorCollege2 = [college1 objectEnumerator];
  id classID3And4;
  int classNo3And4 = 3;
  while (classID3And4 = [enumratorCollege2 nextObject]) {
    NSLog(@"第%i班的学生信息如下",classNo3And4);
    NSEnumerator* enumratorClass = [classID3And4 objectEnumerator];
    id studentID3And4;
    while (studentID3And4 = [enumratorClass nextObject]) {
      TRStudent6 *tempStudent3And4 = studentID3And4;
      NSLog(@"name:%@,age:%d",tempStudent3And4.name,tempStudent3And4.age);
    }
    classNo3And4++;
  }
  
  printf("遍历所有学生信息----------------------\n");
  NSEnumerator* enumratorSchool = [school objectEnumerator];
  id schoolID;
  int collegeNo = 1;
  int classNo = 1;
  while (schoolID = [enumratorSchool nextObject]) {
    NSLog(@"第%d学院的信息如下",collegeNo);
    NSEnumerator* enumratorCollege = [schoolID objectEnumerator];
    id collegeID;
    while (collegeID = [enumratorCollege nextObject]) {
      NSLog(@"第%d班的学生如下",classNo);
      NSEnumerator* enumratorClass = [collegeID objectEnumerator];
      id studentID;
      while (studentID = [enumratorClass nextObject] ) {
        TRStudent6* tempStudent = studentID;
        NSLog(@"name:%@,age:%d",tempStudent.name,tempStudent.age);
      }
      classNo++;
    }
    collegeNo++;
  }
  
}
@end

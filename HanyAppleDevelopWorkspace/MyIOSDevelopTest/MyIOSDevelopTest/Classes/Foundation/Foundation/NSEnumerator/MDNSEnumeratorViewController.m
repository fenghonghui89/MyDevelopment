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
#import "MD_Model3.h"
@interface MDNSEnumeratorViewController ()

@end

@implementation MDNSEnumeratorViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self normal_NSEnumerator];
  
}

#pragma mark 遍历或反向遍历
-(void)normal_NSEnumerator{
  
  TRStudent* student1 = [TRStudent new];
  student1.name = @"张三";
  student1.age = 18;
  TRStudent* student2 = [TRStudent new];
  student2.name = @"李四";
  student2.age = 20;
  TRStudent* student3 = [TRStudent new];
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
  for (TRStudent *student in enumerator) {
    NSLog(@"反向---name:%@ age:%ld",student.name,(long)student.age);
  }
  
}

#pragma mark 练习：1学校-2学院-4班级-8学生 遍历所有学生
-(void)test_NSEnumerator
{
  TRStudent* student1 = [TRStudent studentWithName:@"a1" age:1];
  TRStudent* student2 = [TRStudent studentWithName:@"a2" age:2];
  TRStudent* student3 = [TRStudent studentWithName:@"a3" age:3];
  TRStudent* student4 = [TRStudent studentWithName:@"a4" age:4];
  TRStudent* student5 = [TRStudent studentWithName:@"a5" age:5];
  TRStudent* student6 = [TRStudent studentWithName:@"a6" age:6];
  TRStudent* student7 = [TRStudent studentWithName:@"a7" age:7];
  TRStudent* student8 = [TRStudent studentWithName:@"a8" age:8];
  
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
      for (TRStudent* tempstudent in tempclass) {
        NSLog(@"name:%@,age:%ld",tempstudent.name,(long)tempstudent.age);
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
      TRStudent *tempStudent1And2 = studentID1And2;
      NSLog(@"name:%@,age:%ld",tempStudent1And2.name,(long)tempStudent1And2.age);
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
      TRStudent *tempStudent3And4 = studentID3And4;
      NSLog(@"name:%@,age:%ld",tempStudent3And4.name,(long)tempStudent3And4.age);
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
        TRStudent* tempStudent = studentID;
        NSLog(@"name:%@,age:%ld",tempStudent.name,(long)tempStudent.age);
      }
      classNo++;
    }
    collegeNo++;
  }
  
}
@end

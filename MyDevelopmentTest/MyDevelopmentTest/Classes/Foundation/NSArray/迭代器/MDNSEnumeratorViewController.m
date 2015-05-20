//
//  MDNSEnumeratorViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNSEnumeratorViewController.h"
#import "TRStudent5.h"
@interface MDNSEnumeratorViewController ()

@end

@implementation MDNSEnumeratorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

#pragma mark 常用：迭代器用完一次后不会回到原来的位置
-(void)normal_NSEnumerator
{
    TRStudent5* student1 = [TRStudent5 new];
    student1.name = @"张三";
    student1.age = 18;
    TRStudent5* student2 = [TRStudent5 new];
    student2.name = @"李四";
    student2.age = 20;
    TRStudent5* student3 = [TRStudent5 new];
    student3.name = @"王五";
    student3.age = 30;
    NSArray* students = [NSArray arrayWithObjects:student1,student2,student3, nil];
    
    NSEnumerator* enumerator = [students objectEnumerator];
    id obj;
    int count=0;
    while (obj = [enumerator nextObject]) {
        TRStudent5* student = obj;
        count++;
        NSLog(@"---name:%@ age:%d",student.name,student.age);
        if (count==1) {
            break;
        }
    }
    
    
    //NSEnumerator* enumerator2 = [students objectEnumerator];
    //迭代器用完一次后不会回到原来的位置
    id obj2;
    while (obj2 = [enumerator nextObject]) {//每循环一次下移一位
        TRStudent5* tempstudent = obj2;
        if ([tempstudent.name isEqualToString:@"李四"]) {
            NSLog(@"name:%@ age:%d",tempstudent.name,tempstudent.age);
        }
    }

}

#pragma mark 练习：1学校-2学院-4班级-8学生 遍历所有学生
-(void)test_NSEnumerator
{
    TRStudent5* student1 = [TRStudent5 studentInitWithName:@"a1" AndAge:1];
    TRStudent5* student2 = [TRStudent5 studentInitWithName:@"a2" AndAge:2];
    TRStudent5* student3 = [TRStudent5 studentInitWithName:@"a3" AndAge:3];
    TRStudent5* student4 = [TRStudent5 studentInitWithName:@"a4" AndAge:4];
    TRStudent5* student5 = [TRStudent5 studentInitWithName:@"a5" AndAge:5];
    TRStudent5* student6 = [TRStudent5 studentInitWithName:@"a6" AndAge:6];
    TRStudent5* student7 = [TRStudent5 studentInitWithName:@"a7" AndAge:7];
    TRStudent5* student8 = [TRStudent5 studentInitWithName:@"a8" AndAge:8];
    
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
            for (TRStudent5* tempstudent in tempclass) {
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
            TRStudent5 *tempStudent1And2 = studentID1And2;
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
            TRStudent5 *tempStudent3And4 = studentID3And4;
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
                TRStudent5* tempStudent = studentID;
                NSLog(@"name:%@,age:%d",tempStudent.name,tempStudent.age);
            }
            classNo++;
        }
        collegeNo++;
    }

}
@end

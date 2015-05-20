//
//  MDNSSetNormalViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNSSetNormalViewController.h"
#import "TRPoint.h"
#import "TRXYZ.h"
#import "TRStudent7.h"
@interface MDNSSetNormalViewController ()

@end

@implementation MDNSSetNormalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark NSSet常用
//集合:1.不允许重复 2.无序
//可以存在于集合里面元素：不同类的对象，同类或子类但实例变量值不同的(要注意重写hash和isEqual方法)
//注意：经测试，如果涉及到子类，可能会有问题
-(void)normal_NSSet
{
    TRPoint* point1 = [TRPoint new];
    point1.x = 1;
    point1.y = 2;
    TRPoint* point2 = [TRPoint new];
    point2.x = 3;
    point2.y = 4;
    TRXYZ* xyz1 = [TRXYZ new];
    xyz1.x = 3;
    xyz1.y = 4;
    xyz1.z = 7;
    TRXYZ* xyz2 = [TRXYZ new];
    xyz2.x = 3;
    xyz2.y = 4;
    xyz2.z = 7;
    
    NSLog(@"point1 hash:%ld %@",[point1 hash],point1);
    NSLog(@"point2 hash:%ld %@",[point2 hash],point2);
    NSLog(@"xyz1 hash:%ld %@",[xyz1 hash],xyz1);
    NSLog(@"xyz2 hash:%ld %@",[xyz2 hash],xyz2);
    printf("\n");
    NSSet* set = [NSSet setWithObjects:point1,point2,xyz1,xyz2,nil];
    NSLog(@"%@",set);
}

#pragma mark NSSet练习
-(void)test_NSSet
{
    TRStudent7* student = [TRStudent7 new];
    student.name = @"zhangsan";
    student.age = 12;
    TRStudent7* student2 = [TRStudent7 new];
    student2.name = @"lisi";
    student2.age = 30;
    NSSet* set = [NSSet setWithObjects:student,student2, nil];
    NSLog(@"student hash:%ld",[student hash]);
    NSLog(@"student2 hash:%ld",[student2 hash]);
}

#pragma mark 用NSSet重构练习：1学校-2学院-4班级-8学生 遍历所有学生
-(void)test_NSSet1
{
    
    TRStudent7* student1 = [TRStudent7 studentInitWithName:@"a1" AndAge:1];
    TRStudent7* student2 = [TRStudent7 studentInitWithName:@"a2" AndAge:2];
    TRStudent7* student3 = [TRStudent7 studentInitWithName:@"a3" AndAge:3];
    TRStudent7* student4 = [TRStudent7 studentInitWithName:@"a4" AndAge:4];
    TRStudent7* student5 = [TRStudent7 studentInitWithName:@"a6" AndAge:5];
    TRStudent7* student6 = [TRStudent7 studentInitWithName:@"a6" AndAge:6];
    TRStudent7* student7 = [TRStudent7 studentInitWithName:@"a7" AndAge:8];
    TRStudent7* student8 = [TRStudent7 studentInitWithName:@"a8" AndAge:8];
    
    NSSet* class1 = [NSSet setWithObjects:student1,student2, nil];
    NSSet* class2 = [NSSet setWithObjects:student3,student4, nil];
    NSSet* class3 = [NSSet setWithObjects:student5,student6, nil];
    NSSet* class4 = [NSSet setWithObjects:student7,student8, nil];
    
    NSSet* college1 = [NSSet setWithObjects:class1,class2, nil];
    NSSet* college2 = [NSSet setWithObjects:class3,class4, nil];
    
    NSSet* school = [NSSet setWithObjects:college1,college2, nil];
    
    for (NSSet* tempcollege in school) {
        for (NSSet* tempclass in tempcollege) {
            for (TRStudent7* tempstudent in tempclass) {
                NSLog(@"name:%@,age:%d",tempstudent.name,tempstudent.age);
            }
        }
    }

}
@end

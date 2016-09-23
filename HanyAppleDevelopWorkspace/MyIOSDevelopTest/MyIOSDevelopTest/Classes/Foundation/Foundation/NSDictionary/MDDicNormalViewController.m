//
//  MDDicNormalViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDDicNormalViewController.h"
#import "TRStudent8.h"
@interface MDDicNormalViewController ()

@end

@implementation MDDicNormalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark NSDictionary常用
//注：结构体、double等类型不能放进字典里面，字典里面只能存放对象
-(void)normal_NSDic
{
    NSNumber* num1 = [NSNumber numberWithInt:1];
    NSNumber* num2 = [NSNumber numberWithInt:2];
    NSNumber* num3 = [NSNumber numberWithInt:3];
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:num1,@"one",num2,@"two",num3,@"three", nil];
    
    NSLog(@"dic:%@",dic);
    NSLog(@"dic count:%ld",(unsigned long)[dic count]);
    NSLog(@"value:%@",[dic objectForKey:@"one"]);
    NSLog(@"keys:%@",[dic allKeys]);
    NSLog(@"values:%@",[dic allValues]);
    
    //遍历
    for (id key in dic) {
        NSLog(@"dic:key:%@ --> value:%@",key,[dic objectForKey:key]);
    }
    
    
    
    //可变字典 插入键值
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:num1,@"one",num2,@"two",num3,@"three", nil];
    NSNumber* num4 = [NSNumber numberWithInt:4];
    NSNumber* num5 = [NSNumber numberWithInt:5];
    [dic2 setObject:num4 forKey:@"four"];//注意：Key:id <NSCopying>
    [dic2 setObject:num5 forKey:@"five"];
    
    for (id key in dic2) {
        NSLog(@"dic2:key:%@ --> value:%@",key,[dic2 objectForKey:key]);
    }
    
    NSLog(@"value:%@",dic2[@"four"]);

}

#pragma mark 用NSDictionary重构练习：1学校-2学院-4班级-8学生 遍历所有学生
-(void)test_NSDic
{
    TRStudent8* student1 = [TRStudent8 studentInitWithName:@"a1" AndAge:1];
    TRStudent8* student2 = [TRStudent8 studentInitWithName:@"a2" AndAge:2];
    TRStudent8* student3 = [TRStudent8 studentInitWithName:@"a3" AndAge:3];
    TRStudent8* student4 = [TRStudent8 studentInitWithName:@"a4" AndAge:4];
    TRStudent8* student5 = [TRStudent8 studentInitWithName:@"a6" AndAge:5];
    TRStudent8* student6 = [TRStudent8 studentInitWithName:@"a6" AndAge:6];
    TRStudent8* student7 = [TRStudent8 studentInitWithName:@"a7" AndAge:8];
    TRStudent8* student8 = [TRStudent8 studentInitWithName:@"a8" AndAge:8];
    
    NSArray* class1 = [NSArray arrayWithObjects:student1,student2, nil];
    NSArray* class2 = [NSArray arrayWithObjects:student3,student4, nil];
    NSArray* class3 = [NSArray arrayWithObjects:student5,student6, nil];
    NSArray* class4 = [NSArray arrayWithObjects:student7,student8, nil];
    
    NSMutableDictionary* college1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:class1,@"class1",class2,@"class2", nil];
    NSMutableDictionary* college2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:class3,@"class3",class4,@"class4", nil];
    
    NSMutableDictionary* school = [NSMutableDictionary dictionaryWithObjectsAndKeys:college1,@"college1",college2,@"college2", nil];
    
    for (id collegeKey in school) {
        NSMutableDictionary* collegeValue = [school objectForKey:collegeKey];
        for (NSArray* classKey in collegeValue) {
            NSArray* classValue = [collegeValue objectForKey:classKey];
            for (TRStudent8* student in classValue) {
                NSLog(@"name:%@,age:%d",student.name,student.age);
            }
        }
    }

}

@end

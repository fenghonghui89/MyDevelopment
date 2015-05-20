//
//  MDNArrayAdvancedViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNArrayAdvancedViewController.h"
#import "TRStudent6.h"
#import "TRTelphoneInfo.h"
#import "TRUserInfo.h"
@interface MDNArrayAdvancedViewController ()

@end

@implementation MDNArrayAdvancedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark 数组的深拷贝、浅拷贝
-(void)advanced_NSArrayCopy
{
    TRStudent6* student1 = [TRStudent6 studentInitWithName:@"zhangsan" AndAge:18];
    TRStudent6* student2 = [TRStudent6 studentInitWithName:@"lisi" AndAge:20];
    NSArray* array1 = @[student1,student2];
    NSLog(@"array1:%@,%p",array1,array1[0]);
    
    //数组的浅拷贝
    NSArray* array2 = [[NSArray alloc] initWithArray:array1 copyItems:NO];
    NSLog(@"array2:%@,%p",array2,array2[0]);
    
    //数组的深拷贝-1.每个对象都要遵守NSCopying协议，2.然后重写copyWithZone方法
    NSArray* array3 = [[NSArray alloc] initWithArray:array1 copyItems:YES];
    NSLog(@"array3:%@,%p",array3,array3[0]);
}

#pragma mark 数组的排序
-(void)advanced_NSArraySort
{
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
    TRStudent6* student = [TRStudent6 studentInitWithName:@"zhangsan" AndAge:20];
    TRStudent6* student2 = [TRStudent6 studentInitWithName:@"lisi" AndAge:10];
    TRStudent6* student3 = [TRStudent6 studentInitWithName:@"wangwu" AndAge:30];
    NSArray* array = @[student,student2,student3];
    NSLog(@"array:%@",array);
    
    NSArray* array2 = [array sortedArrayUsingSelector:@selector(compareStudentWithName:)];//根据选择的方法进行排序
    NSLog(@"array2:%@",array2);
}

#pragma mark 数组排序练习：手机通讯录
-(void)test_addressBook
{
    TRUserInfo* user1=[TRUserInfo userInfoWithName:@"Steve Jobs" AndEmail:@"Steve_Jobs@gmail.com" AndTelphone:@"18666776612"];
    TRUserInfo* user2=[TRUserInfo userInfoWithName:@"Johny Ive" AndEmail:@"Johny_Ive@gmail.com" AndTelphone:@"18666776512"];
    TRUserInfo* user3=[TRUserInfo userInfoWithName:@"Steven Hotting" AndEmail:@"Steven_Hotting@gmail.com" AndTelphone:@"13766776321"];
    TRUserInfo* user4=[TRUserInfo userInfoWithName:@"NaNa Lee" AndEmail:@"NaNa_Lee@gmail.com" AndTelphone:@"020-88886488"];
    TRUserInfo* user5=[TRUserInfo userInfoWithName:@"Steven Hotting" AndEmail:@"Steven_Hotting1@gmail.com" AndTelphone:@"13666668884"];
    TRTelphoneInfo*addressBook=[TRTelphoneInfo telpInfoWithUser:user1];
    
    [addressBook addUserInfo:user2];
    [addressBook addUserInfo:user3];
    [addressBook addUserInfo:user4];
    [addressBook addUserInfo:user5];
    [addressBook sort];
    [addressBook removeUserInfo:@"Steven Hotting"];
    [addressBook lookupUserName:@"Johny Ive"];
    [addressBook sort];
    [addressBook TelpInfoList];
}
@end

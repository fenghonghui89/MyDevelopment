//
//  Root_ParamaAndInit.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

#import "Root_ParamaAndInit.h"
#import "Student.h"
#import "Student1.h"
#import "Student2.h"

#import "XYPoint.h"
#import "MDAnimal.h"
#import "MDCat.h"

@implementation Root_ParamaAndInit
-(void)root_ParamaAndInit{
  

}

#pragma mark - ************** method **************
#pragma mark - 实例变量、属性
-(void)student
{
  Student *student = [[Student alloc]init];
  
  //3.属性的声明和实例变量都定义了，才能使用“对象.属性”的方式对实例变量操作
  student.age=18;
  student.sex='m';
  NSLog(@"student age:%d,sex:%c",student.age,student.sex);
}

#pragma mark - 属性的演变
-(void)student1
{
  Student1 *student = [[Student1 alloc]init];
  student.age=18;
  student.sex='m';
  student.name = @"张三";
  [student say];
//  [student release];
  student = nil;
}

#pragma mark - init
-(void)student2
{
  Student2 *student = [[Student2 alloc]initWithAge:18 andSex:'f'];
  NSLog(@"student age:%d, sex:%c",student.age,student.sex);
  
  //id类型:任意指针变量（相当于void*）,可以指向任何对象，无指定类型，所以使用前要转换类型
  id studentid = [[Student2 alloc] initWithAge:18 andSex:'f'];
  Student2 *student2 = studentid;
  NSLog(@"student2 age:%d, sex:%c",student2.age,student2.sex);
}

#pragma mark - 类方法、工厂方法
-(void)xypoint
{
  //用不带初始化的类方法创建对象
  XYPoint* xy = [XYPoint xypoint];
  [xy xpoint:3 ypoint:4];
  [xy show];
  
  //用工厂方法创建对象
  XYPoint* xy1 = [XYPoint xypointWithXpoint:5 yPoint:1];
  [xy1 show];
}

#pragma mark - 实例变量及其修饰符、继承
-(void)animal
{
  //虽然引用->可以访问实例变量,但通常我们使用属性来访问实例变量
  MDAnimal *animal = [[MDAnimal alloc] init];
  //    animal->_i = 1;//默认为protect
  animal->_ipackage = 1;//package
  animal->_ipublic = 1;//public
  //    animal->_iprivate = 1;//private
  //    animal ->_iprotected = 1;//protected
  //    animal->iimplement = 1;//实现部分
  
  MDCat *cat = [[MDCat alloc] init];
  [cat eat];
}

@end

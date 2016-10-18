//
//  MDObject3ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_NSObject_VC.h"
#import "MD_Model.h"
#import "MD_Model2.h"
#import "MD_Model4.h"
#import "MD_Model3.h"

@interface MD_NSObject_VC ()

@end

@implementation MD_NSObject_VC

- (void)viewDidLoad{
  
    [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
}

#pragma mark - < method > -
-(void)test_classObj{

  Class abc = [TRPerson class];//1.创建父类的类对象
  BOOL b = [TRBook isSubclassOfClass:abc];//2.方法得出的是BOOL型变量
  //BOOL b = [TRStudent isSubclassOfClass:[TRPerson class]];//两种方式
  
  if (b) {//3.判断
    NSLog(@"是子类");
  }else{
    NSLog(@"不是子类");
  }
  
  NSLog(@"class address:%p",abc);//类不占用内存空间，但类对象占用内存空间
}

#pragma mark copy
-(void)test_obj{
  
  TRStudent* student = [[TRStudent alloc] init];
  
  student.age = 18;
  student.name = @"张三";
  TRStudent* student2 = [student copy];
  
  NSLog(@"student:%p %@ %d",student,student.name,student.age);
  NSLog(@"student2:%p %@ %d",student2,student2.name,student2.age);
}

#pragma mark 方法选择器
-(void)methodSelector
{
  TRStudent* student = [TRStudent new];
  
  SEL method = @selector(study);//SEL是类型，abc是引用名,相当于一个方法的指针
  NSLog(@"SEL address:%p",method);
  
  BOOL b = [TRStudent instancesRespondToSelector:method];
  //选择方法时要细心，这里用的是ToSelector，有另外一个方法名是ForSelector
  
  if (b) {
    NSLog(@"有这个方法");
    [student performSelector:method];
    //区别：[student study]运行时编译器不会验证，而是直接运行，可能会有风险
  }else{
    NSLog(@"没有这个方法");
  }
}

#pragma mark 协议选择器
-(void)protocolSelector
{
  Protocol* p = @protocol(TRFly);//定义一个协议类型的指引指向协议
  BOOL b1 = [TRSuperman conformsToProtocol:p];
  if (b1) {
    NSLog(@"遵守了协议");
  }else{
    NSLog(@"未遵守协议");
  }
}
@end

//
//  MDObject3ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_NSObject_VC.h"
#import "MD_Model3.h"

@interface MD_NSObject_VC ()

@end

@implementation MD_NSObject_VC

#pragma mark - < overwrite >
#pragma mark * vc lifecycle
- (void)viewDidLoad{
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  [self test_methodSelector];
}

#pragma mark - < method >
#pragma mark description方法 debugDescription方法(用于断点时po xxx输出)
-(void)test_desc{

  TRStudent *student = [[TRStudent alloc] init];
  student.name = @"Hany";
  student.age = 27;
  DRLog(@"student %@",student);
  /*
   未复写：student <TRStudent: 0x17022d400>
   复写后：student Hany 27
   */
}


#pragma mark 类对象 isSubclassOfClass isKindOfClass isMemberOfClass
-(void)test_classObj{
  
  DRLog(@"class address:%p",[TRStudent class]);//类不占用内存空间，但类对象占用内存空间 class address:0x10021db50
  
  //判断是不是某个类的子类
  if ([TRMidStudent isSubclassOfClass:[TRStudent class]]) {
    DRLog(@"isSubclassOfClass yes..");
  }else{
    DRLog(@"isSubclassOfClass no..");
  }//yes
  
  //判断是否是这个类或者这个类的子类的实例:
  if ([[TRMidStudent new] isKindOfClass:[TRStudent class]]) {
    DRLog(@"isKindOfClass yes..");
  }else{
    DRLog(@"isKindOfClass no..");
  }//yes
  
  //判断是否是这个类的实例：
  if ([[TRMidStudent new] isMemberOfClass:[TRStudent class]]) {
    DRLog(@"isMemberOfClass yes..");
  }else{
    DRLog(@"isMemberOfClass no..");
  }//no
}

#pragma mark NSCopying协议
-(void)test_obj{
  
  TRStudent *person = [[TRStudent alloc] init];
  person.name = @"hany";
  person.age = 18;

  TRStudent* person2 = [person copy];
  
  NSLog(@"person:%p %@ %ld",person,person.name,(long)person.age);//person:0x17002de40 hany 18
  NSLog(@"person2:%p %@ %ld",person2,person2.name,(long)person2.age);//person2:0x17002dc00 hany 18
}

#pragma mark 方法选择器 协议选择器
-(void)test_methodSelector{
  

  SEL method = @selector(studentRun);//相当于一个方法的指针
  NSLog(@"SEL address:%p",method);//SEL address:0x1001cfff7
  

  if ([TRStudent instancesRespondToSelector:method]) {
    NSLog(@"instancesRespondToSelector yes..");
    [[TRStudent new] performSelector:method];//区别：[student study]运行时编译器不会验证，而是直接运行，可能会有风险
  }else{
    NSLog(@"instancesRespondToSelector no..");
  }
  
  if ([[TRStudent new] respondsToSelector:method]) {
    NSLog(@"respondsToSelector yes..");
  }else{
    NSLog(@"respondsToSelector no..");
  }
  
  
  Protocol *p = @protocol(TRStudy);//定义一个协议类型的指引指向协议
  if ([TRStudent conformsToProtocol:p]) {
    NSLog(@"conformsToProtocol yes..");
  }else{
    NSLog(@"conformsToProtocol no..");
  }
}

@end

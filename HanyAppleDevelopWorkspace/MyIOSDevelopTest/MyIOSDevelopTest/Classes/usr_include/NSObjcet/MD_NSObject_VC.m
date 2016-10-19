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
  [self test_desc];
}

#pragma mark - < method >
#pragma mark description debugDescription(用于断点时po xxx输出)
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


#pragma mark 类对象
-(void)test_classObj{
  
  Class abc = [TRStudent class];
  BOOL b = [TRMidStudent isSubclassOfClass:abc];
  
  if (b) {
    NSLog(@"是子类");
  }else{
    NSLog(@"不是子类");
  }
  
  NSLog(@"class address:%p",abc);//类不占用内存空间，但类对象占用内存空间 class address:0x10021db50
}

#pragma mark copy
-(void)test_obj{
  
  TRStudent *person = [[TRStudent alloc] init];
  person.name = @"hany";
  person.age = 18;

  TRStudent* person2 = [person copy];
  
  NSLog(@"person:%p %@ %ld",person,person.name,(long)person.age);//person:0x17002de40 hany 18
  NSLog(@"person2:%p %@ %ld",person2,person2.name,(long)person2.age);//person2:0x17002dc00 hany 18
}

#pragma mark 方法选择器
-(void)test_methodSelector{
  
  TRStudent *person = [TRStudent new];
  
  SEL method = @selector(studentRun);//相当于一个方法的指针
  NSLog(@"SEL address:%p",method);//SEL address:0x1001cfff7
  
  //选择方法时要细心，这里用的是ToSelector，有另外一个方法名是ForSelector
  BOOL b = [TRStudent instancesRespondToSelector:method];
  if (b) {
    NSLog(@"有这个方法");
    [person performSelector:method];
    //区别：[student study]运行时编译器不会验证，而是直接运行，可能会有风险
  }else{
    NSLog(@"没有这个方法");
  }
}

#pragma mark 协议选择器
-(void)test_protocolSelector{
  
  Protocol *p = @protocol(TRStudy);//定义一个协议类型的指引指向协议
  BOOL b1 = [TRStudent conformsToProtocol:p];
  if (b1) {
    NSLog(@"遵守了协议");
  }else{
    NSLog(@"未遵守协议");
  }
}
@end

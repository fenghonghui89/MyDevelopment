//
//  MD_Runtime_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
/*
 initialize不是init
 运行时间的行为之一就是initialize。虽然看起来有点像大家常见的init，但是他们并不相同。
 在程序运行过程中，它会在你程序中每个类调用一次initialize。这个调用的时间发生在你的类接收到消息之前，但是在它的超类接收到initialize之后。
 */
#import "MD_Runtime_VC.h"
#import <objc/runtime.h>
#import "TRXYZ.h"
#import "TRPoint.h"
#import "DGCListInfo.h"
@interface MD_Runtime_VC ()

@end
@implementation MD_Runtime_VC

#pragma mark - ************** override **************
-(void)viewDidLoad{

  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [self test_2];
}

#pragma mark - ************** method **************
-(void)test_initialize{
  
  TRPoint *p = [TRPoint new];
  TRPoint *p1 = [TRPoint new];
  
  TRXYZ *xyz = [TRXYZ new];

}

//遍历一个类的全部成员变量
-(void)test_1{

  unsigned int count = 0;
  
  //Ivar:表示成员变量类型
  Ivar *ivars = class_copyIvarList([DGCListInfo class], &count);//获得一个指向该类所有成员变量的指针
  for (int i =0; i < count; i ++) {
    
    Ivar ivar = ivars[i];
    const char *name = ivar_getName(ivar);//根据ivar获得其成员变量的名称--->C语言的字符串
    NSString *key = [NSString stringWithUTF8String:name];
    NSLog(@"%d----%@",i,key);
  }
}


//遍历一个类的全部属性
-(void)test_2{

  unsigned int count = 0;
  
  objc_property_t *properties = class_copyPropertyList([DGCListInfo class], &count);//获得一个指向该类所有属性的指针
  
  for (int i = 0; i<count; i++) {
    objc_property_t property = properties[i];
    const char *name = property_getName(property);//根据objc_property_t获得其属性的名称--->C语言的字符串
    NSString *key = [NSString stringWithUTF8String:name];
    NSLog(@"%d----%@",i,key);

  }
}
@end

//
//  Protocol_base.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

#import "Protocol_base.h"
#import "TRMyclass.h"
#import "TRProtocol.h"
#import "TRProtocol2.h"
#import "TRProtocol3.h"
@implementation Protocol_base

-(void)root_Protocol_base{

  [self kl_0];
}

-(void)kl_0{
  
  TRMyClass* myClass = [[TRMyClass alloc]init];
  id<TRProtocol2,TRProtocol3> p = myClass;
  [p method1];
  [p method2];
  [p method3];
  [p method5];
  [p method6];
  //[p method4];//只能发送协议要求的方法
  
  //判断对象是否遵守协议
  BOOL b = [p conformsToProtocol:@protocol(TRProtocol)];
  if(b == YES){
    NSLog(@"遵守了协议");
  }
}

@end

//
//  MD_NSInvocation_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/13.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//多参数 多返回值 sel

#import "MD_NSInvocation_VC.h"

@interface MD_NSInvocation_VC ()

@end

@implementation MD_NSInvocation_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [self test_returnValue];
}

#pragma mark - < method > -

#pragma mark - 单参数
-(void)test_singleParama{
  
  SEL myMethod = @selector(myLog);
  
  //创建一个函数签名，这个签名可以是任意的,但需要注意，签名函数的参数数量要和调用的一致。
  NSMethodSignature *sig = [NSNumber instanceMethodSignatureForSelector:@selector(init)];
  
  //通过签名初始化
  NSInvocation *invocatin = [NSInvocation invocationWithMethodSignature:sig];
  [invocatin setTarget:self];
  [invocatin setSelector:myMethod];
  
  //消息调用
  [invocatin invoke];
  
}

-(void)myLog{
  NSLog(@"MyLog");
}

#pragma mark - 多参数
-(void)test_mulitParama{

  SEL myMethod = @selector(myLog1:parm:parm:);
  NSMethodSignature * sig  = [[self class] instanceMethodSignatureForSelector:myMethod];
  
  NSInvocation * invocatin = [NSInvocation invocationWithMethodSignature:sig];
  
  [invocatin setTarget:self];//与下面两句等价
//  MD_NSInvocation_VC * view = self;
//  [invocatin setArgument:&view atIndex:0];
  
  [invocatin setSelector:myMethod];//与下面等价
//  [invocatin setArgument:&myMethod atIndex:1];
  
  int a=1;
  int b=2;
  int c=3;
  [invocatin setArgument:&a atIndex:2];
  [invocatin setArgument:&b atIndex:3];
  [invocatin setArgument:&c atIndex:4];
  [invocatin invoke];
}

-(void)myLog1:(int)a parm:(int)b parm:(int)c{
  NSLog(@"MyLog%d:%d:%d",a,b,c);
}

#pragma mark - 返回值
-(void)test_returnValue{

  SEL myMethod = @selector(myLog2:parm:parm:);
  NSMethodSignature * sig  = [[self class] instanceMethodSignatureForSelector:myMethod];
  
  NSInvocation * invocatin = [NSInvocation invocationWithMethodSignature:sig];
  [invocatin setTarget:self];
  [invocatin setSelector:myMethod];
  int a=1;
  int b=2;
  int c=3;
  [invocatin setArgument:&a atIndex:2];
  [invocatin setArgument:&b atIndex:3];
  [invocatin setArgument:&c atIndex:4];
  [invocatin retainArguments];
  
  //我们将c的值设置为返回值
  [invocatin setReturnValue:&c];
  int d;
  //取这个返回值
  [invocatin getReturnValue:&d];
  NSLog(@"%d",d);
  
}

-(int)myLog2:(int)a parm:(int)b parm:(int)c{
  NSLog(@"MyLog%d:%d:%d",a,b,c);
  return a+b+c;
}
@end

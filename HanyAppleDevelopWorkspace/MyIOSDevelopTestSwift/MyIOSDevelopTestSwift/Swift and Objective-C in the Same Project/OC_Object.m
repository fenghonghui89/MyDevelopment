//
//  OC_Object.m
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 MD. All rights reserved.
//

/*
 oc调用swift方法，要手动import "Product Module Name-swift.h"头文件
 有时候可能无法识别swift，要多编译几次
 */
#import "OC_Object.h"
//#import "MyDevelopmentSwift-swift.h"
@interface OC_Object ()

@end
@implementation OC_Object



#pragma mark - ************** override ****************

-(instancetype)init{
  
  if (self = [super init]) {
    
  }
  return self;
}

#pragma mark - ************** method ****************

//允许swift调用
-(void)sayHello{
  
  NSLog(@"oc say hello");
}

//swift不能用 哪怕有公开
-(void)swiftCannotUse NS_SWIFT_UNAVAILABLE("swift cannot use"){
  
}

//调用swift方法
-(void)translateToSwift{
  
//  ViewController_Swift *vc = [ViewController_Swift new];
//  [vc sayHello];
}
#pragma mark - ************** action ****************
#pragma mark - ************** callback ****************





@end

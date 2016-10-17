//
//  NSMutableArray+Extension.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/17.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
/*
 runtime应用 - 防止数组添加nil后崩溃
 */


#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>
#import "MDRootDefine.h"

@implementation NSMutableArray (Extension)

#define flag 1

#if flag == 1
+(void)load{
  
  DRLog(@"load NSMutableArray+Extension..");
  
  /*
   __NSArrayM是NSMutableArray的真正类型
   */
  Method orginalMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
  Method newMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(gp_addObject:));
  method_exchangeImplementations(orginalMethod, newMethod);
}
#elif flag == 2

#else

#endif





-(void)gp_addObject:(id)object{

  if(object != nil){
    [self gp_addObject:object];
  }
}
@end

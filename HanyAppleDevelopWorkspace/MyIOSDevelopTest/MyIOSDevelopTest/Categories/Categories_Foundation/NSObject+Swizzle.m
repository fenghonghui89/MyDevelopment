//
//  NSObject+Swizzle.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/23.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
@implementation NSObject (Swizzle)
+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)aftSel {
  
  Method originMethod = class_getInstanceMethod(self, origSel);
  Method newMethod = class_getInstanceMethod(self, aftSel);
  
  if(originMethod && newMethod)
  {
    BOOL canAdd = class_addMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if(canAdd) {
      NSLog(@"can add 哈哈!!!");
      class_replaceMethod(self, aftSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
      NSLog(@"can not add哈哈 !!!");
    }
    return YES;
  }
  else
  {
    NSLog(@"nil..哈哈..!!!!");
    return NO;
  }
}
@end

//
//  MyString.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/23.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MyString.h"
#import <objc/runtime.h>
#import "NSObject+Swizzle.h"
@implementation MyString
+ (BOOL)swizzleMethodself:(SEL)origSel withMethod:(SEL)aftSel {
  
  Method originMethod = class_getInstanceMethod(self, origSel);
  Method newMethod = class_getInstanceMethod(self, aftSel);
  
  if(originMethod && newMethod)
  {
    BOOL canAdd = class_addMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if(canAdd) {
      NSLog(@"can add !!!");
      class_replaceMethod(self, aftSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
      NSLog(@"can not add !!!");
    }
    return YES;
  }
  else
  {
    NSLog(@"nil....!!!!");
    return NO;
  }
}

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    Class clazz = object_getClass((id)self);
    NSLog(@"=====%@ %@ %@",[self class],clazz,self);
    
    [clazz swizzleMethod:@selector(resolveInstanceMethod:) withMethod:@selector(myResolveInstanceMethod:)];
    
//    [self swizzleMethodself:@selector(resolveInstanceMethod:) withMethod:@selector(myResolveInstanceMethod:)];
  });
}

+ (BOOL)myResolveInstanceMethod:(SEL)sel {
  
  if(! [self myResolveInstanceMethod:sel]) {
    NSString *selString = NSStringFromSelector(sel);
    if([selString isEqualToString:@"countAll"] || [selString isEqualToString:@"pushViewController"]) {
      class_addMethod(self, sel, class_getMethodImplementation(self, @selector(dynamicMethodIMP)), "v@:");
      return YES;
    }else {
      return NO;
    }
  }
  return YES;
}

- (void)dynamicMethodIMP {
  NSLog(@"我是动态加入的函数");
}
@end

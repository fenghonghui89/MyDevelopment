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
  SEL orignalSel = @selector(addObject:);
  SEL swizzledSel = @selector(md_addObject:);
  Class thClass = NSClassFromString(@"__NSArrayM");
  
  Method orignalMethod = class_getInstanceMethod(thClass, orignalSel);
  Method swizzledMethod = class_getInstanceMethod(thClass, swizzledSel);
  
  BOOL canAdd = class_addMethod(thClass,
                                orignalSel,
                                method_getImplementation(swizzledMethod),
                                method_getTypeEncoding(swizzledMethod));
  if (canAdd) {
    NSLog(@"can add..");
    class_replaceMethod(thClass,
                        swizzledSel,
                        method_getImplementation(orignalMethod),
                        method_getTypeEncoding(orignalMethod));
  }else{
    NSLog(@"can not add..");
    method_exchangeImplementations(orignalMethod, swizzledMethod);
  }
  
}
#elif flag == 2

#else

#endif





-(void)md_addObject:(id)object{

  if(object != nil){
    [self md_addObject:object];
  }
}
@end

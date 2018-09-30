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
    IMP orignalIMP = method_getImplementation(orignalMethod);
    const char *originalType = method_getTypeEncoding(orignalMethod);
    
    Method swizzledMethod = class_getInstanceMethod(thClass, swizzledSel);
    IMP swizzledIMP = method_getImplementation(swizzledMethod);
    const char *swizzledType = method_getTypeEncoding(swizzledMethod);
    
    BOOL canAdd = class_addMethod(thClass,
                                  orignalSel,
                                  swizzledIMP,
                                  swizzledType);
    
    if (canAdd) {//如果方法没有存在,我们则先尝试添加被替换的方法的实现
        NSLog(@"can add..");
        
        /*
         class_replaceMethod本身会尝试调用class_addMethod和method_setImplementation，所以直接调用class_replaceMethod就可以了
         参数：要操作的class 要操作的方法sel 新的实现 新的typeencoding
         */
        class_replaceMethod(thClass,
                            swizzledSel,
                            orignalIMP,
                            originalType);
        class_replaceMethod(thClass,
                            orignalSel,
                            swizzledIMP,
                            swizzledType);
    }else{//如果发现方法已经存在，class_addMethod会失败返回
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

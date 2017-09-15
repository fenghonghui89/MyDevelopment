//
//  XTJSuperClass.m
//  XTJMall
//
//  Created by hanyfeng on 2017/9/15.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "XTJSuperClass.h"
#import "YYModel.h"
@interface XTJSuperClass ()
<
NSCopying
>
@end
@implementation XTJSuperClass

-(id)copyWithZone:(NSZone *)zone{
    
    NSLog(@"baba..");

//    XTJSuperClass *baba = [[XTJSuperClass allocWithZone:zone] init];
//    baba.son = [self.son copy];
//    baba.daugs = [[NSArray alloc] initWithArray:_daugs copyItems:YES];
//    return baba;
    
    XTJSuperClass *baba = [self yy_modelCopy];
    baba.son = [self.son copy];
    baba.daugs = [[NSArray alloc] initWithArray:_daugs copyItems:YES];
    return baba;
}

//-(id)mutableCopyWithZone:(NSZone *)zone{
//
//    return [self yy_modelCopy];
//}
@end

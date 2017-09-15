//
//  XTJSonClass.m
//  XTJMall
//
//  Created by hanyfeng on 2017/9/15.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "XTJSonClass.h"
#import "YYModel.h"
@interface XTJSonClass ()
<
NSCopying
>
@end
@implementation XTJSonClass
-(id)copyWithZone:(NSZone *)zone{
    
    NSLog(@"son..");
    
//    XTJSonClass *son = [[XTJSonClass allocWithZone:zone] init];
//    son.name = [self.name copy];
//    return son;
    
    return [self yy_modelCopy];
}
@end

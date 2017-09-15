//
//  XTJDaugrtClass.m
//  XTJMall
//
//  Created by hanyfeng on 2017/9/15.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "XTJDaugrtClass.h"
#import "YYModel.h"
@interface XTJDaugrtClass()
<NSCopying>
@end
@implementation XTJDaugrtClass
-(id)copyWithZone:(NSZone *)zone{

    NSLog(@"dau..");
    
//    XTJDaugrtClass *dau = [[XTJDaugrtClass allocWithZone:zone] init];
//    dau.name = [self.name copy];
//    return dau;
    
    return [self yy_modelCopy];
}
@end

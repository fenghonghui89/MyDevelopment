//
//  NSObject+Swizzle.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/23.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)
+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)aftSel;
@end

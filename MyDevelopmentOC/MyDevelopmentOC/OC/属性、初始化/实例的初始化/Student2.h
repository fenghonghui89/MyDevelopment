//
//  Student2.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/21.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student2 : NSObject
@property int age;
@property char sex;

-(id)init;//无参数属性初始化
-(id)initWithAge:(int)age andSex:(char)sex;//带参数的属性初始化
@end

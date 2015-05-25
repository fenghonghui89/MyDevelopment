//
//  Student2.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/21.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "Student2.h"

@implementation Student2


//init为无参数的属性初始化
-(id)init
{
//    self = [super init];//ARC模式下
    [super init];//MRC模式下，ARC模式下会报错
    if (self = [super init]) {
    }
    return self;
    
}

//initWith为有参数的属性初始化
-(id)initWithAge:(int)age andSex:(char)sex;
{
    //[super init] 首先执行父类的初始化方法
    //将初始化后的结果赋值给当前对象的引用
    //如果初始化成功 失败为nil(OC)==NULL(C)
    //将参数值赋值给当前对象的实例变量
    //将当前引用返回
    [super init];
    if (self = [super init]) {
        self.age = age;
        self.sex = sex;
    }
    return self;
}
@end

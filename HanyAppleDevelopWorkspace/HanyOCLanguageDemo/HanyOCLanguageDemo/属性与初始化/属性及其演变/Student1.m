//
//  Student1.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/21.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "Student1.h"

@implementation Student1
//从IOS 6.0开始，可以不用写合成语句

//如果声明了实例变量就要用如下写法（匹配ios4）
//@synthesize age = _age, sex = _sex, str = _str;

//如果没有声明实例变量就用如下写法（匹配ios5）
@synthesize age, sex, name;


-(void)say
{
    NSLog(@"我的资料：%d %c %@",age,sex,name);
}

-(void)dealloc
{
    [name release];
    name = nil;
    [super dealloc];
}
@end

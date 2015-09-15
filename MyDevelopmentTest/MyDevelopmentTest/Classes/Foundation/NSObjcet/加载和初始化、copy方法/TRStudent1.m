//
//  TRStudent.m
//  my01
//
//  Created by apple on 13-10-25.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRStudent1.h"

@implementation TRStudent1

+(void)load
{
    NSLog(@"class load ?");//类默认方法：程序加载
}

+(void)initialize
{
    NSLog(@"class init");//类默认方法：程序第一次运行并初始化
}

-(id)copyWithZone:(NSZone *)zone//2.重写协议所要求的方法

{
    __autoreleasing TRStudent1*student = [[TRStudent1 alloc]InitWithAge:self.age andName:self.name];
    return student;
}

-(id)InitWithAge:(int)age andName:(NSString*)name
{
    if (self == [super init]) {
        self.age = age;
        self.name = name;
    }
    return self;
}
@end

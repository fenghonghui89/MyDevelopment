//
//  Student.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/21.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "Student.h"

@implementation Student

-(void)setAge:(int) age1
{
    _age=age1;//C++习惯实例变量前面加_用来和方法形参区分
    
}

-(void)setSex:(char) sex1
{
    _sex=sex1;
}

-(int)age
{
    return _age;
}

-(char)sex
{
    return _sex;
}

-(void)setAge:(int) age Sex:(char) sex
{
    _age = age;
    _sex = sex;
}
@end

//
//  Student.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/21.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject


//1.使用属性前必须先定义实例变量
{
    int _age;
    char _sex;
}

//2.属性的本质是方法setter加getter,但注意setter和getter方法的声明不一样
-(void)setAge:(int) age1;
-(int)age;//getter方法的名称不是getAge
-(void)setSex:(char) sex1;
-(char)sex;
-(void)setAge:(int) age Sex:(char) sex;//一个方法带两个参数的推荐声明方式
@end

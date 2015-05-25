//
//  MD_C_Const_CFile.c
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/13.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#include "MD_C_Const_CFile.h"
void cConstTest0();


void cConstTest()
{
    cConstTest0();
}

void cConstTest0()
{
    const int i = 20;
    int const is = 20;
    //    i = 30;//被修饰的变量不能修改
    //    is = 30;//被修饰的变量不能修改
    
    //指向的内容不能改，在初始化之后可以再指向别的内存
    int i2 = 20;
    int i2s = 20;
    const int *p = &i2;
    //    *p = 30;
    p = &i2s;
    
    //指向的内容可以改，在初始化之后不能再指向别的内存
    int i3 = 20;
    int i3s = 30;
    int* const pp = &i3;
    //    pp = &i3s;
    *pp = i3s;
}



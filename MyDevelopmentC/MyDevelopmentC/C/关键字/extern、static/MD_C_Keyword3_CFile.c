//
//  MD_C_Keyword3_CFile.c
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/13.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#include "MD_C_Keyword3_CFile.h"


int i=5;//全局变量
//auto int ii=5;//全局变量不能用auto
//static int iii=5;//全局变量能用static，生命周期要看文件情况



void cKeyword3Test()
{
    auto int i=4;//auto（默认），不累加计数，生命周期为每次函数运行期间，每次运行完就会释放内存空间
    static int j=5;//static，累加计数，生命周期为程序运行期间，每次运行完会保留内存空间和值
    i++;
    j++;
    printf("f:%d\n",i);
    printf("f:%d\n",j);
}
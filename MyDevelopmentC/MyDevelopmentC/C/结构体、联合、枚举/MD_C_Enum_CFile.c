//
//  MD_C_Enum_CFile.c
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/7.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#include "MD_C_Enum_CFile.h"

void cEnumTest0();
void cEnumTest1();
void cEnumTest()
{
    cEnumTest0();
}

#pragma mark - 枚举
void cEnumTest0()
{
    //TODO:定义一个枚举
    enum{
        SPR,
        SUM,
        AUT,
        WIN
    }num = SPR;
    printf("num:%d\n",num);
    printf("SPR:%d\n",SPR);
    printf("SUM:%d\n",SUM);
    printf("AUT:%d\n",AUT);
    printf("WIN:%d\n",WIN);
    
    
    
    
    
    
    
    //TODO:定义枚举类型、起别名
    //定义枚举类型
    enum SEASON{
        SPR1,
        SUM1,
        AUT1,
        WIN1
    };
    
    //根据枚举类型创建一个枚举
    enum SEASON season;
    season = 5;
    printf("season:%d\n",season);
    printf("SPR1:%d\n",SPR1);
    printf("SUM1:%d\n",SUM1);
    printf("AUT1:%d\n",AUT1);
    printf("WIN1:%d\n",WIN1);
    
    //给枚举类型起别名
    typedef enum SEASON Season;
    Season season1 = 6;
    printf("season1:%d\n",season1);
}



#pragma mark - 结合上面的内容，定义枚举放在函数的外面
typedef enum {
    SPR,
    SUM,
    AUT,
    WIN
}Season1;

void cEnumTest1()
{
    Season1 season = SPR;
    printf("season1:%d\n",season);
}
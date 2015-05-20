//
//  MD_C_Keywork_CFile.c
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/13.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#include "MD_C_Keyword_CFile.h"
#include "MD_C_Keyword3_CFile.h"
void cKeywordTest0();
void cKeywordTest1();


void cKeywordTest()
{
    cKeywordTest0();
}


#pragma mark - extern、static

//extern关键字
/*
 如果想在同一个项目中共享全局变量，在使用文件中，要使用extern关键字声明全局变量才可使用，并且可以得到全局变量的值
 */
#include "MD_C_Keyword1_CFile.h"
extern char *name_Keyword;



//static关键字
/*
 被修饰的关键字只能该文件使用
 */
static double money_Keyword = 100.1;

void cKeywordTest0()
{
    printf("age:%d\n",age_Keyword);
    printf("name:%s\n",name_Keyword);
    printf("money:%f\n",money_Keyword);
}

#pragma mark - auto与static
void cKeywordTest1()
{
    cKeyword3Test();
}


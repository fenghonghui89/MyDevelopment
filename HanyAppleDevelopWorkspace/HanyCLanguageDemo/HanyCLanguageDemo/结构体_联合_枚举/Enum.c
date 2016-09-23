//
//  Enum.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//枚举

#include "Enum.h"
#include <stdio.h>


#pragma mark - ********** knowledge **************

#pragma mark 定义
static void knowledge_init(){

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
}

#pragma mark 枚举类型 起别名
static void knowledge_other(){
  
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



#pragma mark 定义枚举放在函数的外面
typedef enum {
  SPR,
  SUM,
  AUT,
  WIN
}Season1;

static void knowledge_initOut(){
  Season1 season = SPR;
  printf("season1:%d\n",season);
}

#pragma mark - *********** root ***********

void root_Enum(){
  
}
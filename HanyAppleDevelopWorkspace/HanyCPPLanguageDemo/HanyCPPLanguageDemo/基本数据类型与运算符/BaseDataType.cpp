//
//  BaseDataType.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//基本数据类型

#include "BaseDataType.hpp"
#include <iostream>
#include <stdio.h>
using namespace std;

#pragma mark - *********** knowledge ***********
#pragma mark bool
/*
 可以赋任何值 但是下面的四个表达假
 0 false NULL '\0'
 */
static void knowledge_bool(){

  bool flag;
  flag = false;
  flag = "abc";
  cout<<flag<<endl;
}
#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_BaseDataType(){

  knowledge_bool();
}
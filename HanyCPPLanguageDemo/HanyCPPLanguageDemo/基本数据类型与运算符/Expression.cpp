//
//  Expression.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//运算符与表达式

#include "Expression.hpp"
#include <stdio.h>
#include <iostream>
using namespace std;

#pragma mark - *********** knowledge ***********
#pragma mark 运算符替换(了解)
/*
 <%    {
 %>    }
 %:    #
 and   &&
 or    ||
 */
static void knowledge_change(){

  bool a,b;

  if(a or b){
    cout<<"flag is true"<<endl;
  }
}

#pragma mark 运算符重载
static void knowledge_overload(){


}
#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Expression(){
  
}
//
//  CPPBase.cpp
//  MyDevelopmentCPP
//
//  Created by 冯鸿辉 on 16/6/21.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "CPPBase.hpp"

void test_overload();
void test_string();

#pragma mark - ************ method **************
void test_root_base(){

  test_overload();
}

#pragma mark 字符串?
void test_string(){

  char *str = new char(20);
  char *p = "str";
}

#pragma mark 引用?
void test_yinyong(){

  int a = 10;
  int &b = a;
}

#pragma mark c++中的bool类型 运算符重载
%:include <iostream>

using namespace std;
  
void test_overload()<%

  bool flag;
  flag = false;
  flag = "abc";

  if(flag){
    cout<<"flag is true "<<flag<<endl;
    %>
}

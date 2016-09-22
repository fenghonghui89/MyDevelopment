//
//  Typecaset_base.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//类型转换 base

#include "Typecaset_base.hpp"
#include <stdio.h>
#include <iostream>
using namespace std;

#pragma mark - *********** knowledge ***********
#pragma mark static_cast 适合在某一个方向上可以进行自动类型转换的转换
static void knowledge_static_cast(){

  int i = 100.1;
  int b = static_cast<int>(i);
  cout<<b<<endl;//100
}

#pragma mark const_cast 去掉const修饰的转换
static void knowledge_const_cast(){
  
  
  //const修饰的变量无法通过指针修改
  const int i = 77;
  int* pi = (int*)&i;
  *pi = 7777;
  cout<<"i:"<<i<<endl;
  cout<<"*pi:"<<*pi<<endl;
  
  //只用const_cast也无法修改
  const int j = 88;
  int* pj = const_cast<int*>(&j);
  *pj = 8888;
  cout<<"j:"<<j<<endl;
  cout<<"*pj:"<<*pj<<endl;
  
  //const修饰的标量 可能会表现的值和内存中的值不一致 要做到一致可以使用volatile修饰
  volatile const int k = 99;
  int* pk = const_cast<int*>(&k);
  *pk = 9999;
  cout<<"k:"<<k<<endl;
  cout<<"*pk:"<<*pk<<endl;

}
#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Typecast_base(){
  knowledge_const_cast();
}
//
//  Function_base.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//函数 base

#include "Function_base.hpp"
#include <iostream>
#include <stdio.h>
using namespace std;

#pragma mark - *********** knowledge ***********
#pragma mark c++中的函数重载

static int add(int x,int y){
  
  cout<<"add(int,int )"<<endl;
  return  x+y;
}

static double add(int x,double y){
  
  cout<<"add(int,double )"<<endl;
  return  x+y;
}

//跨编译器调用:告诉g++编译器 按照c语言生成调用函数的方式 产生函数调用名
extern "C" double add(double x,double y){
  
  cout<<"add(double,double )"<<endl;
  return  x+y;
}

static void knowledge_overload(){
  
  cout<<add(1,9526)<<endl;
  cout<<add(9526,2.0)<< endl;
  cout<<add(1.0,2.0)<<endl;
}


#pragma mark 参数的默认值
static int add(int x = 1,int y = 2,int z = 3){
  
  return  x+y+z;
}

static void knowledge_defuleParama(){
  
  cout<<add(1,2,3)<<endl;//6
  cout<<add()<<endl;//6
  cout<<add(100)<<endl;//105
}

#pragma mark 哑元
/*
 只有参数的类型 没有参数的名字
 作用:函数向前兼容
 */
void  decode(int key);
void  decode();
void  decode(int);//兼容

#pragma mark 内联函数 inline
/*
 内联函数 在调用的地方会像宏一样展开 减少调用函数的开销以提高效率
 但是inline只是一种请求 请求成功
 就会把代码粘贴过去，请求不成功 就会像普通函数一样调用。
 
 函数比较大 调用不频繁不适合内联
 递归函数 不适合内联
 函数比较小 调用频繁  适合内联
 */
#define  MAX(x,y)  (((x)>(y))?(x):(y))//宏不关心类型 有风险 c++不提倡使用宏
static inline int getMax(int x,int y){
  return x>y?x:y;
}

static void knowledge_inline(){
  
  int max = MAX(10, 20);
  
  max = getMax(20, 30);
  
}

#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Function_base(){

}
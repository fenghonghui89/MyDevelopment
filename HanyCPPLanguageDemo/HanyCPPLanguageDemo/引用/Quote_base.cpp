//
//  Quote_base.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//引用base

#include "Quote_base.hpp"

#include <stdio.h>
#include <iostream>
using namespace std;

#pragma mark - *********** knowledge ***********
#pragma mark 引用修饰变量 修饰常量
static void knowledge_base(){
  
  //引用修饰变量
  int a = 10;
  int &b = a;
  cout<<b<<endl;
  
  b = 20;
  cout<<a<<endl;
  
  int &c = b;
  c = 30;
  cout<<a<<endl;
  
  int x = c;
  cout<<x<<endl;
  
  //引用修饰常量要加const const放哪里都可以
  const int &d = 100;
  cout<<d<<endl;
}

#pragma mark 引用做函数的参数
static void myswap(int x,int y){

  int temp = x;
  x = y;
  y = temp;
}

static void pswap(int *x,int *y){
  
  int temp = *x;
  *x = *y;
  *y = temp;
}

static void qswap(int &a,int &b){
  
  //一般写法
//  int temp=a;
//  a = b;
//  b = temp;
  
  //整数交换中效率最高的写法
  a = a^b;
  b = a^b;
  a = a^b;
}

static void printInt(const int& val){//引用类型形参必须加const才能传常数
  cout<<"printInt:"<<val<<endl;
}

static void knowledge_funcPamara(){
  
  int x = 100;
  int y = 99;
  
//  myswap(x, y);//值传递（复制），操作的是副本，不会影响原来的值
//  pswap(&x,&y);//指针为参数
  qswap(x,y);//引用为参数
  cout<<"x="<<x<<","<<"y="<<y<<endl;
  
  printInt(x);
  printInt(100);//引用类型形参必须加const才能传常数
  
}

#pragma mark 引用做返回值

static int& getMaxRef(int& x,int& y){
  return x>y?x:y;
}

//如果返回值是引用类型，返回的是一个局部变量，没有static则警告，因为函数调用完，栈中的局部变量就会释放
static int& getInt(){
  static int data = 1001;
  return data;
}

static void knowledge_return(){
  
  int x = 100;
  int y = 20;
  cout<<"max:"<<getMaxRef(x,y)<<endl;

  cout<<"getInt():"<<getInt()<<endl;
  
  int z = getInt() = 200;
  cout<<"z:"<<z<<endl;
  cout<<"getInt():"<<getInt()<<endl;
}

#pragma mark - *********** test ***********
#pragma mark - *********** root ***********

void root_Quote_base(){
  knowledge_return();
}
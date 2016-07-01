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

extern "C" double add(double x,double y){
  
  cout<<"add(double,double )"<<endl;
  return  x+y;
}

static void knowledge_overload(){
  
  int x = 1;
  int y = 9526;
  double z = 2.0;
  
  cout<< add(x,y) <<endl;
  cout<< add(y,z) << endl;
  cout<< add(1.0,2.0)<<endl;
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


#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Function_base(){

}
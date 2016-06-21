//
//  CPPFunction.cpp
//  MyDevelopmentCPP
//
//  Created by 冯鸿辉 on 16/6/21.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "CPPFunction.hpp"

#include <iostream>
using namespace std;

#pragma mark c++中的函数重载

/* __Z3addii  _add （汇编代码）*/
int add(int x,int y){
  cout<<"add(int,int )"<<endl;
  return  x+y;
}

/*  __Z3addid */
double add(int x,double y){
  cout<<"add(int,double )"<<endl;
  return  x+y;
}

extern "C" double add(double x,double y){
  cout<<"add(double,double )"<<endl;
  return  x+y;
}

void test_func(){

  int x = 1;
  int y = 9526;
  double z = 2.0;
  
  cout<< add(x,y) <<endl;
  cout<< add(y,z) << endl;
  cout<< add(1.0,2.0)<<endl;
}


#pragma mark 参数的默认值、哑元
int add(int x = 1,int y = 2,int z = 3){
  return  x+y+z;
}

void test_defuleParama(){

  cout<<add(1,2,3)<<endl;//6
  cout<<add()<<endl;//6
  cout<<add(100)<<endl;//105
}
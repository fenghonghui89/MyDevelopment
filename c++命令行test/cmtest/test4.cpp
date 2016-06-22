//
//  test4.cpp
//  cmtest
//
//  Created by 冯鸿辉 on 16/6/22.
//  Copyright © 2016年 MD. All rights reserved.
/*
 本程序按以下公式计算e的值，精度为1e-6。
 e = 1 + 1/1! + 1/2! + ... + 1/n! + ...
 */

#include "test4.hpp"
#include <iostream>
using namespace std;

void calculate();

void test4_root(){
  calculate();
}

void calculate(){
  
  double e,t,n;
  e = 0;
  t = n = 1.0;
  
  while(t>=1e-6){
    e+=t;
    t=t/n;
    n=n+1.0;
  }
  
  cout<<"e="<<e<<endl;
}
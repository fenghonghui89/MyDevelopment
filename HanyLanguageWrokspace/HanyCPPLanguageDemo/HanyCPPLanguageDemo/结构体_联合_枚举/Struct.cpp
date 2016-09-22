//
//  Struct.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//结构体

#include "Struct.hpp"
#include <stdio.h>
#include <iostream>
using namespace std;

#pragma mark - *********** knowledge ***********
struct Emp {
  
  int eno;
  char name[30];
  double salary;
  
  void show(){
    cout<<eno<<":"<<name<<":"<<
    salary<<endl;
  }
};

static void show(struct Emp  e){
  
  cout<<e.eno<<":"<<e.name<<":"<<
  e.salary<<endl;
}

static void knowledge_base(){
  
  //c下的定义枚举变量
  struct var_emp_c;
  
  //c++下的定义枚举变量（省略struct，相当于写了typedef struct Emp Emp;）
  Emp var_emp_cpp = {100,"Hany",1};
  
  show(var_emp_cpp);
  
  var_emp_cpp.show();
}


#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Struct(){

}
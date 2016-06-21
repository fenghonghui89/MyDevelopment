//
//  CPPStructUnionEnum.cpp
//  MyDevelopmentCPP
//
//  Created by 冯鸿辉 on 16/6/21.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "CPPStructUnionEnum.hpp"

#include <iostream>

using namespace std;

#pragma mark 结构体
struct Emp {
  
  int eno;
  char name[30];
  double salary;
  void show(){
    cout<<eno<<":"<<name<<":"<<
    salary<<endl;
  }
};

void  show(struct Emp  e){
  cout<<e.eno<<":"<<e.name<<":"<<
  e.salary<<endl;
}

void test_struct(){

  //c下的定义变量
  struct var_emp_c;
  
  //c++下的定义变量（省略struct，相当于写了typedef struct Emp Emp;）
  Emp var_emp_cpp = {100,"Hany",1};
  
  show(var_emp_cpp);
  
  var_emp_cpp.show();
}


#pragma mark 联合


void test_union(){

  union{
    int data;
    char mychar[4];
  };
  
  /* 
   '0' 48
   'A' 65
   'a' 97 
   */
  //data = 0x31323334;
  
  data = 0x41424344;
  cout<<data<<endl;
  
  for(int i=0;i<4;i++){
    cout<<mychar[i]<<" ";//从41开始读取
  }
  
  cout<<endl;
}


#pragma mark 枚举
enum   Direction{
  D_UP = 88,
  D_DOWN,
  D_LEFT,
  D_RIGHT
};

void test_enum(){

  Direction dire = D_UP;
  cout<<dire<<endl;
  
  int d = dire;
  dire = D_DOWN;
  
  cout<< d <<endl;
  cout<< dire <<endl;

}

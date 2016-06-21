//
//  NameSpace.cpp
//  MyDevelopmentCPP
//
//  Created by 冯鸿辉 on 16/6/21.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "NameSpace.hpp"

#include <iostream>

using namespace std;

void namespace_test();
void namespace_test1();
void namespace_test2();
void namespace_test3();

#pragma mark - ********** method ***********
void test_root_namespace(){

  namespace_test();
}

#pragma mark 不使用命名空间
void namespace_test(){

  //c
  printf("hello c++ \n");
  printf("this is first cpp \n");
  printf("hello \n");
  
  //c++
  std::cout<<"hello c++ app"<<std::endl;
  std::cout<<"this is first cpp \n";
  std::cout<<"hello"<<std::endl;
  
}

#pragma mark 使用命名空间
void namespace_test1(){

  cout<<"hello c++ app"<<endl;
  cout<<"this is first cpp \n";
  cout<<"hello"<<endl;
}

#pragma mark 自定义命名空间 声明和定义可分离
namespace Human{

  int age = 50;
  
  void show(){
    cout<<"show age:"<<age<<endl;
  };
}

namespace Chinese {
  
  int age = 12;
  
  void show();
}

namespace Chinese {
  
  void show(){
    cout<<"show chinese age:"<<age<<endl;
  }
}

//using namespace Human;
//using namespace Chinese;

//using Human::age;
//using Chinese::show;
//using Chinese::age;

void namespace_test2(){
  
  Human::age = 52;
  Human::show();
  
  Chinese::show();
  Chinese::age++;
  Chinese::show();
  
}


#pragma mark 无命名空间

int age = 100;

namespace  {
  
  void show(){
    cout<<"this is noname namespace"<<endl;
  }
}

void namespace_test3(){

  show();
  cout<<age<<endl;
  
  //比较规范
  ::show();
  cout<<::age<<endl;
}

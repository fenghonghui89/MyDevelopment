//
//  Namespace_base.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//命名空间 base

#include "Namespace_base.hpp"

#include <stdio.h>
#include <iostream>

using namespace std;

#pragma mark - *********** knowledge ***********

#pragma mark 不使用命名空间
static void knowledge_noUse(){
  
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
static void knowledge_use(){
  
  cout<<"hello c++ app"<<endl;
  cout<<"this is first cpp \n";
  cout<<"hello"<<endl;
}

#pragma mark -
#pragma mark 自定义命名空间
namespace Human{
  
  static int age = 50;
  
  static void show(){
    cout<<"show age:"<<age<<endl;
  };
}


#pragma mark 声明和定义可分离
namespace Chinese {
  
  static int age = 12;
  
  static void show();
}


namespace Chinese {
  
  static void show(){
    cout<<"show chinese age:"<<age<<endl;
  }
}

#pragma mark use
//using namespace Human;
//using namespace Chinese;

//using Human::age;
//using Chinese::show;
//using Chinese::age;

static void knowledge_custom(){
  
  Human::age = 52;
  Human::show();
  
  Chinese::show();
  Chinese::age++;
  Chinese::show();
  
}

#pragma mark -
#pragma mark 无命名的命名空间

static int age = 100;

namespace  {
  
  static void show(){
    cout<<"this is noname namespace"<<endl;
  }
}

static void knowledge_none(){
  
  //一般
  show();
  cout<<age<<endl;
  
  //规范
  ::show();
  cout<<::age<<endl;
}

#pragma mark - *********** test ***********
#pragma mark - *********** root ***********

void root_Namespace_base(){

}
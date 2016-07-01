//
//  SuperClass.hpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//

#ifndef SuperClass_hpp
#define SuperClass_hpp

#include <stdio.h>
#include <iostream>
using namespace std;

class SuperClass{

  const string name;
  int age;
  
  
  
public:
  
  //自定义析构函数
  ~SuperClass();
  
  //自定义构造函数
  SuperClass();
  
  //
  SuperClass(int age,string name);
  
  void show();
};

#endif /* SuperClass_hpp */

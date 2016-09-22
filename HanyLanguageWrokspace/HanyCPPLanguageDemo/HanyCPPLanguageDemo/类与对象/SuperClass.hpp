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


class Timer{
  
public:
  
  int year;
  int month;
  int day;
  
public:
  
  Timer(){
    cout<<"Date init()"<<endl;
  }
  
  ~Timer(){
    cout<<"~Date()"<<endl;
  }
};




class SuperClass{

#pragma mark - ********** 成员变量 **********
public:
  
  static string className;//静态成员变量
  
  mutable int mutableParama;//const函数只能访问const成员 要访问普通的成员变量 需要在成员变量前加mutable
  const string constParama;
  int a;
  int* p;
  int* parr;
  Timer timer;
  
  
#pragma mark - ********** 成员函数 **********
  
public:
  
#pragma mark 自定义析构函数
  ~SuperClass();
  
#pragma mark 自定义构造函数
  SuperClass();
  SuperClass(int a,string constParama,int mutableParama,int* p,int* parr,Timer timer);
  
#pragma mark 拷贝构造函数
  SuperClass(const SuperClass& sc);
  
#pragma mark const函数与const对象
  void constFunc()const;
  void show()const;
  void show();
  
#pragma mark 调用全局函数
  void useGloableFun();
  
#pragma mark 静态成员函数
  static void showClassName();
  
  
};



#endif /* SuperClass_hpp */

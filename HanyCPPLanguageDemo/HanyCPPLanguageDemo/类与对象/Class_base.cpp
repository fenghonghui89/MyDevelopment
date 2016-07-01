//
//  Class_base.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "Class_base.hpp"
#include <stdio.h>
#include <iostream>

#include "MyTime.hpp"
#include "SuperClass.hpp"
using namespace std;

#pragma mark - *********** knowledge ***********
#pragma mark 使用结构体定义类 成员变量和函数默认是公开的
struct Date{

  int year;
  int month;
  int day;
  
  void setDate(int y = 2014,int m = 1,int d = 1){
    year = y;
    month = m;
    day = d;
  }
  
  void showDate(){
//    cout<<year<<"-"<<month<<"-"<<day<<endl;
    printf("%04d-%02d-%02d\n",year,month,day);
  }
};

static void knowledge_structClass(){

  Date date;//栈
  //Date date();错误，加括号相当于函数声明
  date.setDate();
  date.showDate();
  cout<<date.year<<endl;
  
  Date* date2 = new Date;//堆
  //Date* date3 = new Date();//可以加括号
  date2->setDate(2013,12,31);//→用在“以指针创建对象中”
  date2->showDate();
  cout<<date2->year<<endl;
}

#pragma mark 使用class定义类 访问权限 成员变量和函数默认是private的
class A{
  
public://公开 类内 类外 子类 可以访问
  int age;
  
protected://保护 类内 子类 可以访问
  string name;
  
private://私有 只能类内可以访问
  int sex;
  
};

static void knowledge_classInit(){

  A a;
  cout<<a.age<<endl;
  
}


#pragma mark 
static void knowledge_hppAndCpp(){
  
  SuperClass* sch = new SuperClass;
  sch->show();
  
  SuperClass scs;
  scs.show();
  
  SuperClass sc1 = SuperClass(12, "Peter");
  sc1.show();
}

#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Class_base(){
  
  knowledge_hppAndCpp();
}
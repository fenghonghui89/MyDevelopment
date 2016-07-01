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
using namespace std;

#pragma mark - *********** knowledge ***********
#pragma mark 使用结构体定义类
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
  
  Date* date2 = new Date;//堆
  //Date* date3 = new Date();//可以加括号
  date2->setDate(2013,12,31);
  date2->showDate();
  //→用在“以指针创建对象中”
}
#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Class_base(){
  
}
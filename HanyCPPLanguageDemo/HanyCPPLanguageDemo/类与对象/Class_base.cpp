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

#pragma mark 访问权限 class对象的成员变量和函数默认是private的
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


#pragma mark - < 使用class定义类 >
#pragma mark 堆内存对象 栈内存对象
static void knowledge_heapObjAndStackObj(){
  
  //堆内存对象
  SuperClass* sch = new SuperClass;
  sch->show();
  
  //栈内存对象
  SuperClass scs;
  scs.show();
}

#pragma mark 带参数初始化
static void knowledge_initWithParama(){
  
  SuperClass sci1 = SuperClass();
  sci1.show();
  
  int p = 3;
  int *parr = new int[5];
  SuperClass sci2 = SuperClass(1, "Hany", 2, &p,parr,Timer());
  sci2.show();
  
}

#pragma mark const对象 const函数
static void knowledge_constObjAndConstFun(){
  
  const SuperClass* csc = new SuperClass;
  csc->show();
  delete csc;
  
  SuperClass *ncsc = new SuperClass;
  ncsc->show();
  delete ncsc;
}

#pragma mark 调用全局函数
void genenalFun(){
  
  cout<<"genenalFun~"<<endl;
}

static void knowledge_callGeneral(){
  
  SuperClass sc;
  sc.useGloableFun();
}

#pragma mark 拷贝构造函数
static void showObj(SuperClass sc){
  cout<<"showObj"<<endl;
};

static void showObj1(const SuperClass& sc){
  cout<<"showObj1"<<endl;
};

static SuperClass getSuperClass(const SuperClass& sc){
  cout<<"getSuperClass"<<endl;
  return sc;
};

static void knowledge_copyInit(){

  //调用时机1
  SuperClass sc;
  cout<<sc.a<<endl;
  cout<<&(sc.a)<<endl;
  
  SuperClass cpsc = sc;//用同类型对象生成对象
  cout<<cpsc.a<<endl;
  cout<<&(cpsc.a)<<endl;
  
  
  
  //调用时机2
  showObj(sc);//调用时机2：给非引用类型的函数参数传参时
  showObj1(sc);//引用类型做参数可防止调用构造函数
  
  
  
  //调用时机3：在函数中返回非引用类型的返回值时
  getSuperClass(sc);
}

#pragma mark 静态成员函数
static void knowledge_static(){

  SuperClass::showClassName();//nonono~
  
  SuperClass sc;
  sc.className = "hahaha~";
  cout<<SuperClass::className<<endl;//hahaha~
  SuperClass::showClassName();//hahaha~
}

#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Class_base(){
  
  knowledge_copyInit();
}
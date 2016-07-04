//
//  SuperClass.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//父类


#include "SuperClass.hpp"

#pragma mark - *************** method ****************
#pragma mark - < lifecycle >
#pragma mark 析构函数
/*
 自定义析构函数要公开 且对象是创建在栈内存 才会自动调用?
 free对象不会调用析构函数 delete对象会调用析构函数
 */
SuperClass::~SuperClass(){
  
  delete p;
  p = NULL;
  
  delete[] parr;
  parr = NULL;
  
  cout<<"88~"<<endl;
}

#pragma mark 构造函数

//最原始的自定义构造函数
//SuperClass::SuperClass(){
//  cout<<"hello~"<<endl;
//}

//带默认参数的自定义构造函数
SuperClass::SuperClass():a(1),constParama("Hany"),mutableParama(2),p(NULL),parr(new int[5]),timer(Timer()){
  
  cout<<"hello,i'm :"<<a<<" "<<constParama<<" "<<mutableParama<<" "<<p<<" "<<parr<<" "<<timer.day<<endl;
}

//带参数列表的自定义构造函数
SuperClass::SuperClass(int a,string constParama,int mutableParama,int* p,int* parr,Timer timer){
  
  cout<<"hey,boy,i'm :"<<a<<" "<<constParama<<" "<<mutableParama<<" "<<p<<" "<<parr<<" "<<timer.day<<endl;
  
  this->a = a;
  this->mutableParama = mutableParama;
  this->p = p;
  this->timer = timer;
}



#pragma mark 拷贝构造函数
/*
 有指针或者引用类型的成员时，会引发双释放（double free）问题（复制后两个一样的指针指向同一块内存）
 只有析构是无法完整解决双释放问题的，为了完整解决双释放问题，需要申请新的内存空间给新对象的指针成员
 */
SuperClass::SuperClass(const SuperClass& sc){
  
  cout<<"拷贝构造~"<<endl;
  this->a = sc.a;
  this->mutableParama = sc.mutableParama;
  this->p = sc.p;
  this->timer = sc.timer;
  this->parr = sc.parr;
  
  //为了完整解决双释放问题，需要申请新的内存空间给新对象的指针成员
  parr = new int[5];
  for (int i = 0; i<5; i++) {
    parr[i] = sc.parr[i];
  }
}



#pragma mark 调用全局函函数
void genenalFun();//在类中使用全局函数需要前置声明

void SuperClass::useGloableFun(){
  genenalFun();
}



#pragma mark const对象 const函数
//const函数
void SuperClass::constFunc()const{
  
  mutableParama += 1;//不加mutable则不能访问
  cout<<"show constFunc"<<mutableParama<<endl;//不加mutable也能输出...
}

//const对象只能调用这个 非const对象也可以调用这个 跟下面的构成重载
void SuperClass::show()const{
  
  constFunc();
}

//const对象不能调用这个 非const对象会优先调用这个 跟上面的构成重载
void SuperClass::show(){
  
  constFunc();

}

#pragma mark 静态成员函数
/*
 静态成员变量要先声明在头文件，且必须在类外先初始化，不能在方法内初始化
 静态成员函数只能调用静态成员变量
 其他类调用时，可创建对象，再修改静态成员变量
 */
string SuperClass::className = "nonono~";
void SuperClass::showClassName(){

  cout<<"class name:"<<className<<endl;
}


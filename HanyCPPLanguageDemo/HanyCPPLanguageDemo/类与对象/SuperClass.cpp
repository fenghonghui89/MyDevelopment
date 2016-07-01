//
//  SuperClass.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "SuperClass.hpp"

#pragma mark - *************** method ****************
#pragma mark - < lifecycle >
#pragma mark 析构函数
/*
 自定义析构函数要公开 且对象是创建在栈内存 才会自动调用？
 */
SuperClass::~SuperClass(){
  
  cout<<"88~"<<endl;
}

#pragma mark 构造函数
/*
 “自定义构造函数”和“带初始化参数列表的自定义构造函数”会冲突
 */


/*
 自定义构造函数
 */
//SuperClass::SuperClass(){
//  
//  cout<<"hello~"<<endl;
//}



/*
 带初始化参数列表的自定义构造函数
 
 const类型的变量或者引用类型的变量 必须使用初始化参数列表
*/
SuperClass::SuperClass():age(1),name("Hany"){
  cout<<"hello my name is "<<name<<endl;
}

/*
 
 */
SuperClass::SuperClass(int age,string name){
  this->age = age;
}

#pragma mark - < other >



void SuperClass::show(){
  
  cout<<"show:"<<name<<" "<<age<<endl;
}
//
//  Memory_base.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//内存 base

#include "Memory_base.hpp"

#include <stdio.h>
#include <iostream>
using namespace std;

#pragma mark - *********** knowledge ***********
#pragma mark 在堆中申请内存 new delete
/*
 c:malloc free
 c++:new delete / new[] delete[]
 */
static void knowledge_heap_base(){

  int *p = new int;
  cout<<p<<endl;
  
  delete p;//标记为自由状态，可以使用，不使用的话为原值
  p = NULL;
  cout<<p<<endl;
  
  p = new int(123);
  cout<<p<<endl;
}

static void knowledge_heap_array(){

  int *p = new int[5];
  
  p[0] = 1;
  p[1] = 2;
  p[2] = 3;
  p[4] = 4;
  p[5] = 5;
  
  for (int i = 0; i<5; i++) {
    cout<<p[i]<<endl;
  }
  
  delete[] p;
  p = NULL;
  
  
}

#pragma mark 在栈中申请内存
static void knowledge_stack(){

  char data[40];//栈内存自动释放
  cout<<data<<(int *)data<<endl;
  
  int *p = new (data) int[10]; //p的内存就是data指向的内存，无需考虑释放
  cout<<p<<endl;
}
#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Memory_base(){
  
}
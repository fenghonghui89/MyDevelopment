//
//  Const_base.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//const

#include "Const_base.h"
#include <stdio.h>


#pragma mark - ********** knowledge **************
static void knowledge_const(){
  
  const int i = 20;
  int const is = 20;
  //    i = 30;//被修饰的变量不能修改
  //    is = 30;//被修饰的变量不能修改
  printf("%d %d",i,is);
  

}

static void knowledge_pointAndConst(){
  
  //指向的内容不能改，在初始化之后可以再指向别的内存 类型是const *int
  int i2 = 20;
  int i2s = 20;
  const int *p = &i2;
  p = &i2s;
  
  int const *p1 = &i2;
  p1 = &i2s;
  
  //指向的内容可以改，在初始化之后不能再指向别的内存 类型是int *const
  int i3 = 20;
  int i3s = 30;
  int * const pp = &i3;
  *pp = i3s;
  
  
}

//const修饰非引用类型的参数 是希望函数内部不修改参数的值
static int getMax(const int x,int y){
  //x = x+1;
  return x>y?x:y;
}

#pragma mark - *********** root ***********

void root_const_base(){
  
}
//
//  Const_base.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "Const_base.h"

void Const_base_root(){

}

#pragma mark - ********** knowledge **************
void cConstTest0()
{
  const int i = 20;
  int const is = 20;
  //    i = 30;//被修饰的变量不能修改
  //    is = 30;//被修饰的变量不能修改
  
  //指向的内容不能改，在初始化之后可以再指向别的内存
  int i2 = 20;
  int i2s = 20;
  const int *p = &i2;
  //    *p = 30;
  p = &i2s;
  
  //指向的内容可以改，在初始化之后不能再指向别的内存
  int i3 = 20;
  int i3s = 30;
  int* const pp = &i3;
  //    pp = &i3s;
  *pp = i3s;
}



#pragma mark - *********** practice **************
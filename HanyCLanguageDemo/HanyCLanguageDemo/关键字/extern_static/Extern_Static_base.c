//
//  Extern_Static_base.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//extern static

#include "Extern_Static_base.h"

#include "HasExtern.h"


#include <stdio.h>



#pragma mark - ********** knowledge **************
#pragma mark extern
static void knowledge_extern(){
  
  
  
  //.h已经公开并用extern修饰 - input头文件就可以用（推荐）
  printf("%d",age_Keyword);
  
  
  
  //.h没有公开 - 在使用变量的文件中，要使用extern关键字声明全局变量才可使用，并且可以得到全局变量的值
  extern char *name_Keyword;
  printf("%s",name_Keyword);

}


#pragma mark - auto与static

//修饰全局变量时 只能该文件内使用
static int si = 5;

//修饰函数时 只能该文件内使用
static void knowledge_autoAndStatic(){
  
  //修饰局部变量时
  auto int i = 4;//auto（默认），不累加计数，生命周期为每次函数运行期间，每次运行完就会释放内存空间
  static int j = 5;//static，累加计数，生命周期为程序运行期间，每次运行完会保留内存空间和值
  i++;
  j++;
  
  printf("i:%d\n",i);
  printf("j:%d\n",j);
  printf("si:%d",si);
}





#pragma mark - *********** root ***********

void root_Extern_Static_base(){

}
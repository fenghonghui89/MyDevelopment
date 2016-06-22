//
//  test2.cpp
//  cmtest
//
//  Created by 冯鸿辉 on 16/6/22.
//  Copyright © 2016年 MD. All rights reserved.

/*
 本程序由主函数输入一字符串，调用函数，把该字符串中的数字0～9转换成小写字母a～j；所有小写字母转换成大写字符。然后在主函数输出转换后的字符串
 */

#include "test2.hpp"
#include <iostream>
#include <ctype.h>
using namespace std;

void change(char *s1, char *s2);

void test2_root(){

  char str1[20], str2[20];
  cin>>str1;
  change(str1,str2);
  cout<<str2<<endl;
}


void change(char *s1, char *s2){
  
  while(*s1){
    
    if(*s1>='0'&&*s1<='9')
      *s2=*s1 + 'a' -'0';
    else
      *s2=toupper(*s1);
    
    s1++;
    s2++;
  }
  
  *s2='\0';
}
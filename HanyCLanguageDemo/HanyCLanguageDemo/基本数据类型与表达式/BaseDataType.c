//
//  BaseDataType.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//基本数据类型

#include "BaseDataType.h"
#include <stdbool.h>

void BaseDataType_change();
void BaseDataType_char();
void BaseDataType_otherSystem();

void BaseDataType_charBig();


void BaseDataType_root(){
  

}

#pragma mark - ********** knowledge ********

#pragma mark bool类型
void BaseDataType_base(){
  
  bool bc = true;//c89没有定义bool，所以要#include <stdbool.h>
//  BOOL boc = YES;//OC:or no
  
  int *ic = NULL;//C
//  int *ioc = nil;//OC
  
//  id pid = nil;//oc的id类型相当于void*
}


#pragma mark 数据类型转换
void BaseDataType_change(){
  
  char c = 127;
  int i = 200;
  printf("c:%d\n",c+2);
  
  c = (char)i;//强制类型转换(推荐)
  printf("c:%d\n",c);
  printf("i:%d\n",i);
}

#pragma mark char与ascii值
void BaseDataType_char(){
  
  //字符与ascii值的对应
  char ch1 = 'A';
  printf("ch1 int:%d\n",ch1);
  printf("ch1 char:%c\n",ch1);
  
  char ch2 = '5';
  printf("ch2 int:%d\n",ch2);
  printf("ch2 char:%c\n",ch2);
  
  //字符可以进行运算
  char ch3 = 'A'+4;
  printf("ch3 int:%d\n",ch3);
  printf("ch3 char:%c\n",ch3);
  
  char ch4 = 'b'-('a'-'A');
  printf("ch4 int:%d\n",ch4);
  printf("ch4 char:%c\n",ch4);
}

#pragma mark 8进制 16进制
void BaseDataType_otherSystem(){
  
  int i = 11;//默认，10进制
  int i2 = 011;//8进制
  int i3 = 0x11;//16进制
  
  //%d输出10进制的值 %o输出8进制的值 %x输出16进制的值
  printf("i=%d i=%o i=%x\n",i,i,i);
  printf("i2=%d i2=%o i2=%x\n",i2,i2,i2);
  printf("i3=%d i3=%o i3=%x\n",i3,i3,i3);
}

#pragma mark sizeof计算数据类型所占空间
void BaseDataType_size(){
  
  /*
   sizeof计算数据类型所占空间
   不同数据类型所占空间不能按照理论得出，编译器和CPU不同，所占空间也不同。
   */
  printf("sizeof(char):%ld\n",sizeof(char));
  printf("sizeof(short int):%ld\n",sizeof(short int));
  printf("sizeof(int):%ld\n",sizeof(int));
  printf("sizeof(long int):%ld\n",sizeof(long int));
  printf("sizeof(long long int):%ld\n",sizeof(long long int));
  printf("sizeof(float):%ld\n",sizeof(float));
  printf("sizeof(double):%ld\n",sizeof(double));
  printf("sizeof(long double):%ld\n",sizeof(long double));
  
  int i=3ul;
  printf("sizeof(int i=3ul):%ld\n",sizeof(i));
}

#pragma mark - *********** practice **************
#pragma mark 练习：输入任意小写字母得到相应的大写字母
void BaseDataType_charBig(){
  
  char ch;
  printf("请输入一个小写字母:\n");
  scanf("%c",&ch);
  printf("%c->%c\n",ch,ch-('a'-'A'));
}


//
//  BaseDataType.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//基本数据类型

#include "BaseDataType.h"
#include <stdbool.h>
#include <stdio.h>
#include <limits.h>



#pragma mark - ********** knowledge ********

#pragma mark float / double

static void knowledge_floatAndDouble(){

  float f = 2.14e+3;
  printf("%f\n",f);//2.14*10^3 2140.000000
  
  double d = 2.14e+3;
  printf("%lf\n",d);//2.14*10^3 2140.000000
  printf("%.8f\n",d);//2.14*10^3 2140.00000000
}

#pragma mark bool
static void knowledge_base(){
  
  bool bc = true;//c89没有定义bool，所以要#include <stdbool.h>
//  BOOL boc = YES;//OC:or no
  printf("%d",bc);
  
}


#pragma mark 数据类型转换
static void knowledge_change(){
  
  char c = 127;
  int i = 200;
  printf("c:%d\n",c+2);
  
  c = (char)i;//强制类型转换(推荐)
  printf("c:%d\n",c);
  printf("i:%d\n",i);
}

#pragma mark char与ascii值
static void knowledge_char(){
  
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
static void knowledge_otherSystem(){
  
  int i = 11;//默认，10进制
  int i2 = 011;//8进制
  int i3 = 0x11;//16进制
  
  //%d输出10进制的值 %o输出8进制的值 %x输出16进制的值
  printf("i=%d i=%o i=%x\n",i,i,i);
  printf("i2=%d i2=%o i2=%x\n",i2,i2,i2);
  printf("i3=%d i3=%o i3=%x\n",i3,i3,i3);
}

#pragma mark sizeof计算数据类型所占字节数 取值范围 类型后缀
static void knowledge_size(){
  
  //所占字节数
  printf("sizeof(char):%ld\n",sizeof(char));
  
  printf("sizeof(short int):%ld\n",sizeof(short int));
  printf("sizeof(int):%ld\n",sizeof(int));
  printf("sizeof(long int):%ld\n",sizeof(long int));
  printf("sizeof(long long int):%ld %d\n",sizeof(long long int),__SIZEOF_LONG_DOUBLE__);
  
  printf("sizeof(float):%ld\n",sizeof(float));
  printf("sizeof(double):%ld\n",sizeof(double));
  printf("sizeof(long double):%ld\n",sizeof(long double));
  
  //取值范围
  printf("short int:%d %d\n",INT16_MIN,INT16_MAX);
  printf("int:%d %d\n",INT32_MIN,INT32_MAX);
  printf("long:%ld %ld\n",LONG_MIN,LONG_MAX);
  printf("long long:%lld %lld\n",LONG_LONG_MIN,LONG_LONG_MAX);
  
  //类型后缀，标识数值的准确类型，防止编译器错误判断
  printf("sizeof(int i=3ul):%ld\n",sizeof(300,000ul));//300,000默认是int，加后缀则是unsign long

}


#pragma mark - *********** test **************
#pragma mark 练习：输入任意小写字母得到相应的大写字母
static void test_charBig(){
  
  char ch;
  printf("请输入一个小写字母:\n");
  scanf("%c",&ch);
  printf("%c->%c\n",ch,ch-('a'-'A'));
}




#pragma mark - *********** root ***********
void root_BaseDataType(){
  knowledge_size();
}
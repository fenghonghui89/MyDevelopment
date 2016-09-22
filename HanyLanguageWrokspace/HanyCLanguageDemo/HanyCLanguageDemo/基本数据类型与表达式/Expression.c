//
//  Expression.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//运算符与表达式
#include <stdio.h>
#include "Expression.h"



#pragma mark - ********** knowledge ********
#pragma mark 算术运算符：+-*&%
static void knowledge_calculate(){

  printf("7+3=%d\n",7+3);
  printf("7-3=%d\n",7-3);
  printf("7*3=%d\n",7*3);
  printf("7/3=%d\n",7/3);
  printf("7%%3=%d\n",7%3);//转义字符
  
//  printf("7/0=%d\n",7/0);
//  printf("7%%0=%d\n",7%0);//0不能被/或%
  
  printf("7/0.0=%f\n",7/0.0f);//0.0可以/，但输出结果为inf
//  printf("7%%0.0=%f\n",7/0.0);//0.0不能%
  
  //%的结果符号与被除数相同;如果除数于被除数任一带负号，则/的结果带负号
  printf("-7/3=%d\n",-7/3);
  printf("7/-3=%d\n",7/-3);
  printf("-7%%3=%d\n",-7%3);

}

#pragma mark 运算符优先级与结合序
static void knowledge_priority(){
  
  int i=5;
  printf("i++:%d\n",i++);
  printf("++i:%d\n",++i);
  

  /*
   先运算优先级较高的，同一优先级的按照结合性顺序运算
   e.g. a=b=c =是右结合性 先算b=c
   
   不要运用太多自加自减，对程序有一定危害性，不一定正确
   */

}


#pragma mark 逻辑运算符
static void knowledge_logic(){
  
  /*
   逻辑运算符 与或非
   只要条件的值为非0，则为真
   */
  int a=11,b=9;
  
  if (a>10&&b>10) {
    printf("a>10&&b>10成立\n");
  }
  
  if (a>10||b>10) {
    printf("a>10||b>10成立\n");
  }
  
  printf("a>10&&b>10的值：%d\n",a>10&&b>10);
  printf("a>10||b>10的值：%d\n",a>10||b>10);
  
  //只要条件的值为非0，则为真
  if (!(a>=10)) {
    printf("if语句执行了输出\n");
  }
}

#pragma mark 取地址与间接寻址：& 、*(&i)
static void knowledge_access(){
  
  int i=99;
  printf("i address:%p\n",&i);
  printf("i value:%d\n",*(&i));
}



#pragma mark 逗号表达式
static void knowledge_comma(){
  
  int a=2,b=3,c=4,x=0,y=0,z=0;
  z=(x+=1,x=a+b,y=b+c,x+y);//取最后的表达式的值
  printf("z=%d",z);
}


#pragma mark - ********** root ********
void root_Expression(){
  
}
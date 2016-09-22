//
//  Define_base.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//宏 base
#include <stdio.h>
#include "Define_base.h"



#pragma mark - ********** knowledge **************
/*
 
 C中的宏分为两类，对象宏(object-like macro)和函数宏(function-like macro)。
 
 ##在宏中是一个特殊符号，它表示将两个参数连接起来这种运算，成为新的标识
 在逗号和__VA_ARGS__之间的双井号，除了拼接前后文本之外，还有一个功能，那就是如果后方文本为空，那么它会将前面一个逗号吃掉
 
 __VA_ARGS__表示的是宏定义中的...中的所有剩余参数
 
 写为...的参数被叫做可变参数列表，可变参数的个数不做限定
 
 换行之后要加 \
 
 do-while(0)可以吃掉分号 防止if-else中if只有一个语句的情况下因为分号导致编译错误，几乎已经成为了标准写法。而且while(0)的好处在于，在编译的时候，编译器基本都会为你做好优化，把这部分内容去掉，最终编译的结果不会因为这个do while而导致运行效率上的差异
 */


#pragma mark - 函数宏（注意参数是没有数据类型）
#define MIANJI(r) 3.1415926*r*r
#define CHENG(x,y) ((x)*(y))
#define UPPER(x) ((x)>='a'&&(x)<='z')?x-('a'-'A'):x
#define MAX1(x,y) ((x)>(y))?(x):(y)


#pragma mark - do while(0) 与换行
#define MD_TEST_DEFINE(fmt,...) do{   \
                                    printf("111");                             \
                                    }while(0)
static void knowledge_dowhile(){

  MD_TEST_DEFINE(1111);
}


#pragma mark - #x与##x
#define STR(x) #x
#define fun(x) printf( "%s = %d\n", #x, x)
#define DEF(x) student##x
static void knowledge_x(){
  
  //#x代表x的内容转换成字符串
  printf(STR(11111111111\n));//11111111111
  int m = 5;
  fun(m);//m = 5
  
  //##运算符
  int DEF(10) = 10;
  printf("~%d",student10);//~10
}

#pragma mark - c语言常用的宏
static void knowledge_common(){
  
  printf("当前的行号:%d",__LINE__);
  printf("当前的文件名:%s",__FILE__);
  printf("当前的日期:%s",__DATE__);
  printf("当前的时间:%s"__TIME__);
}

#pragma mark - 根据参数编译
static void knowledgeif(){
  
#define qidong @"启动"
  
#ifndef qidong
  printf("没有启动");
#else
  printf("启动");
#endif
}

#pragma mark - 根据条件来进行编译/undef
static void knowledge_undef(){
  
#define kaiqi @"开启"
  
#if defined(kaiqi)
  printf("开启");
#else
  printf("没开启");
#endif
  
#undef kaiqi
#if defined(kaiqi)
  printf("开启");
#else
  printf("没开启");
#endif
}

#pragma mark - 根据宏值来进行编译
static void knowledge_value(){
  
#define value 3
  
#if value == 4
  printf("数值是4");
#else
  printf("数值不是4");
#endif
}

#pragma mark - *********** root ***********

void root_Define_base(){
  
  knowledge_x();
}

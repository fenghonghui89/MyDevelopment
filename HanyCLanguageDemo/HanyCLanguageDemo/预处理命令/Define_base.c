//
//  Define_base.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "Define_base.h"

void Define_base_root(){

}

#pragma mark - ********** knowledge **************


#pragma mark 宏函数（注意参数是没有数据类型）
#define MIANJI(r) 3.1415926*r*r
#define CHENG(x,y) ((x)*(y))
#define UPPER(x) ((x)>='a'&&(x)<='z')?x-('a'-'A'):x
#define MAX1(x,y) ((x)>(y))?(x):(y)


#pragma mark #x与##x
void define_x(){
  
  //#x代表x的内容转换成字符串
#define STR(x) #x
#define fun(x) printf( "%s = %d\n", #x, x)
  printf(STR(11111111111\n));
  int m = 5;
  fun(m);
  
  //##运算符可以将标识与其它内容拼接在一起，成为新的标识
#define DEF(x) student##x
  int DEF(10) = 10;
  printf("~%d",DEF(10));
}

#pragma mark c语言常用的宏
void define_common(){
  
  printf("当前的行号:%d",__LINE__);
  printf("当前的文件名:%s",__FILE__);
  printf("当前的日期:%s",__DATE__);
  printf("当前的时间:%s"__TIME__);
}

#pragma mark 根据参数编译
void define_if(){
  
#define qidong @"启动"
  
#ifndef qidong
  printf("没有启动");
#else
  printf("启动");
#endif
}

#pragma mark 根据条件来进行编译/undef
void define_undef(){
  
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

#pragma mark 根据宏值来进行编译
void define_value(){
  
#define value 3
  
#if value == 4
  printf("数值是4");
#else
  printf("数值不是4");
#endif
}

#pragma mark - *********** practice **************
//
//  MD_C_String_CFile.c
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/18.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#include "MD_C_String_CFile.h"
#include <string.h>
#include <stdlib.h>
#include <malloc/malloc.h>
void cStringTest0();
void cStringTest1();
void cStringTest2();
void GetMemory(char *p, int num);
void GetMemory2(char **p, int num);

void cStringTest()
{
  cStringTest1();
}



#pragma mark - ********** method **********
#pragma mark - < 指针数组 >
void cStringTest0()
{
  char* str[3]={"关羽","张飞","赵云"};
  for (int i=0; i<3; i++) {
    printf("str[%d]:%s\n",i,str[i]);
    printf("str[%d]:%p\n",i,str[i]);
  }
  
  //if (str[0]==str[1]);//不能直接做比较，因为保存的只是内存地址
}

#pragma mark - < 字符串的声明、修改、输入输出 >
#pragma mark 定义一个字符串的几种方式
void cStringTest1(){
  
  char str[6] = {'h','e','l','l','o','\0'};//字符数组，标准字符串必须带\0
  
  char str2_1[] = "hello";//跟上面相同
  char str2_2[] = {"hello"};
  
  char *str3_1 = "hello";//指针，只能找到字符串的位置
  char *str3_2 = {"hello"};
  

  printf("str:%s %p\n",str,str);
  printf("str2:%s %p\n",str2_1,str2_1);
  printf("str3:%s %p\n",str3_1,str3_1);
  
}

void test_string_change(){

  char str[6] = {'h','e','l','l','o','\0'};
  char str2_1[] = "hello";
  char *str3_1 = "hello";
  
  /*
   字符串通常保存在内存的代码区，只能读取不能修改，如果发现存在有相同的字符串，则会用原来的内存空间
   字符数组对应着一块内存区域，其地址和容量在生命期里不会改变，只有数组的内容可以改变
   
   当指针指向常量字符串时，它的内容是不可以被修改的，但可以指向其他内容
   */
  
  str[0] = 'b';
//  str = {'h','e'};//error
//  str = "sss";//error
  
  str2_1[0] = 's';
//  str2_1 = {'s','s'};//error
//  str2_1 = "sss";//error

  str3_1 = "sss";
//  str3_1[0] = 'a';//不会报错，但运行会崩
}

#pragma mark 控制台字符串输出
void test_string_out(){

  char str[] = "hello world";
  
  printf("%s",str);
  puts("自动换行");
  printf("%s",str);
}

#pragma mark 字符串输入
void test_string_in(){

  char str4[10];
  printf("请输入一个字符串：\n");
  //scanf("%s",str4);//碰到空格会结束输入,不安全
  //gets(str4);//同上
  fgets(str4,3,stdin);//保存数据的首位置，保存数据的长度，获取数据的方式，会自动在数据后面加上'\n'(占一个字符)，所以长度要+1
  printf("str4:%s\n",str4);
}

#pragma mark - < 字符串函数库（要先#include <string.h>）>

#pragma mark 常用
void cStringTest2(){
  
  char str[10] = "abc";
  char str2[10] = "def";
  
  //字符串复制;不能用于以指针创建的字符串
  strcpy(str2,str);
  printf("str2:%s\n",str2);
  
  //把两个字符串连接在一起放到第一个的字符串空间
  strcat(str,str2);
  printf("str2:%s\n",str);
  
  //输出字符串长度（不算结束符）
  printf("%ld\n",strlen(str));
  
  //根据ASC来进行比较的，结果为0时，两个字符串相等
  int i = strcmp(str,str2);
  printf("%d",i);
  

}


#pragma mark 值传递、地址传递（e.g.char **p）
/*
 以指针声明的字符串不能直接用于strcpy,strcat，但可用于strlen和strcmp
 因为那是指针指向字符串所在的地址，不能对指针和字符串进行复制或连接操作
 需要用地址传递的方式 分配内存才能用
 */

void test_string_fun(){
  
  char *stra = "abc";
  char *strb = "def";
  
  GetMemory(stra, 100);//值传递
  GetMemory2(&stra, 100);//地址传递
  
  stpcpy(stra, strb);
  free(stra);
  
}

//值传递
void GetMemoryValue(char *p, int num)
{
  p = (char *)malloc(sizeof(char) * num);
}

//地址传递
void GetMemoryAddress(char **p, int num)
{
  *p = (char *)malloc(sizeof(char) * num) ;
}
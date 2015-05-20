//
//  MDChar1.c
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/4/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#include "MDChar1.h"
void charTest1(void);
void charTest2(void);
void charTest3(void);
void charTest4(void);



void charChangeASCII (void)
{
    charTest2();
}

#pragma mark 字符与ascii值
void charTest1 (void)
{
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

#pragma mark练习：输入任意小写字母得到相应的大写字母
void charTest2 (void)
{
    char ch;
    printf("请输入一个小写字母:\n");
    scanf("%c",&ch);
    printf("%c->%c\n",ch,ch-('a'-'A'));
}

#pragma mark 进制问题
void charTest3 (void)
{
    int i = 11;//默认，10进制
    int i2 = 011;//8进制
    int i3 = 0x11;//16进制
    
    //%d输出10进制的值 %o输出8进制的值 %x输出16进制的值
    printf("i=%d i=%o i=%x\n",i,i,i);
    printf("i2=%d i2=%o i2=%x\n",i2,i2,i2);
    printf("i3=%d i3=%o i3=%x\n",i3,i3,i3);
}



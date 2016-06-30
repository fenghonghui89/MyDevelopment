//
//  TwoArray.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//二维数组
#include <stdio.h>
#include "TwoArray.h"


#pragma mark - ********** knowledge ********
#pragma mark 二维数组的初始化，赋值，遍历
static void knowledge_init(){
  
  int array[2][2];//会有随机数产生
  int array1[2][2] = {0};
  int array2[2][2] = {{1,2},{3,4}};
  int array3[][2] = {1,2,3,4};//可以这样定义
  //int array4[3][]={1,2,3,4,5,6};不能这样定义，一维可以不定义，但二维必须定义
  int array5[][2]={};//会有随机数产生
  
  for (int i=0; i<3; i++) {
    for (int j=0; j<2; j++) {
      printf("array[%d][%d]=%d\t",i,j,array5[i][j]);
    }
    printf("\n");
  }
  
}
#pragma mark - *********** test **************
#pragma mark 输入5个人的三科成绩，输出5个人的成绩、分科平均分、个人平均分
static void test0(){
  
  int s[3][5]={0};
  int sumID[3]={0};
  int i=0,j=0;
  int sum=0;
  
  for (i=0; i<3;i++) {
    switch (i) {
      case 0:
        printf("请输入语文成绩：\n");
        break;
      case 1:
        printf("请输入数学成绩：\n");
        break;
      case 2:
        printf("请输入英语成绩：\n");
        break;
    }
    for (j=0; j<5; j++) {
      switch (j) {
        case 0:
          printf("请输入张三的成绩：");
          scanf("%d",&s[i][j]);
          break;
        case 1:
          printf("请输入李四的成绩：");
          scanf("%d",&s[i][j]);
          break;
        case 2:
          printf("请输入王五的成绩：");
          scanf("%d",&s[i][j]);
          break;
        case 3:
          printf("请输入赵六的成绩：");
          scanf("%d",&s[i][j]);
          break;
        case 4:
          printf("请输入钱七的成绩：");
          scanf("%d",&s[i][j]);
          break;
      }
    }
  }
  
  printf("\t张三\t李四\t王五\t赵六\t钱七\n");
  for (i=0; i<3; i++) {
    switch (i) {
      case 0:
        printf("语文\t");
        break;
      case 1:
        printf("数学\t");
        break;
      case 2:
        printf("英语\t");
        break;
    }
    for (j=0; j<5; j++) {
      printf("%d\t",s[i][j]);
      sum+=s[i][j];
    }
    sumID[i]=sum;
    sum=0;
    printf("\n");
  }
  
  for (i=0; i<3; i++) {
    switch (i) {
      case 0:
        printf("语文分科平均分：%d\t",sumID[i]/5);
        break;
      case 1:
        printf("数学分科平均分：%d\t",sumID[i]/5);
        break;
      case 2:
        printf("英语分科平均分：%d\t",sumID[i]/5);
        break;
    }
  }
  printf("\n");
  
  for (j=0; j<5; j++) {
    for (i=0; i<3; i++) {
      sum+=s[i][j];
    }
    switch (j) {
      case 0:
        printf("张三的平均分为：%d\t",sum/3);
        break;
      case 1:
        printf("李四的平均分为：%d\t",sum/3);
        break;
      case 2:
        printf("王五的平均分为：%d\t",sum/3);
        break;
      case 3:
        printf("赵六的平均分为：%d\t",sum/3);
        break;
      case 4:
        printf("钱七的平均分为：%d\t",sum/3);
        break;
    }
    sum=0;
  }
  
}

#pragma mark - *********** root ***********

void root_TwoArray(){
  
}
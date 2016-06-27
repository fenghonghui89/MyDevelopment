//
//  OneArray.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "OneArray.h"

void OneArray_root(){

}

#pragma mark - ********** knowledge ********
#pragma mark 数组的初始化，赋值，遍历，计算数组长度
void OneArray_init(){

  int array[5] = {0};
  int array2[5] = {1,2,3,4,5};
  array2[4] = 10;
  int num[] = {0,1,2,3,4,5};
  
  printf("array[0]:%d\n",array[0]);
  printf("array2[0]:%d\n",array2[0]);
  printf("array2[4]:%d\n",array2[4]);
  printf("sizeof(num):%lu\n",sizeof(num));
  
  //数组的长度可以用数组所占空间除以每个元素所占空间得出
  printf("num's length:%ld\n",sizeof(num)/sizeof(num[0]));
}

#pragma mark - *********** practice **************
#pragma mark 输入10个整数，逆向输出该10个整数
void OneArray_test(){

  int num[10],i=0;
  for (i=0; i<10; i++) {
    printf("请输入第%d个整数：\n",i+1);
    scanf("%d",&num[sizeof(num)/sizeof(num[0])-(i+1)]);
  }
  
  for (i=0; i<10; i++) {
    printf("%d\t",num[i]);
  }
}
//
//  test3.cpp
//  cmtest
//
//  Created by 冯鸿辉 on 16/6/22.
//  Copyright © 2016年 MD. All rights reserved.
/*
 （1）输入k（<100）个整数到数组x[100]中；
 （2）计算k个数的平均值及大于平均值的元素个数。
 */

#include "test3.hpp"
#include <iostream>
using namespace std;

void calculate();

void test3_root(){
  calculate();
}


void calculate(){
  
  int x[100],k,i,n;
  double sum = 0.0,ave;
  
  cout<<"请问一共有多少个数据?\n";
  cin>>k;
  
  //求和
  for(i=0;i<k;i++){
    printf("请输入第%d个数：",i+1);
    cin>>x[i];
    sum+=x[i];
  }
  
  //求平均值
  ave=sum/k;
  
  //求大于平均值的元素个数
  n = 0;
  for(i=0;i<k;i++)
    if(x[i]>ave)
      n++;
  
  cout<<"sum:"<<sum<<"\n";
  cout<<"average:"<<ave<<"\n";
  cout<<"There are "<<n<<" elements large than average.\n";
}
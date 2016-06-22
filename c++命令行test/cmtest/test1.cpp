//
//  test1.cpp
//  cmtest
//
//  Created by 冯鸿辉 on 16/6/22.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "test1.hpp"
#include <iostream>
#include <iomanip>
using namespace std;

void print_figure(int row, char tag);


void test1_root(){
  
  print_figure(5,'*');
}


void print_figure(int row, char tag)    //行参数和符号参数
{
  int i;
  
  cout<<setw(row-1)<<" "<<tag<<endl;     //输出第1行
  
  for(i=2;i<row;i++)             //输出第2行到row-1行
    cout<<setw(row-i)<<" "<<tag<<setw(2*(i-1)-1)<<" "<<tag<<endl;
  
  for(i=1;i<=2*row-1;i++)
    cout<<tag;      //输出最后1行
  
  cout<<endl;
  
}
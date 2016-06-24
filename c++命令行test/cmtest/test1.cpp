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

void print_figure(int, char);


void test1_root(){
  
  print_figure(10,'*');
  


  
}


void print_figure(int row, char tag){//行参数和符号参数
  
  //输出第1行 在第五个位置输出*
  cout<<setw(row)<<tag<<endl;
  
  //输出第2行到row-1行
  for(int i=2;i<row;i++){
    int a = row-i+1;
    int b = 2*(i-1);
    cout<<setw(a)<<tag<<setw(b)<<tag<<" "<<a<<" "<<b<<endl;
  }
  
  //输出最后1行
  for(int i=1;i<=2*row-1;i++){
    cout<<tag;
  }
  
  cout<<endl;
  
  cout<<"_"<<setw(2)<<"1"<<"_"<<endl;
  printf("_%2d_",1);
}
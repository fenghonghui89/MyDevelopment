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
   int a[][3] = { { 0,1 }, { 0 } };
//  print_figure(10,'*');
  
//  double a[] = { 1.1, 3.1, 5.1, 7.1, 9.1 }, *p ;
//  int i;
//  
//  for( i = 0; i<5; i++ ) //①下标方式访问数组
//    cout << "a[" << i << "]=" << a[i] << '\t';
//  cout << endl;
//  
//  for( p = a, i = 0; i<5; i++ ) //②指针变量下标方式访问数组
//    cout << "a[" << i << "]=" << p[i] << '\t';
//  cout << endl;
//  
//  for( i = 0; i<5; i++ ) //③指针方式访问数组
//    cout << "a[" << i << "]=" << *( a+i ) << '\t';
//  cout << endl;
//  
//  for( p = a; p<a+5; p++ ) //④指针变量间址方式访问数组
//    cout << "a[" << p-a << "]=" << *p << '\t';
//  cout << endl;
//  
  
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
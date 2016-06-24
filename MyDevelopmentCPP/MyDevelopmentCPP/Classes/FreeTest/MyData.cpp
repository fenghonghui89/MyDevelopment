
//
//  MyData.cpp
//  MyDevelopmentCPP
//
//  Created by 冯鸿辉 on 16/6/24.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "MyData.hpp"
#include <iostream>
using namespace std;

Date:: Date(){ // 构造函数
  cout << "Date object initialized.\n" ;
}

Date:: ~Date(){  // 析构函数
  cout << "Date object destroyed.\n";
}

void Date:: SetDate( int y, int m, int d ){
  year = y ; month = m ; day = d ;
}

int Date::IsLeapYear(){
  return ( year%4==0 && year%100!=0 ) || ( year%400==0 ) ;
}

void Date::PrintDate(){
  cout << year << "/" << month << "/" << day << endl ;
}
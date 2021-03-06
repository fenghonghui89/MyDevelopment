//
//  MyTime.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "MyTime.hpp"
#include <stdio.h>
#include <iostream>
#include <ctime>
#include <iomanip>
using namespace std;

MyTime::MyTime(int h,int m,int s){
  
  hour = h;
  min = m;
  sec = s;
}

void MyTime::run(){
  
  for(;;){
    dida();
    show();
  }
}

void MyTime::show(){
  
  cout<<setfill('0')<<setw(2)<<hour<<":"<<setw(2)<<min<<":"<<
  setw(2)<<sec<<'\r'<<flush;
}

void MyTime::dida(){
  
  time_t t = time(NULL);
  
  while(t == time(NULL));
  
  if(++sec == 60){
    sec = 0;
    if(++min == 60){
      min = 0;
      if(++hour == 24){
        hour = 0;
      }
    }
  }
  
}
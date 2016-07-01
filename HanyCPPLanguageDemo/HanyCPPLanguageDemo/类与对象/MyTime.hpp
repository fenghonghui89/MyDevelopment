//
//  MyTime.hpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//



class MyTime{
  
  int hour;
  int min;
  int sec;
  
public:
  MyTime(int h = 0,int m = 0,int s = 0);
  void run();
  
private:
  void show();
  void dida();
  
};


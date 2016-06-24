//
//  MyData.hpp
//  MyDevelopmentCPP
//
//  Created by 冯鸿辉 on 16/6/24.
//  Copyright © 2016年 MD. All rights reserved.
//

#ifndef MyData_hpp
#define MyData_hpp

#include <stdio.h>

class Date
{
public:
  Date() ;
  ~Date() ;
  void SetDate( int y, int m, int d ) ;
  int IsLeapYear() ;
  void PrintDate() ;
  
private:
  int year, month, day ;
} ;

#endif /* MyData_hpp */

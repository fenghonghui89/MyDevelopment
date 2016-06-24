//
//  CPPFreeTest.cpp
//  MyDevelopmentCPP
//
//  Created by 冯鸿辉 on 16/6/22.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "CPPFreeTest.hpp"
#include <iostream>
#include <ctype.h>
#include "MyData.hpp"
using namespace std;



void test_root_freetest(){
  
//  Date date;
//  date.SetDate(1, 1, 1);
//  date.PrintDate();
  
  Date *datep = new Date;
  datep->SetDate(2, 2, 2);
  datep->PrintDate();
}






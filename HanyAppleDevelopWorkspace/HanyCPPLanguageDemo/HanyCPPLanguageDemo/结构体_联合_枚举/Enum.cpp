//
//  Enum.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//枚举

#include "Enum.hpp"
#include <stdio.h>
#include <iostream>
using namespace std;

#pragma mark - *********** knowledge ***********
enum Direction{
  D_UP = 88,
  D_DOWN,
  D_LEFT,
  D_RIGHT
};

static void knowledge_base(){
  
  Direction dire = D_UP;
  cout<<dire<<endl;
  
  int d = dire;
  dire = D_DOWN;
  
  cout<< d <<endl;
  cout<< dire <<endl;
  
}
#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Enum(){

}
//
//  Union.cpp
//  HanyCPPLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/1.
//  Copyright © 2016年 MD. All rights reserved.
//联合

#include "Union.hpp"
#include <stdio.h>
#include <iostream>
using namespace std;

#pragma mark - *********** knowledge ***********
static void knowledge_base(){
  
  union{
    int data;
    char mychar[4];
  };
  
  /*
   '0' 48
   'A' 65
   'a' 97
   */
  //data = 0x31323334;
  
  data = 0x41424344;
  cout<<data<<endl;
  
  for(int i=0;i<4;i++){
    cout<<mychar[i]<<" ";//从41开始读取
  }
  
  cout<<endl;
}

#pragma mark - *********** test ***********
#pragma mark - *********** root ***********
void root_Union(){

}
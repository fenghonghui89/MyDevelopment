//
//  MD_CCC_FreeTestFile.cpp
//  MyDevelopmentC
//
//  Created by 冯鸿辉 on 16/5/30.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "MD_CCC_FreeTestFile.hpp"

#include<iostream>
#include<functional>
#include<numeric>
#include<algorithm>

using namespace std;

template <typename T>
void count(T *a,size_t k,T &avg,size_t &num)
{
  accumulate(a,a + k,avg);
  avg /=k;
  num = count_if(a,a + k,bind2nd(less<T>(),avg));
}






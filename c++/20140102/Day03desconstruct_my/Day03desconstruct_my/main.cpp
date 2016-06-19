//
//  main.cpp
//  Day03desconstruct_my
//
//  Created by HanyFeng on 14-1-6.
//  Copyright (c) 2014年 Hany. All rights reserved.
//

#include <iostream>
using namespace std;

class A{
    int a;
    int* pa;//堆内存中的资源，要么等程序结束才释放，要么显式遇到delete才释放
    
public:
    A():a(100),pa(new int[10]){
        cout<<"A()"<<endl;
    }
    
    ~A(){//可以自定义析构，但调用一般是由系统自动完成的
        delete[] pa;
        cout<<"~A()"<<endl;
    }
};

int main(int argc, const char * argv[])
{
    A a;
}


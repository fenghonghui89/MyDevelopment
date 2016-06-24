#include "MyDate.h"
#include <iostream>
using namespace std;

//MyTime::函数作用域
MyDate::MyDate(int y,int m,int d){
    year = y;
    month = m;
    day = d;
}

void MyDate::show(){
    cout<<year<<"-"<<month<<"-"<<day<<endl;
}


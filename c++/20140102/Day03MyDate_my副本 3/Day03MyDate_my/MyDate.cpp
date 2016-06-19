#include "MyDate.h"
#include <iostream>
using namespace std;

MyDate::MyDate(int y,int m,int d){
    year = y;
    month = m;
    day = d;
}

void MyDate::show(){
    cout<<year<<"-"<<month<<"-"<<day<<endl;
}

void  showDate(MyDate* md);//在类中使用全局函数需要前置声明
void  MyDate::useGloableFun(){
    showDate(this);//传递自身指针
}
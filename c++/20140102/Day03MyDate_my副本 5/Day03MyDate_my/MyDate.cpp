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

MyDate MyDate::increamentDay1(){
    day++;
    cout<<"i1:"<<this<<endl;
    return  *this;
}

MyDate* MyDate::increamentDay2(){
    day++;
    cout<<"i2:"<<this<<endl;
    return  this;
}

MyDate& MyDate::increamentDay3(){
    day++;
    cout<<"i3:"<<this<<endl;
    return  *this;
}

void MyDate::increamentDay4(){
    day++;
}
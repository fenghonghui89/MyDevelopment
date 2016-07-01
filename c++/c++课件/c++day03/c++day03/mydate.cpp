#include "mydate.h"
#include <iostream>
using namespace std;
/* 需要前置声明  */
void  showDate(MyDate* md);
void  MyDate::useGloableFun(){
    showDate(this);
}
MyDate&  MyDate::increamentDay(){
    day++;
    return  *this;
}
MyDate::MyDate(int year,int m,int  d){
    this->year=year;
    month=m;
    day=d;
}
void  MyDate::show(){
    cout<<this<<"@"<<this->year<<"-"<<month<<"-"<<day<<endl;
}

#include "MyDate.h"
#include <iostream>
using namespace std;

MyDate::MyDate(int year,int m,int d){
    this->year = year;
    month = m;
    day = d;
}

void MyDate::show(){
    cout<<year<<"-"<<month<<"-"<<day<<endl;
}
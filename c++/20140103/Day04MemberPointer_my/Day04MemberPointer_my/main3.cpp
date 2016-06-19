//指向成员函数的指针

#include <iostream>
using namespace std;

struct Date{
    int  year;
    int  month;
    int  day;
    
public:
    Date(int year=2014,int month=1,int day=3){
        this->year=year;
        this->month=month;
        this->day=day;
    }
    
    int getYear(){
        return year;
    }
    
    int getMonth(){
        return month;
    }
};

int main(int argc, const char * argv[])
{
    //指向成员函数的指针
    //int ();//函数原型
    //int (*pfun)();//普通函数指针
    int (Date::*pfun)();//成员函数指针
    pfun = &Date::getYear;//给指针赋值
    
    //调用指针
    Date testdate;
    int year =  (testdate.*pfun)();
    cout<<"year="<<year<<endl;
    
    pfun = &Date::getMonth;
    int month = (testdate.*pfun)();
    cout<<"month="<<month<<endl;
    
}
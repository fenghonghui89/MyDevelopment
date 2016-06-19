//成员指针的本质

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
};

int main(int argc, const char * argv[])
{
    //查看成员指针的本质：用联合包装成员指针和一个同类型指针，输入同类型指针
    union{
        int Date::*mptr;
        int* pi;
    };
    
    mptr = &Date::month;

    cout<<"mptr:"<<mptr<<endl;
    cout<<"pi:"<<pi<<endl;
    
    cout<<"-------------------"<<endl;
    
    Date* date = new Date;
    int* mypi = (int*)date;
    
    cout<<"mypi:"<<*mypi<<endl;
    cout<<"mypi:"<<*(mypi+1)<<endl;//1、2:地址的偏移量
    cout<<"mypi:"<<*(mypi+2)<<endl;
}
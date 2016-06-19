#ifndef MYDATE_H
#define MYDATE_H

class MyDate{
    
    int year;
    int month;
    int day;
    
public:
    MyDate(int year=2014,int m=1,int d=1);
    void  show();
    
    //函数实现比较简单的话可以写在头文件中
    MyDate*  getSelfAddress(){
        return  this;
    }
};
#endif
#ifndef MYDATE_H
#define MYDATE_H
class MyDate{
    int year;
    int month;
    int day;
    
public:
    MyDate(int y=2014,int m=1,int d=1);
    void  show();
    void  useGloableFun();
    
    //写一个成员函数 每调用一次 天数就增加一天
    MyDate  increamentDay1();
    MyDate* increamentDay2();
    MyDate& increamentDay3();
    void increamentDay4();
};
#endif
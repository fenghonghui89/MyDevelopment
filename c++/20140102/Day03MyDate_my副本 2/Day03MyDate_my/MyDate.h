#ifndef MYDATE_H
#define MYDATE_H
class MyDate{
public:
    int year;
    int month;
    int day;
    
    MyDate(int year=2014,int m=1,int d=1);
    void  show();
};
#endif
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
};
#endif
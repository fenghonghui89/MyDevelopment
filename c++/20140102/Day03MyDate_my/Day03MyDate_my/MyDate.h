#ifndef MYDATE_H
#define MYDATE_H
class MyDate{
    
    int year;//定义，会分配空间
    //extern int year;//声明
    int month;
    int day;
    
public:
    MyDate(int y=2014,int m=1,int d=1);//参数的默认值只能在头文件指定
    void  show();
};
#endif
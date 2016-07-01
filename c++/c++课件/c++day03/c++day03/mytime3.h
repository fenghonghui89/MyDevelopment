#ifndef  MYTIME3_H
#define  MYTIME3_H
class  MyTime{
    int   hour;
    int   min;
    int   sec;
public:
    MyTime(int h=0,int m=0,int s=0);
    void run();
private:
    void  show();
    void  dida();
};
#endif
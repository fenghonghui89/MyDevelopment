#ifndef  MYDATE_H
#define  MYDATE_H
class MyDate{
    int   year;
    int   month;
    int   day;
public:
    MyDate(int year=2014,int m=1,int  d=1);
    void  show();
    /* 函数实现比较简单的话 可以写在头文件中 */
    MyDate*  getSelfAddress(){
        return  this;
    }
    /* 使用全局函数 void   showDate(MyDate* md)      
      需要传递一个MyDate 指针 */
    void  useGloableFun();
    /* 写一个成员函数 每调用一次 天数就增加一天 */
    MyDate&  increamentDay();
};
#endif
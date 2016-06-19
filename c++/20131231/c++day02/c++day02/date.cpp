#include <iostream>
#include <cstdio>
using namespace std;

struct  Date{
    int  year;
    int  month;
    int  day;
    
    /* 设置日期 */
    void setDate(int y=2014,int m=1,
                 int d=1){
        year=y;
        month=m;
        day=d;
    }
    
    /* 显示日期 */
    void  showDate(){
        /*cout<<year<<"-"<<month<<"-"
        <<day<<endl;*/
        printf("%04d-%02d-%02d\n",
        year,month,day);
    }
};

int  main(){
    //Date  date();错误，加括号相当于函数声明
    Date date;//栈
    date.setDate();
    date.showDate();
    
    Date* date2 = new Date;//堆
    //Date* date3 = new Date();//可以加括号
    date2->setDate(2013,12,31);
    date2->showDate();
    //→用在“以指针创建对象中”
}


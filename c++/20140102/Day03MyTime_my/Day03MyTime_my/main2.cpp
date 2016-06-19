//用class创建类、构造函数

#include <iostream>
#include <cstdio>
#include <unistd.h>
#include <ctime>
#include <iomanip>
using namespace  std;

class  MyTime{
    
    int  hour;
    int  min;
    int  sec;
    
    
public:
    MyTime(int h=0,int m=0,int s=0){//构造函数（创建对象调用，只调用一次）
        hour=h;
        min=m;
        sec=s;
    }
    
public:
    void   setMyTime(int h,int m,int s){
        hour=h;
        min=m;
        sec=s;
    }
    
private:
    void  show(){
        //方式1：
        //printf("%02d:%02d:%02d\r",hour,min,sec);//c输出
        //fflush(stdout);//刷新缓冲
        
        //方式2：
        cout<<setfill('0')<<setw(2)<<hour<<":"<<setw(2)<<min<<":"<<
        setw(2)<<sec<<'\r'<<flush;//C++输出
    }
    
    /* 走一秒 */
private:
    void   dida(){
        //sleep(1);//1.2睡眠1s
        
        time_t t=time(NULL);//2.2获取当前时间
        while(t==time(NULL));
        if(++sec==60){
            sec=0;
            if(++min==60){
                min=0;
                if(++hour==24){
                    hour=0;
                }
            }
        }
    }
    
public:
    void   run(){
        for(;;){//无限循环
            dida();
            show();
        }
    }
};

int main(int argc, const char * argv[])
{
    MyTime mt(10,20,30);
    MyTime mt2(1,2,3);
    mt.run();
}


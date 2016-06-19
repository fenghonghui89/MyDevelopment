//用struct创建类（成员都是公开的）

#include <iostream>
#include <cstdio>
#include <unistd.h>//1.1unix下的c库，非标准c
#include <ctime>//2.1标准c
#include <iomanip>//C++下的格式控制头文件
using namespace  std;

struct  MyTime{
    /* 特征 */
    int  hour;
    int  min;
    int  sec;
    
    /* 功能 */
    void   setMyTime(int h,int m,int s){
        hour=h;
        min=m;
        sec=s;
    }
    
    void  show(){
        //方式1：
        //printf("%02d:%02d:%02d\r",hour,min,sec);//c输出
        //fflush(stdout);//刷新缓冲
        
        //方式2：
        cout<<setfill('0')<<setw(2)<<hour<<":"<<setw(2)<<min<<":"<<
        setw(2)<<sec<<'\r'<<flush;//C++输出
    }
    
    /* 走一秒 */
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
    
    void   run(){
        for(;;){//无限循环
            dida();
            show();
        }
    }
};

int main(int argc, const char * argv[])
{
    MyTime mt;
    mt.setMyTime(9,59,35);
    mt.run();

}


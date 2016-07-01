#include <iostream>
#include <cstdio>
#include <unistd.h>
#include <ctime>
#include <iomanip>
using namespace  std;
class  MyTime{
    /* 特征 */
    int  hour;
    int  min;
    int  sec;
public:
    MyTime(int h=0,int m=0,int s=0){
        hour=h;
        min=m;
        sec=s;
    }
    /* 功能 */
public:
    void   setMyTime(int h,int m,int s){
        hour=h;
        min=m;
        sec=s;
    }
private:
    void  show(){
        /*printf("%02d:%02d:%02d\r",hour,
         min,sec);
         fflush(stdout);*/
        cout<<setfill('0')<<setw(2)<<hour<<":"<<setw(2)<<min<<":"<<
        setw(2)<<sec<<'\r'<<flush;
    }
    /* 走一秒 */
    void   dida(){
        //sleep(1);
        time_t t=time(NULL);
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
        for(;;){
            dida();
            show();
        }
    }
    
};

int main(){
    MyTime   mt(9,59,35);
    /* 构建第二个对象  */
    MyTime   mt2(9,59,35);
    //mt.setMyTime(9,59,35);
    mt.run();
}





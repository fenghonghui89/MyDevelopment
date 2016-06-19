//内联函数
#include <iostream>
using namespace std;

#define  MAX(x,y)  (((x)>(y))?(x):(y))//宏不关心类型

/* 写一个函数 传入两个整数参数 返回参数最大值 */
inline int   getMax(int  x,int y){
    return  x>y?x:y;
}

int main(){
    int  res=MAX(100,200);
    cout<<res<<endl;
    
    int  x=1;
    int  y=99;
    res=MAX(x,y);
    cout<<res<<endl;
    
    cout<<getMax(x,y)<<endl;
}

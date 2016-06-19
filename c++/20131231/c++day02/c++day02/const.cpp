//const 修饰
#include <iostream>
using namespace std;

int main(){
    const int  i=99;
    //i=100;     //常变量的值不能改变

    int     g=99;
    int     gg=88;
    const  int *pg=&g;
    //*pg = gg; //不能通过pg 操作对应的内存
    pg=&gg;     //但是可以改变pg的指向
    
    /* 引用和数组的 基本实现 */
    int  f=123;
    int  ff=456;
    int* const rf=&f;
    //rf=&ff;   //不能改变rf的指向
    *rf=ff;     //但是可以通过rf改变值
}


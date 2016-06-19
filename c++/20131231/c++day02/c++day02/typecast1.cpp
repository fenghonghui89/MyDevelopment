#include <iostream>
using namespace std;
int main(){
    //c++编译器检测到一个变量加const修饰，那么在以后检测到使用该变量，则直接把它替换成该变量对应的值（在编译中已经替换完毕），而不去内存中找，因此单纯想用指针修改是行不通的
    const int i = 77;
    int* pi = (int*)&i;
    *pi = 7777;
    cout<<"*pi:"<<*pi<<endl;
    cout<<"i:"<<i<<endl;
    
    //同上
    const int j = 88;
    int* pj = const_cast<int*>(&j);
    *pj = 8888;
    cout<<"*pj:"<<*pj<<endl;
    cout<<"j:"<<j<<endl;
    
    //加上volatile后则会去内存中取值
    volatile const int x = 99;//volatile不稳定的
    int* px = const_cast<int*>(&x);
    *px = 9999;
    cout<<"*px:"<<*px<<endl;
    cout<<"x:"<<x<<endl;
}
//引用的应用-函数的参数
#include <iostream>
using namespace  std;

void  myswap(int x,int y){
    cout<<"&x:"<<&x<<endl;
    cout<<"&y:"<<&y<<endl;
    int  temp=x;
    x=y;
    y=temp;
}

void  pswap(int* x,int* y){
    cout<<"x:"<<x<<endl;
    cout<<"y:"<<y<<endl;
    cout<<"&x:"<<&x<<endl;
    cout<<"&y:"<<&y<<endl;
    int  temp=*x;
    *x=*y;
    *y=temp;
    cout<<"x:"<<*x<<endl;
    cout<<"y:"<<*y<<endl;
}

void  cppswap(int& a,int& b){
    cout<<"a:"<<a<<endl;
    cout<<"b:"<<b<<endl;
    cout<<"&a:"<<&a<<endl;
    cout<<"&b:"<<&b<<endl;
    /*int   temp=a;
    a=b;
    b=temp;*/
    a=a^b;
    b=a^b;
    a=a^b;//整数交换中效率最高的写法
}
int main(){
    int   x=100;
    int   y=99;
    cout<<"&x:"<<&x<<endl;
    cout<<"&y:"<<&y<<endl;
   
//    myswap(x, y);  //值传递（复制），操作的是副本，不会影响原来的值
//    pswap(&x,&y);    //指针为参数
    cppswap(x, y); //引用为参数
    cout<<"x="<<x<<","<<"y="<<y<<endl;
    
}



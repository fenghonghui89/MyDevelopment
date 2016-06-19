//二. c++ 中的内存分配
#include <iostream>
using namespace std;
int main(){
    /* 在堆中申请一个整数大小的空间 */
    int* pi = new int;
    cout<<*pi<<endl;
    
    delete pi;
    pi=NULL;
    
    pi=new int(123);
    cout<<*pi<<endl;
    delete pi;//标记为自由状态，可以使用，不使用的话为原值
    cout<<*pi<<endl;
    
    /* 使用new[] 申请5个整数的空间 
       然后给这个空间分别赋值 9 5 2 7 0 
       然后遍历这个空间 */
    int* parr=new int[5];
    //*(parr++)=9;  动了parr的指向，移了4个字节
    //*(parr+0)=9;
    //*(parr+1)=5;
    parr[0]=9;
    parr[1]=5;
    parr[2]=2;
    parr[3]=7;
    parr[4]=0;
    for(int i=0;i<5;i++){
        cout<<parr[i]<<endl;
    }
    /* 释放parr 指向的空间 */
    delete[]  parr;
    parr = NULL;
    
    /* 在栈中申请40个字节的内存 */
    char data[40];
    cout<<"data ="<<data<<endl;
    cout<<"data ="<<(int*)data<<endl;
    int *parr2=new (data)int[10];
    cout<<"parr2="<<parr2<<endl;
}




//引用
#include <iostream>
using namespace  std;
int main(){
    //以下是错误的定义方法，引用必须初始化
    //int& rvar_i;
    //rvar_i = i;
    
    int  i=100;
    int& rvar_i=i;
    cout<<"rvar_i:"<<rvar_i<<endl;
    
    i=10001;
    cout<<"rvar_i:"<<rvar_i<<endl;
    
    int& rrvar_i=rvar_i;
    i=10;
    cout<<"rrvar_i:"<<rrvar_i<<endl;
    
    int j=200;
    rvar_i=j;//相当于赋值，并非把引用对应另外一个变量
    rvar_i=1234;//可通过改变引用的值从而改变该引用所对应的变量的值
    cout<<"j:"<<j<<endl;
    cout<<"i:"<<i<<endl;
    cout<<"rrvar_i:"<<rrvar_i<<endl;
    
    //也可以把引用的值 赋给其他变量
    int x = rrvar_i;
    cout<<"x:"<<x<<endl;
    
    //引用绑定常量必须用const，绑定后就不能指向其他常量或变量，也不能再修改引用的值，用途未知
    const int& rc=100;
}


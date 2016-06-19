//构造函数的初始化参数列表

#include <iostream>
using namespace  std;

class  A{
    
    //const int age = 100;//暂只有xcode支持最新标准
    const int  age;
    double     salary;
    
public:
    /*
     1.可以在构造函数函数调用之前执行
     2.const类型的变量或者引用类型的变量必须使用初始化参数列表
     3.普通成员变量也可以使用初始化参数列表
     4.位置是在参数列表之后，函数实现体之前，加一个冒号
     */
    
    //    A(){
    //        cout<<"A()"<<endl;
    //    }
    
    A():age(100),salary(1000){
        //age=100;   //const修饰的变量不能在这里初始化
        cout<<"A()"<<endl;
    }
};

int main(){
    A  a;
}
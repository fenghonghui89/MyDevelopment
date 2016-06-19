//继承中，构造函数与析构函数的调用
//构建子类对象时,一定先调用父类的构造函数，默认调用的是父类的无参构造。
//如果需要指定调用父类的构造函数，需要在初始化参数列表中指定

#include <iostream>
using namespace std;

class A{
public:
    A()     {cout<<"A()"<<endl;}
    A(int a){cout<<"A(int)"<<endl;}
    ~A()    {cout<<"~A()"<<endl;}
};

class B:public A{
public:
    B()          {cout<<"B()"<<endl;}
    B(int b):A(b){cout<<"B():A(b)"<<endl;}
    ~B()         {cout<<"~B()"<<endl;}
};

class C:public B{
public:
    C() {cout<<"C()"<<endl;}
    ~C(){cout<<"~C()"<<endl;}
};

int main(){
    B b;
    B b1(10);
    
    cout<<"--------------"<<endl;
    
    C c;

    cout<<"--------------"<<endl;
}
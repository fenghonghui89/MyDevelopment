//day2:数据在继承中的传递
//当子类中有和父类同名的数据时，就会把父类的数据隐藏掉.(名字隐藏)
//适用所有数据-变量、函数、静态...
//如何调用父类的数据:父类名::数据名（不是静态）

#include <iostream>
using namespace std;

class A{
public:
    int data = 100;
    void show(){
        cout<<"show() in A"<<endl;
    }
    
    static void showStatic(){
        cout<<"showStatic() in A"<<endl;
    }
    
    static int staticData;
};
int A::staticData = 1000;

class B:public A{
public:
    int data = 200;
    void show(){
        cout<<"show() in B"<<endl;
        A::show();
    }
    
    static void showStatic(){
        cout<<"showStatic() in B"<<endl;
        A::showStatic();
    }
    
    static int staticData;
};
int B::staticData = 2000;

int main(){
    //把父类的同名数据隐藏
    B b;
    b.show();
    
    cout<<"------------"<<endl;
    
    //调用父类数据
    cout<<b.data<<endl;
    cout<<b.A::data<<endl;
    
    b.show();
    b.A::show();
    
    B::showStatic();
    B::A::showStatic();
    
    cout<<"------------"<<endl;
    
    //输出静态成员变量
    cout<<B::staticData<<endl;
    cout<<A::staticData<<endl;
}
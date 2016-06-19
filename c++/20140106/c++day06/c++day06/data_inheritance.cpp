#include <iostream>
using namespace std;
class A{
public:
    int   data;
    void  show(){
        cout<<"data in A"<<endl;
    }
    static  void  showStatic(){
        cout<<"this is A static"<<endl;
    }
    static  int   staticData;
};
/* 静态成员变量 必须在类外初始化 */
int  A::staticData=1000;

class B:public A{
public:
    static  void  showStatic(){
        A::showStatic();
        cout<<"this is B static"<<endl;
    }
    static int  staticData;
    int   data=100;
    void  show(){
        A::show();
        cout<<"data in B"<<endl;
    }
};
int   B::staticData=1;
int main(){
    cout<<A::staticData<<endl;
    cout<<B::staticData<<endl;
    cout<<B::A::staticData<<endl;
    B::showStatic();
    B::A::showStatic();
    B   b;
    b.A::showStatic();
    cout<<b.data<<endl;
    cout<<b.A::data<<endl;
    b.show();
    /* 名字隐藏之后如何调用父类的 */
    b.A::show();
}



#include <iostream>
using namespace std;

class  A{
public:
    int   a;
    static int b;//静态成员变量
    
    A(){
        a=100;
    }
    
    static void   show(){//静态函数只能直接访问静态成员
        cout<<"b:"<<b<<endl;
    }
};

int  A::b=123;//静态成员变量必须在类外初始化

int  main(){
    
    cout<<A::b<<endl;
    A::show();
    
    A ta;
    cout<<ta.a<<":"<<ta.b<<endl;
    
    ta.b=456;
    cout<<A::b<<endl;
}


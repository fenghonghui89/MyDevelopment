//对象大小跟成员变量有关，跟成员函数无关
#include <iostream>
using namespace std;

class A{
};

class B{
    int a;
};

class C{
    int c;
public:
    void show(){cout<<"show"<<endl;}
};

class D{
    int d;
public:
    D(){}
    void show(){cout<<"show"<<endl;}
    void show()const{cout<<"const show"<<endl;}//编译器对const函数的函数名做了修改
};

int main(int argc, const char * argv[])
{
    cout<<sizeof(A)<<endl;//一个类大小至少为1
    cout<<sizeof(B)<<endl;
    cout<<sizeof(C)<<endl;
    
    C c;
    cout<<sizeof c<<endl;//非类型可以不加括号
    c.show();
    
    const D d1;//1.要创建const对象，必须提供无参构造函数，否则会报错（可能是编译器bug）
    //2.如果不手动提供构造函数，可以用以下方法
    //D d0;
    //const D d3 = d0;
    
    d1.show();//只会调const函数
    
    D d2;
    d2.show();//优先找非const函数，没有则找const函数
    
}


//运算符重载——添加*=
//如果成员函数和全局函数同时重载，编译器可能选择不出来
//解决办法：只写其中一个，优先写成员函数

#include <iostream>
using namespace std;

class  Fraction{
    
public:
    int x;
    int y;
    
public:
    Fraction(int x=0,int y=1):x(x),y(y){
        
    }
    
    void show(){
        cout<<x<<"/"<<y<<endl;
    }
    
    void operator*=(Fraction f2){
        cout<<"member operator*="<<endl;
        x *= f2.x;
        y *= f2.y;
    }
};

void operator*=(Fraction& f1,Fraction& f2){
    cout<<"global operator*="<<endl;
    f1.x *=  f2.x;
    f1.y *=  f2.y;
}

int main(){
    Fraction f1(1,2);
    Fraction f2(3,4);

    f1*=f2;
    f1.show();
}
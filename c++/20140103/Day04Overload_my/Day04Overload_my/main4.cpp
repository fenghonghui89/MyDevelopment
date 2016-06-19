//运算符重载——练习：添加乘法函数

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
    
    Fraction operator+(Fraction f2){
        cout<<"member operator+"<<endl;
        Fraction temp;
        temp.x = x * f2.y + y * f2.x;
        temp.y = y * f2.y;
        return temp;
    }
    
    Fraction operator*(Fraction f2){
        cout<<"member operator*"<<endl;
        Fraction temp;
        temp.x = x * f2.x;
        temp.y = y * f2.y;
        return temp;
    }
};

Fraction operator+(const Fraction& f1,const Fraction& f2){
    cout<<"global operator+"<<endl;
    Fraction  temp;
    temp.x = f1.x * f2.y + f1.y * f2.x;
    temp.y = f1.y * f2.y;
    return temp;
};

Fraction operator*(const Fraction& f1,const Fraction& f2){
    cout<<"global operator*"<<endl;
    return Fraction(f1.x * f2.x,f1.y * f2.y);
};

int main(){
    Fraction f1(1,2);
    Fraction f2(3,4);
    
    Fraction f3 = f1 + f2;
    f3.show();
    
    Fraction f4 = f1 * f2;
    f4.show();
}
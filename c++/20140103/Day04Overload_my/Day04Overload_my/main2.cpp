//运算符重载——全局函数

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
    
};

//全局函数
//Fraction add(const Fraction& f1,const Fraction& f2)
Fraction operator+(const Fraction& f1,const Fraction& f2){
    Fraction  temp;
    temp.x = f1.x * f2.y + f1.y * f2.x;
    temp.y = f1.y * f2.y;
    return temp;
};

int main(){
    Fraction f1(1,2);
    Fraction f2(3,4);
    
    //Fraction ff = add(f1,f2);
    
    Fraction f3 = operator+(f1,f2);
    f3.show();
    
    Fraction f4 = f1 + f2;
    f4.show();
}
//运算符重载——成员函数

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
    
    //成员函数
    //Fraction add(Fraction f2)
    Fraction operator+(Fraction f2){
        Fraction temp;
        temp.x = x * f2.y + y * f2.x;
        temp.y = y * f2.y;
        return temp;
    }
};

int main(){
    Fraction f1(1,2);
    Fraction f2(3,4);
    
    //Fraction f1.add(f2);
   
    Fraction f3 = f1+f2;
    f3.show();
    
    Fraction f4 = f1.operator+(f2);
    f4.show();
    
}
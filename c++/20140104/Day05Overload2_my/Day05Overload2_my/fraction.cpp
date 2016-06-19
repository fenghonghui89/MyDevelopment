//重载()-负责转换类型
//语法：operator 要转换成的类型(){ }


#include <iostream>
#include <sstream>

using namespace std;

class Fraction{
    int x;
    int y;
public:
    Fraction(int x = 0,int y = 1):x(x),y(y){
    }
    
    //把fraction类型转为double
    operator double(){
        return x/(y*1.0);
    }
    
    //把fraction类型转为string
    operator string(){
        //方法1（C）
        //char datastr[30];
        //sprintf(datastr, "%d/%d",x,y);
        //return datastr;
        
        //方法2（C++）
        stringstream datastr;
        datastr<<x;
        datastr<<"/";
        datastr<<y;
        return datastr.str();
    }
};

int main(){
    Fraction f(1,5);
    
    double d = (double)f;
    cout<<d<<endl;
    
    int i = (int)f;//因为构造函数的参数为int类型，所以不用重载函数，但最好也写一个
    cout<<i<<endl;
    
    string ds = (string)f;
    cout<<ds<<endl;
}
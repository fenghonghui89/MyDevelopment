//const函数只能调用const函数和带mutable修饰的成员变量、const函数可以被const函数和非const函数调用

#include <iostream>
using namespace std;

class D{
    mutable int d;//普通成员变量加上mutable，才能被const函数访问
    
public:
    D(){
        d = 0;
    }
    
    void show(){
        test();
        d = d+1;
        cout<<"show"<<d<<endl;
    }
    
    void show()const{//const函数只能调用const函数、被mutable修饰的成员变量
        test();
        d = d+1;
        cout<<"const show"<<d<<endl;
    }
    
    void test()const{
        //const函数可以被const函数和非const函数调用
        //没有mutable修饰的函数
    }
};

int main(int argc, const char * argv[])
{
    const D d1;
    d1.show();
    d1.show();
    
    D d2;
    d2.show();
    
}


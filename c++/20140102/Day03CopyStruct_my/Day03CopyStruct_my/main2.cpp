//初始化参数列表会区分参数和属性、不会调用拷贝构造函数的特殊情况

#include <iostream>
using namespace std;

class A{
    int a;
    int b;
    
public:
    //初始化参数列表会区分参数和属性，不用担心同名（不一定所有编译器都可以）
    A(int a=100,int b=200):a(a),b(b){
        cout<<"A()"<<endl;
    }
    
    A(const A& a){
        cout<<"copy A()"<<endl;
        this->a = a.a;
        this->b = a.b;
    }
    
    void show()const{
        cout<<a<<":"<<b<<endl;
    }
};

A getA(const A& a){
    return a;
}

A getA1(){//特殊情况——编译器优化（编译器认为既然生成两个对象，直接在里面创建（A a;），不会调用拷贝构造函数（但开发中不会这样做，一般用下面的匿名对象）
    A a;
    return a;
}

A getA2(){
    return A(1000,1);//返回构造函数——匿名对象(可以简化程序的书写，等效于getA1())
}

int main(int argc, const char * argv[])
{
    getA1().show();
    
    cout<<"------"<<endl;
    
    getA2().show();
}

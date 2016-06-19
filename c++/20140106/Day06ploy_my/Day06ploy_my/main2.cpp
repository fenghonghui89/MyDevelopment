//多态的实现原理——虚函数表

#include <iostream>
using namespace std;

class Animal{
public:
    virtual void run(){
    }
    virtual void fun(){
        cout<<"animal fun"<<endl;
    }
};

class Dog:public Animal{
public:
    virtual void fun(){
        cout<<"看家"<<endl;
    }
};

class Cat:public Animal{
public:
    virtual void fun(){
        cout<<"抓老鼠"<<endl;
    }
};

#include <cstring>//导入memcpy所在类库
int main(){
    //当一个类里面有虚函数，则该类的对象就会多出一个指针指向自己的虚函数表
    cout<<sizeof(Animal)<<endl;
    cout<<sizeof(Dog)<<endl;
    
    Animal* animal1 = new Dog();
    animal1->fun();
    
    Dog dog;
    Cat cat;
    memcpy(&dog,&cat,8);//把dog的虚函数表用cat的覆盖掉(前8个字节)
    Animal* animal2 = &dog;
    animal2->fun();
    dog.fun();//非多态调用不会通过虚函数表调用方法
}
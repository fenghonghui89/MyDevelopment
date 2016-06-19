//继承的两种语法：传统、组合
//组合从软件设计学的角度出发是比较好的设计方式

#include <iostream>
using namespace std;

class Animal{
public:
    void run(){
        cout<<"this is animal run"<<endl;
    }
};

//继承方式1：传统
class Dog:public Animal{
    
};

//继承方式2：组合
class Dog1{
private:
    Animal a;
public:
    void run(){
        a.run();
    }
};

class Cat:public Animal{
public:
    void catFun(){
        cout<<"抓老鼠"<<endl;
    }
};

int main(int argc, const char * argv[])
{
    Dog dog;
    dog.run();
   
    Dog1 dog1;
    dog1.run();
    
    Cat cat;
    cat.run();
    cat.catFun();
}


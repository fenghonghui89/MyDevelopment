//虚函数

#include <iostream>
using namespace std;

class Animal{
    string name;
    int age;
public:
    Animal(string name = "",int age = 0):name(name),age(age){}
    void show(){cout<<"show()"<<endl;}
    virtual void run() = 0;//纯虚函数
};

//子类继承抽象类，不去实现纯虚函数，则也成为抽象类（这里实现了）
class Dog:public Animal{
public:
    virtual void run(){
        cout<<"dog run()"<<endl;
    }
};

int main(int argc, const char * argv[])
{
    //Animal a;//抽象类不能实例化
    
    Dog d;
    d.show();
    
    //抽象类虽然不能实例化，但可以用指针指向子类的对象
    Animal* a = new Dog();
    a->show();
}


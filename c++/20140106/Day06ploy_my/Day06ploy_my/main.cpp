//多态-虚函数

#include <iostream>
using namespace std;

class Animal{
public:
    virtual void run(){//虚函数
        cout<<"动物跑"<<endl;
    }
};

class Dog:public Animal{
public:
    //virtual void run(){//virtual可以省略不写
    void run(){//重写父类的虚函数
        cout<<"狗用4条腿跑"<<endl;
    }
};

class Fish:public Animal{
public:
    void run(){
        cout<<"鱼在水中游泳"<<endl;
    }
};

//所有Animal的子类都可以看成是Animal对象
void show(Animal* a){
    a->run();
}

int main(int argc, const char * argv[])
{
    Animal* a1 = new Dog();
    a1->run();
    
    Animal* a2 = new Fish();
    a2->run();
    
    Animal* a3 = new Animal();
    a3->run();
    
    Dog* d1 = new Dog();
    d1->run();
    
    cout<<"------------"<<endl;
    
    Dog dog;
    show(&dog);
    Fish fish;
    show(&fish);
}


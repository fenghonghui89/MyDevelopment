#include <iostream>
using namespace std;
class Animal{
public:
    virtual void   run(){
        cout<<"动物跑"<<endl;
    }
};
class  Dog:public Animal{
public:
    void  run(){
        cout<<"狗用4条腿跑"<<endl;
    }
};
class  Fish:public Animal{
public:
    void   run(){
        cout<<"鱼在水中游"<<endl;
    }
};
/* 所有Animal 的子类都可以看成Animal 对象*/
void   show(Animal *a){
    a->run();
}
int main(){
    Dog   dogdog;
    show(&dogdog);
    Fish   fish;
    show(&fish);
    
    Animal* animal=new Dog();
    animal->run();
    Animal* a2=new Fish();
    a2->run();
    Animal* a3=new Animal();
    a3->run();
    Dog* dog=new Dog();
    dog->run();
}

#include <iostream>
using namespace std;
class Animal{
    string  name;
    int     age;
public:
    Animal(string name="",int age=0):
    name(name),age(age){
    }
    void   show(){
        cout<<"show()"<<endl;
    }
public:
    virtual  void  run()=0;
};
class  Dog:public Animal{
public:
    virtual  void  run(){
        cout<<"dog run()"<<endl;
    }
};
int main(){
    //Animal  a;
    Dog   dog;
    dog.show();
    Animal  *animal=new Dog();
    animal->show();
}




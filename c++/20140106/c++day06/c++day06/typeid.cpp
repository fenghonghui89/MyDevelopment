#include <iostream>
using namespace std;
class Animal{
public:
    virtual void   run(){}
};
class Dog:public Animal{
    int  age;
public:
    Dog(int age=0):age(age){
      
    }
    void   watchHome(){
        cout<<"看家"<<age<<endl;
    }
};
class Cat:public Animal{
public:
    void   catchMouse(){
        cout<<"抓老鼠"<<endl;
    }
};
void  show(Animal* a){
    /* 通用功能的调用 */
    a->run();
    /* 在show中把 a 的类型识别出来*/
    cout<<typeid(a).name()<<endl;
    cout<<typeid(*a).name()<<endl;
    /*if(typeid(*a)==typeid(Dog)){
        ((Dog*)a)->watchHome();
    }
    if(typeid(*a)==typeid(Cat))
    {
        ((Cat*)a)->catchMouse();
    }*/
    if(dynamic_cast<Cat*>(a)){
         ((Cat*)a)->catchMouse();
    }
    if(dynamic_cast<Dog*>(a)){
        ((Dog*)a)->watchHome();
    }
}
int main(){
    cout<<typeid(int).name()<<endl;
    cout<<typeid(int*).name()<<endl;
    cout<<typeid(Animal).name()<<endl;
    Dog   dog(100);
    show(&dog);
    Cat   cat;
    show(&cat);
}

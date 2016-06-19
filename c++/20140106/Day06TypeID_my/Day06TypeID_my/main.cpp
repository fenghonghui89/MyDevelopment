

#include <iostream>
using namespace std;

class Animal{
public:
    //void run(){}
    virtual void run(){cout<<"跑"<<endl;}//父类要有虚函数才能满足多态的前提
};

class Dog:public Animal{
    int age;
public:
    Dog(int age = 0):age(age){}
    void watchHome(){cout<<"看家"<<age<<endl;}
};

class Cat:public Animal{
public:
    void catchMouse(){cout<<"抓老鼠"<<endl;}
};

void show(Animal* a){
    //1.通用功能的调用（仅限虚函数）
    a->run();
    
    //当用到类型相关的特殊数据（Dog的age），不判断类型就强转可能会出现问题
    //((Dog*)a)->watchHome();
    
    //2.调用类的特有功能
    //方法1：在show中把a的类型识别出来，再根据类型执行不同代码（前提：多态）
    cout<<typeid(a).name()<<endl;
    cout<<typeid(*a).name()<<endl;
    if (typeid(*a)==typeid(Dog)) {
        ((Dog*)a)->watchHome();
    }
    if (typeid(*a)==typeid(Cat)) {
        ((Cat*)a)->catchMouse();
    }
    
    //方法2：用动态类型识别
    //如果转换成功返回相应的类型，如果转换失败则返回NULL
//    if(dynamic_cast<Dog*>(a)){
//        ((Dog*)a)->watchHome();
//    }
//    if(dynamic_cast<Cat*>(a)){
//        ((Cat*)a)->catchMouse();
//    }
}

int main(int argc, const char * argv[])
{
    //typeid可以输出类型名称（用name()函数）
    cout<<typeid(int).name()<<endl;
    cout<<typeid(int*).name()<<endl;
    cout<<typeid(Animal).name()<<endl;//6代表6个字母
    
    cout<<"----------"<<endl;
    
    Dog dog(10);
    show(&dog);
    
    cout<<"----------"<<endl;
    
    Cat cat;
    show(&cat);
}


//day2:继承中，子类调用父类的拷贝构造函数

#include <iostream>
using namespace std;

class Person{
public:
    string name;
    int age;
public:
    Person(){
        cout<<"Person()"<<endl;
    }
    
    Person(const Person& p){
        name = p.name;
        age = p.age;
        cout<<"Person(const Person& p)"<<endl;
    }
};

//子类不带拷贝构造
//默认调父类的拷贝构造
class EmpA:public Person{
public:
    double salary;
public:
    EmpA(){
        cout<<"EmpA()"<<endl;
    }
};

//子类带拷贝构造，但没有指定初始化参数列表
//则调用父类的构造函数
//无法复制父类的成员变量
class EmpB:public Person{
public:
    double salary;
public:
    EmpB(){
        cout<<"EmpB()"<<endl;
    }
    
    EmpB(const EmpB& e){
        salary = e.salary;
        cout<<"EmpB(const EmpB& e)"<<endl;
    }
};

//子类带拷贝构造，指定初始化参数列表
//则调用父类的拷贝构造
//可复制父类的成员变量
class EmpC:public Person{
public:
    double salary;
public:
    EmpC(){
        cout<<"EmpC()"<<endl;
    }
    
    EmpC(const EmpC& e):Person(e){
        salary = e.salary;
        cout<<"EmpC(const EmpC& e)"<<endl;
    }
};

int main(){
    
    EmpA ea;
    ea.name = "aa";
    ea.age = 11;
    ea.salary = 1.1;
    
    EmpB eb;
    eb.name = "bb";
    eb.age = 22;
    eb.salary = 2.2;
    
    EmpC ec;
    ec.name = "cc";
    ec.age = 33;
    ec.salary = 3.3;
    
    cout<<"------------"<<endl;
    
    EmpA ea1 = ea;
    cout<<ea1.name<<"-"<<ea1.age<<"-"<<ea1.salary<<endl;
    
    cout<<"------------"<<endl;
    
    EmpB eb1 = eb;
    cout<<eb1.name<<"-"<<eb1.age<<"-"<<eb1.salary<<endl;
    
    cout<<"------------"<<endl;
    
    EmpC ec1 = ec;
    cout<<ec1.name<<"-"<<ec1.age<<"-"<<ec1.salary<<endl;
    
}

//day2:继承中，赋值运算符函数的调用

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
    
    Person& operator=(const Person& p){
        cout<<"Person operator = "<<endl;
        name = p.name;
        age = p.age;
        return *this;
    }
};


class EmpA:public Person{
public:
    double salary;
public:
    EmpA(){
        cout<<"EmpA()"<<endl;
    }
    
    EmpA& operator=(const EmpA& e){
        cout<<"EmpB operator = "<<endl;
        Person::operator=(e);//子类对象可以看成是父类对象（语法不是静态）
        salary = e.salary;
        return *this;
    }
};

int main(){
    EmpA ea;
    ea.name = "aa";
    ea.age = 11;
    ea.salary = 1.1;
    
    EmpA ea1;
    
    cout<<"------------"<<endl;
    
    ea1 = ea;
    cout<<ea1.name<<"-"<<ea1.age<<"-"<<ea1.salary<<endl;
    
}

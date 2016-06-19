#include <iostream>
using namespace std;
class  Person{
    string  name;
    int     age;
public:
    Person(){
        cout<<"Person()"<<endl;
    }
    Person(const Person& p){
        cout<<"Person(const Person)"<<endl;
    }
    Person&  operator=(const Person&e){
        cout<<"Person operator="<<endl;
        return *this;
    }
};
class  Emp:public Person{
    double  salary;
public:
    Emp(){
        cout<<"Emp()"<<endl;
    }
    Emp(const Emp& e):Person(e){
        salary=e.salary;
        cout<<"Emp(const Emp)"<<endl;
    }
    Emp&  operator=(const Emp&e){
        /* 调用父类的 = */
        Person::operator=(e);
        salary=e.salary;
        cout<<"Emp operator="<<endl;
        return *this;
    }
};
int main(){
    Emp   e;
    Emp   ee;
    ee=e;
}








//虚析构函数
//当父类指针指向子类对象时，如果delete这个指针，子类析构的行为不确定。
//所以当父类型中有虚函数时，则建议把父类的析构函数修饰成虚函数。


#include <iostream>
using namespace std;

class Person{
public:
    Person(){cout<<"Person()"<<endl;}
    virtual~Person(){cout<<"~Person()"<<endl;}//把虚构修饰成虚函数，否则子类的析构可能不调用
    virtual void fun(){}
};

class Emp:public Person{
    int* parr;
public:
    Emp(){
        parr = new int[100];
        cout<<"Emp()"<<endl;
    }
    
    ~Emp(){
        delete [] parr;
        cout<<"~Emp()"<<endl;
    }
};

int main(int argc, const char * argv[])
{
    Person* person = new Emp();
    delete person;
}


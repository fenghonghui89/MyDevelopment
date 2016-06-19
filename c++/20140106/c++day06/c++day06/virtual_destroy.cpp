#include <iostream>
using namespace std;
class Person{
public:
    Person(){
        cout<<"Person()"<<endl;
    }
    virtual ~Person(){
        cout<<"~Person()"<<endl;
    }
    virtual   void  fun(){
    
    }
};
class  Emp:public  Person{
    int  *parr;
public:
    Emp(){
        parr=new int[100];
        cout<<"Emp()"<<endl;
    }
    ~Emp(){
        cout<<"~Emp()"<<endl;
        delete[] parr;
    }
};
int main(){
    Person  *person=new Emp();
    delete person;
}

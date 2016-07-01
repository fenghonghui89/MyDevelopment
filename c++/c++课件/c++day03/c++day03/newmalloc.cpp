#include <iostream>
#include <string>
#include <cstdlib>
using namespace  std;
class  Date{
    int  year;
    int  month;
    int  day;
public:
    Date(){
        cout<<"Date()"<<endl;
    }
    ~Date(){
        cout<<"~Date()"<<endl;
    }
};
class  Emp{
    string  name;
    int     age;
    Date    date;
public:
    Emp(){
        cout<<"Emp()"<<endl;
    }
    ~Emp(){
        cout<<"~Emp()"<<endl;
    }
};
int main(){
    /*Emp  *e=new Emp();
    Emp   *me=static_cast<Emp*>(malloc(sizeof(Emp)));*/
    /*Emp  *ea=new Emp[3];
    delete[]   ea;
    cout<<"app over"<<endl;*/
    Emp   *e =new Emp();
    delete e;
}



#include <iostream>
#include <string>//字符串类库
#include <cstdlib>//用malloc要导入的头文件

using namespace std;

class Date{
    int year;
    int month;
    int day;
    
public:
    Date(){
        cout<<"Date()"<<endl;
    }
    ~Date(){
        cout<<"~Date()"<<endl;
    }
};

class Emp{
    string name;
    int age;
    Date date;
public:
    Emp(){
        cout<<"Emp()"<<endl;
    }
    
    ~Emp(){
        cout<<"~Emp()"<<endl;
    }
};

int main(int argc, const char * argv[])
{
//new和malloc的区别
//    Emp* e = new Emp();//用new创建对象
//    Emp* me = static_cast<Emp*>(malloc(sizeof (Emp)));//用malloc创建对象
//    cout<<"app over"<<endl;

//delete和free的区别
    Emp* ea = new Emp[3];
    delete[] ea;
    cout<<"app over"<<endl;
    
//    Emp* ef = new Emp();
//    free(ef);//用free不会调用析构函数
//    cout<<"app over"<<endl;
}


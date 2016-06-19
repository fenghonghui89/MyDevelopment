#include <iostream>
using namespace  std;
class Animal{
public:
    virtual void   run(){
    }
    virtual void   fun(){
        cout<<"animal fun"<<endl;
    }
};
class  Dog:public Animal{
public:
    virtual void  fun(){
        cout<<"看家"<<endl;
    }
};
class  Cat:public Animal{
public:
    virtual void  fun(){
        cout<<"抓老鼠"<<endl;
    }
};
#include <cstring>
int main(){
    cout<<sizeof(Animal)<<endl;
    cout<<sizeof(Dog)<<endl;
    Dog   dog;
    Cat   cat;
    /* 把dog的虚函数表地址覆盖掉 */
    memcpy(&dog,&cat,8);
    Animal* animal=&dog;
    animal->fun();
    dog.fun();
}



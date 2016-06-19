//公开父类的私有数据

#include <iostream>
using namespace std;

class MyClass{
public:
    void showPublic(){
        cout<<"showPublic()"<<endl;
    }
    
protected:
    void showProtected(){
        cout<<"showProtected()"<<endl;
    }
    
private:
    void showPrivate(){
        cout<<"showPrivate()"<<endl;
    }

//1.先在父类中公开私有数据
public:
    void publicPrivate(){
        showPrivate();
    }
};

class A:private MyClass{
//2.再在子类中公开父类的公开方法（里面包含私有数据）
public:
    void testfun(){
        publicPrivate();
    }
};

int main(){
    A a;
    a.testfun();
}
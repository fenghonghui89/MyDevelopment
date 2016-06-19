//子类继承父类的三种方式：公开继承、保护继承、私有继承
//所谓的继承方式,就是给与子类的最大权限

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
};

//公开继承
class A:public MyClass{
public:
    void testfun(){
        cout<<"textfun"<<endl;
        showPublic();
        showProtected();
        //showPrivate();
    }
};

//保护继承
class B:protected MyClass{
public:
    void testfun(){
        cout<<"textfun"<<endl;
        showPublic();
        showProtected();
        //showPrivate();
    }
};

//私有继承
class C:private MyClass{
public:
    void testfun(){
        cout<<"textfun"<<endl;
        showPublic();
        showProtected();
        //showPrivate();
    }
};

int main(){
    A a;
    a.showPublic();
    //a.showProtected();
    //a.showPrivate();
    a.testfun();
    
    cout<<"--------------"<<endl;
    
    B b;
    //b.showPublic();
    //b.showProtected();
    //b.showPrivate();
    b.testfun();
    
    cout<<"--------------"<<endl;
    
    C c;
    //c.showPublic();
    //c.showProtected();
    //c.showPrivate();
    c.testfun();
}
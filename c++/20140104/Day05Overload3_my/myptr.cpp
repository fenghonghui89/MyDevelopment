//重载->、*
//用系统定义的和自定义的自动指针管理对象内存

#include <iostream>
using namespace std;

class A{
public:
    A(){
        cout<<"A()"<<endl;
    }
    
    ~A(){
        cout<<"~A()"<<endl;
    }
    
    void show(){
        cout<<"this is A show"<<endl;
    }
};

//自定义的自动指针
typedef A T;
class myautoptr{
    T* ptr;
    
public:
    myautoptr(T* ptr):ptr(ptr){
    
    }
    
    ~myautoptr(){
        delete ptr;
    }
    
    //重载->
    T* operator->(){
        return ptr;
    }
    
    //重载*
    T& operator*(){
        return *ptr;
    }
};

#include <memory>
int main(){
    //手动管理内存
    A* a1 = new A();
    delete a1;
    a1 = NULL;
    
    cout<<"------"<<endl;
    
    //用自定义的自动指针管理对象内存
    A* a2 = new A();
    myautoptr myptr1(a2);
    //通过重载->和*，把myptr当做指针来使用
    myptr1->show();
    (*myptr1).show();
    
    cout<<"------"<<endl;
    
    //用系统定义的自动指针管理对象内存（效果一样，内部机制比自定义的复杂）
    A* a3 = new A();
    auto_ptr<T> myptr2(a3);
}
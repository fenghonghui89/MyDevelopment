//拷贝构造函数的调用时机、引用类型前面最好加const

#include <iostream>
using namespace std;

class A{
    int a;
    int b;
    
public:
    A():a(100),b(200){
        cout<<"A()"<<endl;
    }
    
    A(const A& a){//拷贝构造函数
        cout<<"copy A()"<<endl;
        this->a = a.a;
        this->b = a.b;
    }
    
    void show()const{
        cout<<a<<":"<<b<<endl;
    }
};

void showA(A a){//调用时机2
}

//引用类型做参数可防止调用构造函数
//一般情况下当引用类型出现时，最好在前面加const，使程序兼容性更强
void showA2(const A& a){
}

A getA(const A& a){//调用时机3
    return a;
}

int main(int argc, const char * argv[])
{
    A a;
    a.show();
    
    cout<<"------------------"<<endl;
    
    A b = a;//调用时机1：用同类型对象生成对象
    b.show();
    //A b;//这种跟上面是不一样的
    //b = a;
    //b.show();
    
    cout<<"------------------"<<endl;
    
    showA(a);//调用时机2：给非引用类型的函数参数传参时
    showA2(a);//引用类型做参数可防止调用构造函数
    
    cout<<"------------------"<<endl;

    getA(a);//调用时机3：在函数中返回非引用类型的返回值时
    
    cout<<"------------------"<<endl;
    
    const A a1;
    a1.show();//const对象只能调用const函数
    showA2(a1);//该函数的参数如果不带const会报错，因为传递的参数是常对象
}


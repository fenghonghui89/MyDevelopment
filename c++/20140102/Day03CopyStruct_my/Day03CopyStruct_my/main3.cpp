//当类中有指针类型的成员或者引用类型成员时，需要自定义拷贝构造函数，以管理内存——数据独立性问题

#include <iostream>
using  namespace  std;

class  A{
    int  a;
    int  b;
    int  *pa;//1.有指针或者引用类型的成员时，会引发双释放（double free）问题（复制后两个一样的指针指向同一块内存）
    
public:
    A(int a=100,int b=200):a(a),b(a),pa(new int[5]){
        cout<<"A()"<<endl;
    }
    
    ~A(){//2.只有析构是无法完整解决双释放问题的
        cout<<"~A()"<<endl;
        delete[]  pa;
        pa=NULL;
    }
    
    void   show()const{
        cout<<a<<":"<<b<<endl;
    }

    A(const A& a){
        cout<<"copy A()"<<endl;
        this->a=a.a;
        this->b=a.b;
        
        //3.为了完整解决双释放问题，需要申请新的内存空间给新对象的指针成员
        pa=new int[5];
        for(int i=0;i<5;i++){
            pa[i]=a.pa[i];
        }
    }
    
};

int main(){
    const A a;
    a.show();
    A b=a;
}

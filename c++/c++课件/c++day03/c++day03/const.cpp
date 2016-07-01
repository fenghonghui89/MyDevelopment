#include <iostream>
using namespace  std;
class  A{
    mutable int   a;
public:
    /* 不自己提供构造函数 系统要求const对象
       必须初始化*/
     A(){
        a=0;
     }
    void   show(){
        testa();
        a=a+1;
        cout<<"show()"<<a<<endl;
    }
    void  testa()const {
        /*testa 可以被const 或者 非const
          函数调用 */
    }
    void   show()const{
        testa();
        a=a+1;
        cout<<"const show()"<<a<<endl;
    }
};
int main(){
    cout<<sizeof(A)<<endl;
    //A         ia;
    const A   a ;
    cout<<sizeof  a <<endl;
    a.show();
    a.show();
    A      b;
    b.show();
}

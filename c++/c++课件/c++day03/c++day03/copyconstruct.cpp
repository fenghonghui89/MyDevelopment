#include <iostream>
using  namespace  std;
class  A{
    int  a;
    int  b;
    int  *pa;
public:
    /* 初始化参数列表 可以区分参数和属性 */
    A(int a=100,int b=200):a(a),b(a),pa(new int[5]){
        cout<<"A()"<<endl;
    }
    ~A(){
        delete[]  pa;
        pa=NULL;
    }
    void   show()const{
        cout<<a<<":"<<b<<endl;
    }
   A(const A& a){
        cout<<"copy A(const A&)"<<endl;
        this->a=a.a;
        this->b=a.b;
        pa=new int[5];
        for(int i=0;i<5;i++){
            pa[i]=a.pa[i];
        }
    }
};
void   showA(const A&  a){
   
}
A   getA(const A&  a){
    return  a;
}
/*  编译器优化 */
A   getA2(){
    /*A  a;
    return  a;*/
    /* 使用匿名对象 可以简化程序的书写 */
    return  A(1000,1);
}
int main(){
    const A   a;
    a.show();
    A   b=a;
    /*A    b;
    a=b;
    b.show();
    cout<<"----"<<endl;
    showA(a);
    getA(a);
    cout<<"@@@@@@"<<endl;
    getA2();*/
}

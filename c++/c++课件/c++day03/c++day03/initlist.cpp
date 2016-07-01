#include <iostream>
using namespace  std;
class  A{
    const int  age;
    double     salary;
public:
    /* 处理const 类型的成员 或者引用成员
       当然普通成员肯定也是没问题 */
    A():age(100),salary(1000){
        //age=100;
        cout<<"A()"<<endl;
    }
};
int main(){
    A  a;
}
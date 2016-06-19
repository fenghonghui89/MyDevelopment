/*4.5  命名空间的数据 可以声明 和实现分离
 这样 可以检查到 语法错误。 */
//4.6.1 在数据前加命名空间名::（::作用域运算符）（第一种方法）
#include <iostream>
using namespace std;
namespace IBM{
    int   age=50;
    void  show(){
        cout<<"this is ibm age is "<<age<<endl;
    }
}
namespace tarena{
    int   age=12;
    void  show();
}
namespace tarena {
//    extern int age;//属于定义，可以注释掉
    void   show(){
        cout<<"this is tarena age is "<<age<<endl;
    }
}
int main()
{
    IBM::age=52;
    IBM::show();
    tarena::show();
    tarena::age++;
    tarena::show();
}


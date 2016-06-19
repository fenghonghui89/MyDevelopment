/*
 4.6.3 使用using  声明（第三种）
 using  空间::数据;
 如果产生冲突 使用第一种解决方案
 */
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
    void   show(){
        cout<<"this is tarena age is "<<age<<endl;
    }
}
//xcode下运行同时使用两个不同的命名空间中的函数，但变量不能同时使用
//不同编译器忍耐度不用，一般编译器两种都不允许
using IBM::show;
using tarena::show;
using IBM::age;
//using tarena::age;//会报错
int main()
{
    IBM::age=12;
   IBM::show();
   tarena::show();

}
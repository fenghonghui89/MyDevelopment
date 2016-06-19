/*
 4.6.2 使用using  namespace 空间名;（第二种方法）
 可以简化调用  但是不要产生调用冲突
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
using    namespace IBM;
using    namespace tarena;
int main()
{
    IBM::age=52;
    IBM::show();
    tarena::show();
}
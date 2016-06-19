/*
 4.7  无名命名空间
 不属于任何一个有名字 命名空间的数据
 可以认为放在无名命名空间中
 命名空间名::数据;
 ::数据;
*/
#include <iostream>
using namespace  std;

int   age=100;

namespace {
    void  show(){
        cout<<"this is noname namespace"<<endl;
    }
}

int main(){
    show();
    cout<<age<<endl;
    
    ::show();//比较规范
    cout<<::age<<endl;
}
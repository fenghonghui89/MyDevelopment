// c++中的函数 和 c 细节上的不同
#include <iostream>
using namespace  std;

int testfun();

int main(){
    testfun();
}

int testfun(){
    cout<<"hello world"<<endl;
    /*有些编译器 检查不出 不写return */
    return  100;
}
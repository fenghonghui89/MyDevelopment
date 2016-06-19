//函数模板--类型更加抽象

#include <iostream>
using namespace std;

template <typename T>
T add(T x,T y){
    return x+y;
}

template <typename T>
T maxXY(T x,T y){
    return x>y?x:y;
}


int main(int argc, const char * argv[])
{
    cout<<add(1, 2)<<endl;
    cout<<add(1.5, 3.8)<<endl;
    cout<<maxXY(3, 4)<<endl;
}


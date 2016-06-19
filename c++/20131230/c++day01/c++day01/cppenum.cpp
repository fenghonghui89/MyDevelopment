//c++中的枚举
#include <iostream>
using  namespace std;

enum   Direction{D_UP=88,D_DOWN,D_LEFT,
    D_RIGHT};

int main(){
    
    Direction dire = D_UP;
    cout<<dire<<endl;
    
    int d = dire;
    dire=D_DOWN;
    
    cout<< d <<endl;
    cout<< dire <<endl;
    
    /* 整数赋给枚举变量不允许 这里体现了
     c++ 类型检查严格 */
    //dire = d;
    
}

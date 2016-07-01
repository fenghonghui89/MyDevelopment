#include <iostream>
using namespace std;
class  A{
public:
    int   a;
    static int   b;
    A(){
        a=100;
    }
    static void   show(){
        cout<<":"<<b<<endl;
    }
};
int   A::b=123;
int  main(){
    /*静态成员最大的特点是不需要对象就可以调用
      只需要类型就可以 */
    A::show();
    cout<<A::b<<endl;
    A  ta;
    cout<<ta.a<<":"<<ta.b<<endl;
    ta.b=456;
    cout<<A::b<<endl;
}

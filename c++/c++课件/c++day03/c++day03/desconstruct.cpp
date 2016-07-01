#include <iostream>
using namespace  std;
class  A{
    int   a;
    int   *pa;
public:
    A():a(100),pa(new int[10]){
        cout<<"A()"<<endl;
    }
    ~A(){
        delete[]  pa;
        cout<<"~A()"<<endl;
    }
};
int main(){
    A  a;
    
}
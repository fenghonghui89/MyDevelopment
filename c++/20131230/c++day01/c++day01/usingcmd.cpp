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
    // extern int    age;
    void   show(){
        cout<<"this is tarena age is "<<age<<endl;
    }
}
using     IBM::show;
using     tarena::show;
using     IBM::age;
//using     tarena::age;
int main()
{
    IBM::show();
    tarena::show();
}

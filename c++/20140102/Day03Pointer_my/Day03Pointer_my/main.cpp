#include <iostream>
using namespace std;

class Human{
public:
    int age;
    int* p;
    
    Human(int age = 0){
        cout<<"init"<<endl;
        this->age = age;
        p = new int[5];
    }
    
    Human(const Human& human){
        cout<<"copy"<<endl;
        this->age = human.age;
        this->p = new int[5];
        for (int i = 0; i<5; i++) {
            this->p[i] = human.p[i];
        }
    }
};

int main(int argc, const char * argv[])
{
    Human human(10);
    cout<<human.p<<endl;//指针变量的值，指向堆（低地址，如0x100103ac0）
    cout<<&(human.p)<<endl;//指针变量的地址，指向栈（高地址，如0x7fff5fbff868）
    
    Human human1 = human;
    cout<<human1.p<<endl;
    cout<<&(human1.p)<<endl;
}


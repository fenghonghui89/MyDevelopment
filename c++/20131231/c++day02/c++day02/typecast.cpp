#include <iostream>
using namespace  std;

int main(){
    int   i=100;
    int*  pi=&i;
    void* vp=pi;
    
    pi=static_cast<int*>(vp);
}
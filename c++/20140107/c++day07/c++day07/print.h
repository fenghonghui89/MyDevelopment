#ifndef  PRINT_H
#define  PRINT_H
#include <iostream>
using namespace std;
template  <typename  T >
void   print(T a ,T  b ){
    while(a!=b){
        cout<<*a++<<" ";
    }
    cout<<endl;
}
#endif
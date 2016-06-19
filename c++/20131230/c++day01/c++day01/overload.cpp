// 九 c++ 中的函数重载
#include <iostream>
using namespace std;

/* __Z3addii  _add （汇编代码）*/
int add(int  x,int  y){
    cout<<"add(int ,int )"<<endl;
    return  x+y;
}

/*  __Z3addid */
double add(int x,double y){
    cout<<"add(int,double )"<<endl;
    return  x+y;
}

extern "C" double add(double  x,double y){
    cout<<"add(double,double )"<<endl;
    return  x+y;
}

int  main(){
    int  x=1;
    int  y=9526;
    cout<< add(x,y) <<endl;
    double z=2.0;
    cout<< add(y,z) << endl;
    cout<< add(1.0,2.0)<<endl;
}
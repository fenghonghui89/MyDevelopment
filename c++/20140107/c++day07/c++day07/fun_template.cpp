#include  <iostream>
using namespace std;
/*
int   (*pfun)(int  x,int y); 
int   add(int  x,int y){
    return  x+y;
}
double   add(double  x,double y){
    return  x+y;
}
typedef  int  T;
T  add(T x,T y){
    return  x+y;
}*/
/* 函数模板 */
template <typename T>
T  add(T x,T y){
    return  x+y;
}
/* 求两个int  或者 double 的最大数 
   写一个函数模板 */
template <typename T>
T    Max(T  x,T  y){
    return   x>y?x:y;
}

int main(){
    /* int 型模板函数 */
    cout<<add(1,9526)<<endl;
    /* double 型模板函数 */
    cout<<add(1.5,9.58)<<endl;
    cout<<Max(1,100)<<endl;
    cout<<Max(1.2,3.4)<<endl;
    cout<<Max('a','c')<<endl;
}
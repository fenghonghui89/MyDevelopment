//引用的应用-函数的返回值
#include <iostream>
using namespace  std;


int   getmax(const int x,int y){
    //x = x+1;//const 修饰非引用类型的参数 是希望函数内部不修改参数的值。
    return  x>y?x:y;
}

//返回引用类型 一般是要把 函数的返回值 作为左值
int&   getmaxref(int& x,int& y){
    cout<<"getmaxref:"<<"x:"<<x<<" "<<"y:"<<y<<endl;
    return  x>y?x:y;
}

void   printInt(const int& val){//形参必须加const才能传常数
    cout<<"printInt:"<<val<<endl;
}

int&   getInt(){
    static int   data=1001;//没有static则警告，因为函数调用完，栈中的局部变量就会释放
    return  data;
}

int main(){
    int  x=100;
    int  y=20;
    cout<<"x:"<<x<<" "<<"y:"<<y<<endl;
    //getmax(x,y)=1;//函数返回值 只能作为右值 作为左值行为不确定
    getmaxref(x,y)=1;
    cout<<"x:"<<x<<" "<<"y:"<<y<<endl;
    cout<<"getmaxref(x,y):"<<getmaxref(x,y)<<endl;
    cout<<"x:"<<x<<" "<<"y:"<<y<<endl;
    
    x = 88;
    printInt(x);
    printInt(100);//形参必须加const才能传常数
    
    cout<<"getInt():"<<getInt()<<endl;
    int z = getInt() = 200;
    cout<<"z:"<<z<<endl;
    cout<<"getInt():"<<getInt()<<endl;
}


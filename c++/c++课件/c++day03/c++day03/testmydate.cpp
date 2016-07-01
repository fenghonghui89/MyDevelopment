#include "mydate.h"
#include <iostream>
using namespace std;
void   showDate(MyDate* md){
    md->show();
}
int main(){
    MyDate  md(2014,1,2);
    md.increamentDay().increamentDay().increamentDay();
    md.show();
    md.useGloableFun();
    /*
    cout<<&md<<endl;
    cout<<md.getSelfAddress()<<endl;
    md.show();
    MyDate  md2(2014,1,3);
    cout<<&md2<<endl;
    md2.show();*/
}
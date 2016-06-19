//参数的默认值、哑元

#include <iostream>
using namespace std;

int   add(int  x=1,int y=2,int z=3){
    return  x+y+z;
}

int main(){
    cout<<add(1,2,3)<<endl;
    cout<<add()<<endl;
    cout<<add(100)<<endl;
}
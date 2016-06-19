#include <iostream>
#include <list>
#include "print.h"
using namespace std;
bool  cmp(int  x,int  y){
    return  x>y;
}
int main(){
    list<int>  datas;
    datas.push_back(9);
    datas.push_back(5);
    datas.push_back(2);
    datas.push_back(7);
    //sort(datas.begin() , datas.end());
    //datas.sort(greater<int>());
    datas.sort(cmp);
    print(datas.begin(), datas.end());
}

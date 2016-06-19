#include <iostream>
#include <set>
#include <map>
#include "print.h"
using  namespace  std;
int  main(){
    set<int>   datas;
    datas.insert(100);
    datas.insert(200);
    datas.insert(99);
    datas.insert(100);
    datas.insert(123);
    cout<<datas.size()<<endl;
    cout<<*datas.begin()<<endl;
    cout<<"--------"<<endl;
    print(datas.begin(), datas.end());
    map<int,string>  mymap;
    mymap[1]="test";
    mymap[2]="test2";
    mymap.insert(make_pair(3,"test3"));
    cout<<mymap[1]<<endl;
    cout<<mymap.begin()->first<<endl;
    cout<<mymap.begin()->second<<endl;
}

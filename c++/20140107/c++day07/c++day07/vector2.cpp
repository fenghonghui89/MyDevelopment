/* 建立一个vector 对象  里面放string 
   加入数据 one  world  dream  hello 
   使用迭代器 遍历这些数据 */
#include <iostream>
#include <vector>
using namespace std;
int main(){
    vector<string>  data;
    data.push_back("one");
    data.push_back("world");
    data.push_back("dream");
    data.push_back("hello");
    data.push_back("dream");
    /* 使用迭代器 */
    vector<string>::iterator  it;
    it=data.begin();
    while(it!=data.end()){
        if(*it=="dream"){
            /* 使用迭代器删除数据 */
            data.erase(it);
            break;
        }
        //cout<<*it<<" ";
        it++;
    }
    cout<<endl;
    it=data.begin();
    while(it!=data.end()){
        cout<<*it++<<" ";
    }
    cout<<endl;
}


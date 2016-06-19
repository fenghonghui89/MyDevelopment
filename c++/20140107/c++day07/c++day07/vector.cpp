#include <iostream>
#include <vector>
using namespace std;
template <typename T>
void   printVector(T a,T b){
    while(a!=b){
        cout<<*a++<<" ";
    }
    cout<<endl;
}
int main(){
    vector<int>   myvc;
    myvc.push_back(100);
    myvc.push_back(300);
    myvc.push_back(500);
    for(int i=0;i<myvc.size();i++){
        cout<<myvc[i]<<" ";
    }
    cout<<endl;
    /* 使用迭代器 实现对容器的遍历 */
    /* begin() 获得指向第一个元素的迭代器 
       迭代器是一个类型 这个类型重载了*号
       运算符 用来获得指向的数据 */
    cout<<*myvc.begin()<<endl;
    /* end() 获得指向最后一个元素后面位置
       的迭代器 */
    cout<<*myvc.end()<<endl;
    /* 迭代器重载了 ++  和 != 运算符 */
    cout<<*(++myvc.begin())<<endl;
    /* 如何知道迭代器到了最后 */
    printVector(myvc.begin(), myvc.end());
}


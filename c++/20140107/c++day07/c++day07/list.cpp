#include <iostream>
#include <list>
using namespace std;
/* begin() 指向第一个元素的迭代器
   ++      根据上一个元素的迭代器信息 得到
           下一个元素对应的迭代器 
   end()   最后一个元素后面的迭代器 */
template<typename T>
void   print(T a,T  b){
    while(a!=b){
        cout<< *a++ <<" ";
    }
    cout<<endl;
}
int main(){
   /* 构建链表对象 */
    list<int>  data;
   /* 在链表尾部增加数据 */
    data.push_back(9);
    data.push_back(5);
    data.push_back(2);
    data.push_back(7);
   /* 使用迭代器访问链表的数据 */
    print(data.begin(),data.end());
   /* 迭代器对应的类型 是一个内部类型 */
    list<int>::iterator  it;
    it=data.begin();
    /*cout<<*it++<<endl;
    cout<<*it<<endl;*/
    while(it!=data.end()){
        cout<<*it++<<" ";
    }
    cout<<endl;
}

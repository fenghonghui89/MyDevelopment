#include <iostream>
using namespace std;
//typedef  int  T;
//typedef  double T;
template <typename T>
class  MyArray{
    T*  data; //根据T的不同存储不同类型的数据
    int   capacity;
    int   size;
    void   expend(){
        capacity=capacity*2+1;
        T* temp=new T[capacity];
        /*复制原来的数据 */
        for(int i=0;i<size;i++){
            temp[i]=data[i];
        }
        delete[] data;
        data=temp;
    }
public:
    MyArray(int capacity=5):capacity(capacity),size(0){
        /* 动态申请存储数据的内存 */
        data=new T[capacity];
    }
    ~MyArray(){
        if(data){
            delete[] data;
            data=NULL;
        }
    }
    MyArray(const MyArray& ma){
        size=ma.size;
        capacity=ma.capacity;
        data=new T[capacity];
        for(int i=0;i<size;i++){
            data[i]=ma.data[i];
        }
    }
    /* 赋值运算符 */
    
    /* 得到元素个数 */
    int   masize(){
        return  size;
    }
    /* 通过下标得到数据  [] */
    T&   operator[](int ind){
        return data[ind];
    }
    /* 给数组 赋值的函数 */
    void   push_back(const T&  t){
        /*如果数据空间不足 则扩容 */
        if(size==capacity){
            expend();
        }
        data[size++]=t;
    }
};

int main(){
    MyArray<int>     ma;
    MyArray<double>  ma2;
    MyArray<string>  ma3;
    cout<<typeid(ma).name()<<endl;
    cout<<typeid(ma2).name()<<endl;
    cout<<typeid(ma3).name()<<endl;
    ma.push_back(100);
    ma.push_back(300);
    ma.push_back(500);
    for(int i=0;i<ma.masize();i++){
        cout<<ma[i]<<" ";
    }
    cout<<endl;
}
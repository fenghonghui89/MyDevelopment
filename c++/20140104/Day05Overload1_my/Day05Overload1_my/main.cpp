//数组扩容、放入数据、重载[]
//如果内存越界，则使程序崩溃
//用try catch 运行并捕获问题

#include <iostream>
using namespace std;

typedef int T;

class Array{
    T* data;//真正存储数据的地方
    int size;//元素个数
    int capacity;//容量
    
    //扩容
    void expend(){
        //扩大容量并申请新的空间
        capacity = capacity*2 + 1;
        T* temp = new T[capacity];
        //复制原来的数据到新空间
        for(int i = 0;i<size;i++){
            temp[i] = data[i];
        }
        //释放旧空间，把旧指针指向新空间
        delete [] data;
        data = temp;
    }
    
public:
    Array(int capacity = 5):size(0),capacity(capacity){
        data = new T[capacity];
    }
    
    //放入数据
    void push_back(T d){
        if(size == capacity){//如果容量满了就扩容
            expend();
        }
        data[size++] = d;
    }
    
    //重载[]
    T operator[](int index){
        if(index >= size){//如果内存越界，则使程序崩溃
            throw "out of range";
        }
        return data[index];
    }
};

int main(int argc, const char * argv[])
{
    Array arr;
    arr.push_back(100);
    arr.push_back(200);
    
    //用try catch 运行并捕获问题
    try{
        cout<<arr[0]<<endl;
        cout<<arr[1]<<endl;
        cout<<arr[1000]<<endl;
    }catch(const char* e){
        cout<<e<<endl;
    }
}


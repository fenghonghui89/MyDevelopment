//重载=
//析构、拷贝构造

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
    
    //构造
    Array(int capacity = 5):size(0),capacity(capacity){
        cout<<"构造"<<endl;
        data = new T[capacity];
    }
    
    //放入数据
    void push_back(T d){
        cout<<"放入数据"<<endl;
        if(size == capacity){//如果容量满了就扩容
            expend();
        }
        data[size++] = d;
    }
    
    //重载[]
    T operator[](int index){
        cout<<"重载[]"<<endl;
        if(index >= size){//如果内存越界，使程序崩溃
            throw "out of range";
        }
        return data[index];
    }
    
    //重载=
    Array& operator=(const Array& a){
        cout<<"重载="<<endl;
        if(this == &a){//防止自己赋值给自己
            return *this;
        }
        size = a.size;
        capacity = a.capacity;
        delete [] data;//释放旧空间
        data = new T[capacity];
        for (int i = 0; i<size; i++) {//逐字节复制
            data[i] = a.data[i];
        }
        return *this;
    }
    
    //析构
    ~Array(){
        cout<<"析构"<<endl;
        delete[] data;
    }
    
    //拷贝构造
    Array(const Array& arr){
        cout<<"拷贝"<<endl;
//        delete[] data;
        size = arr.size;
        capacity = arr.capacity;
        data = new T[capacity];
        for (int i = 0; i<size; i++) {
            data[i] = arr.data[i];
        }
    }
};

int main(int argc, const char * argv[])
{
    Array arr;
    arr.push_back(100);
    arr.push_back(200);
    cout<<&arr<<endl;
    cout<<arr[0]<<endl;
    cout<<arr[1]<<endl;
    
    cout<<"-----------"<<endl;
    
    Array arr1 = arr;
    cout<<&arr1<<endl;
    cout<<arr1[0]<<endl;
    cout<<arr1[1]<<endl;
    
    cout<<"-----------"<<endl;
    
    Array arr2;
    arr2.push_back(300);
    arr2.push_back(400);
    arr2 = arr1;
    cout<<&arr2<<endl;
    cout<<arr2[0]<<endl;
    cout<<arr2[1]<<endl;
}


#include <iostream>
using namespace std;

template <typename T>
class MyArray{
    T* data;//根据T的不同存储不同类型的数据
    int capacity;
    int size;
    
public:
    MyArray(int capacity = 0):capacity(capacity),size(0){
        data = new T[capacity];
    }
    
    ~MyArray(){
        if (data) {
            delete[] data;
            data = NULL;
        }
    }
    
    MyArray(const MyArray& ma){
        size = ma.size;
        capacity = ma.capacity;
        data = new T[capacity];
        for (int i = 0; i<size; i++) {
            data[i] = ma.data[i];
        }
    }
    
    //赋值运算符(未写)
    
    //得到元素个数
    int masize(){
        return size;
    }
    
    //通过下标得到数据 重载[]
    T& operator[](int ind){
        return data[ind];
    }
    
    //扩容
    void expend(){
        capacity = capacity*2+1;
        T* temp = new T(capacity);
        for (int i = 0; i<size; i++) {
            temp[i] = data[i];
        }
        delete[] data;
        data = temp;
    }
    
    //给数组赋值的函数
    void push_back(T& t){
        if (size == capacity) {//如果数据空间不足，则扩容
            expend();
        }
        data[size++] = t;
    }
};

int main(){
    //MyArray ma;
    MyArray<int> ma;
    MyArray<double> ma2;
    
}
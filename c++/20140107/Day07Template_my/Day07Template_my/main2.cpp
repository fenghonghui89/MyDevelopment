//打印一个数组（需要传数组元素个数）

//类型原则：把名字去掉，剩下的就是类型
/*
 int add(int x,int y);
 类型：int(int x,int y);
 成员函数指针：int (*pfun)(int x, int y);
 */

#include <iostream>
using namespace std;

template <typename T>
void showArr(T* data,int size){
    for (int i=0; i<size; i++) {
        cout<<data[i]<<" ";
    }
    cout<<endl;
}

int main(){
    int data[5] = {9,5,2,7,0};//int data[5]的类型是int [5]
    showArr(data, 5);
    
    double data1[5] = {9.9,2.2,5.5};
    showArr(data1, 3);
}
//用冒泡算法给数组排序

#include <iostream>
using namespace std;

template <typename T>
void showArr(T& data){
    cout<<"size:"<<sizeof(data)<<endl;
    for (int i=0; i<sizeof(data)/sizeof(data[0]); i++) {
        cout<<data[i]<<" ";
    }
    cout<<endl;
}

//排序：冒泡算法
template <typename T>
void mysort(T* data,int size){
    for (int i = 0; i < size; i++) {//找n次最大数
        for (int j = 0; j < size-1-i; j++) {//比较相邻的元素，如果大就交换
            if (data[j]>data[j+1]) {
                swap(data[j], data[j+1]);
            }
        }
    }
}

int main(){
    int data[5] = {9,5,2,7,0};
    mysort(data,5);
    showArr(data);
    
    double data1[5] = {9.9,2.2,5.5,1.4,2.8};
    mysort(data1,5);
    showArr(data1);
}
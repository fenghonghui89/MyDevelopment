//打印一个数组（不需要传数组元素个数）
//思路：传类型的引用

#include <iostream>
using namespace std;

template <typename T>
void showArr(T& data){//传数组的引用
    cout<<"size:"<<sizeof(data)<<endl;
    for (int i=0; i<sizeof(data)/sizeof(data[0]); i++) {
        cout<<data[i]<<" ";
    }
    cout<<endl;
}

int main(){
    int data[5] = {9,5,2,7,0};
    showArr(data);
    
    double data1[5] = {9.9,2.2,5.5,1.4,2.8};
    showArr(data1);
}
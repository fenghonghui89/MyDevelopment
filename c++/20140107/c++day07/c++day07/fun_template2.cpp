/* 写一个打印数组的函数 */
#include <iostream>
using  namespace std;
template<typename  T>
void  showArr(T* data,int size){
    cout<<"T* size="<<sizeof data<<endl;
    for(int i=0;i<size;i++){
        cout<<data[i]<<" ";
    }
    cout<<endl;
}
/* 能不能不传 数组的大小 */
template<typename  T>
void  showArr(T& data){
    cout<<"T* size="<<sizeof data<<endl;
    for(int i=0;i<sizeof(data)/sizeof(data[0]);i++){
        cout<<data[i]<<" ";
    }
    cout<<endl;
}
template <typename T>
void  mysort(T* data,int size){
    /* 找n次最大数 */
    for(int i=0;i<size;i++){
        /*比较相邻的元素 如果大于就交换 */
        for(int j=0;j<size-1-i;j++){
            if(data[j]>data[j+1]){
                swap(data[j],data[j+1]);
            }
        }
    }
}
int main(){
    int  data[5]={9,5,2,7,0};
    cout<<sizeof(data)<<endl;
    mysort(data, 5);
    showArr(data);
    double data2[5]={1.36,3.3,5.5,7.8,6.6};
    mysort(data2, 5);
    showArr(data2);
}

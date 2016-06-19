//昨天作业
#include <iostream>
using namespace  std;

void printArr(int *data,int size=5,bool flag=true){
    if(flag){cout<<"[";}
    for(int i=0;i<size-1;i++){
        cout<<i<<"-"<<data[i]<<",";
    }
    cout<<data[size-1]<<(flag?"]":"")
    <<endl;
}

int main(){
    int data[5]={9,5,2,7,0};
    printArr(data);
    int data2[10]={1,2,3,4,5,0,9,8,7,6};
    printArr(data2);
    printArr(data2,10,false);
    
}

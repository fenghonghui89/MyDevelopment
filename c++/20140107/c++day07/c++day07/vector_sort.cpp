#include <algorithm>
#include <vector>
#include "print.h"
#include <ctime>
using namespace std;
bool   cmp(int a,int  b){
    return  a>b;
}
/* 提供函数对象 */
class  RadomNumberObject{
public:
    int   operator()(int ind){
        return  rand()%ind;
    }
};
void   printData(int data){
    cout<<data+5<<" ";
}
int main(){
    srand((unsigned int)time(NULL));
    vector<int>   datas;
    datas.push_back(9);
    datas.push_back(5);
    datas.push_back(2);
    datas.push_back(7);
    print(datas.begin(), datas.end());
    //sort(datas.begin(),datas.end(),cmp);
    sort(datas.begin(),datas.end(),
         greater<int>());
    print(datas.begin(), datas.end());
    random_shuffle(datas.begin(),datas.end(),RadomNumberObject());
    print(datas.begin(), datas.end());
    for_each(datas.begin(),datas.end(),
             printData);
    cout<<endl;
}
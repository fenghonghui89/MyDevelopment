//5.2 c++中的联合（联合：共用内存）
#include <iostream>
using namespace  std;

int  main(){
    
    /* 这是c++支持的匿名联合 */
    union{
        int  data;
        char mychar[4];
    };
    
    /* '0' 48
       'A' 65 
       'a' 97 */
    //data=0x31323334;
    
    data=0x41424344;
    cout<<data<<endl;
    for(int i=0;i<4;i++){
        cout<<mychar[i]<<" ";//从41开始读取
    }
    cout<<endl;
}

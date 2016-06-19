//单例模式
#include <iostream>
using namespace std;

class   Director{
    
private:
    Director(){}//构造函数
    Director(const Director& d){}//拷贝构造函数
    static  Director  dire;//静态成员变量
    
public:
    static Director&   getInstance(){//静态函数
        return  dire;
    }
};

Director Director::dire;//静态成员变量必须在类外初始化

int  main(){
    //构造函数和拷贝构造函数都被private，所以以下创建对象的方法无法实现
    //Director d;
    //Director d1=Director::getInstance();
    
    Director& d1=Director::getInstance();
    Director& d2=Director::getInstance();
    cout<<&d1<<endl;
    cout<<&d2<<endl;
}
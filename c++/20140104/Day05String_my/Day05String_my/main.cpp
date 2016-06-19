//c++的字符串（可查文档）

#include <iostream>
#include <string>
using namespace std;

int main(int argc, const char * argv[])
{
    string a;
    string b("hello");
    string c("hello");
    
    //文档显示重载了=、==
    a = b;
    if (a == b) {
        cout<<"a is equal to b"<<endl;
    }
    
    if (a == c) {
        cout<<"a is equal to c"<<endl;
    }
    
    cout<<c<<endl;
    c = c + " world";
    c += " hello";//文档无显示，但能用
    cout<<c<<endl;
    
    //对字符串直接赋值
    c= "one world one dream";
    
    //c++字符串转换成c字符串
    const char* cstr = c.c_str();
    cout<<cstr<<endl;
    
    //显示对应下标的字符
    cout<<c.at(0)<<endl;
    cout<<c[0]<<endl;
    
    //捕获错误（这里是越界）
    try {
        cout<<c.at(100)<<endl;
        cout<<c[100]<<endl;
    } catch (...) {//...代表未知错误
        cout<<"访问出错 检查下标"<<endl;
    }
    
    //输出字符串长度
    cout<<c.length()<<endl;
    
}


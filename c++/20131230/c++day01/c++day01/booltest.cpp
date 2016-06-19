//c++ 中的bool 类型、运算符替换
%:include <iostream>
using namespace std;
int main()<%
    bool flag;
    flag = false;
    flag = "abc";
    if(flag){
        cout<<"flag is true "<<flag<<endl;
    %>
}
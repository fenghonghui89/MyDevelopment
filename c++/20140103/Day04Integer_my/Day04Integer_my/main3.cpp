//友元函数——输入输出运算符重载——修改cout，使其可以输出对象信息，且可以连续输出

#include <iostream>
using namespace std;

class Integer{
    int val;
    
public:
    Integer(int val = 0):val(val){
    }
    
    void show(){
        cout<<"val = "<<val<<endl;
    }
    
    friend Integer operator+(Integer a,Integer b);
    friend ostream& operator<<(ostream& os,const Integer& i);
};

Integer operator+(Integer a,Integer b){
    return Integer(a.val + b.val);
}

//返回ostream&，使其可以连续输出
ostream& operator<<(ostream& os,const Integer& i){
    return os<<i.val<<endl;
};

int main(){
    
    Integer a(1);
    Integer b(2);
    Integer c = a + b;
    
    cout<<c;
    cout<<(a+b);
    
    //连续输出
    cout<<(a+b)<<endl;
    cout<<(a+b)<<c;
}




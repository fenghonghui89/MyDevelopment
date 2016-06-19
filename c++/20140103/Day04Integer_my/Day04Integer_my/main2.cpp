//友元函数——输入输出运算符重载——修改cout，使其可以输出对象信息

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
    friend void operator<<(ostream& os,const Integer& i);
};

Integer operator+(Integer a,Integer b){
    return Integer(a.val + b.val);
}

//cout是ostream类的对象，不能添加成员函数到该类，不能复制，不能加const修饰

/* cout  ostream  c Integer
 ostream   operator<<(Integer c)
 operator<<(ostream& os,Integer c);
 */

void operator<<(ostream& os,const Integer& i){
    os<<i.val<<endl;
};

int main(){
    Integer a(1);
    Integer b(2);
    Integer c = a + b;
    
    //cout<<c 其实就是cout对象调用<<函数，参数是c
    cout<<c;
    cout<<(a+b);//表达式的值是一个临时值，编译器会给临时值加const保护，所以函数的参数要加const修饰
    
    //只能输出一个对象，不能连续输出
    //cout<<(a+b)<<endl;
    //cout<<(a+b)<<c;
}




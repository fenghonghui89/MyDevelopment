//友元函数——输入输出运算符重载——修改cin，使其可以输入对象信息

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
    friend istream& operator>>(istream& is,Integer& i){
        return is>>i.val;
    };
};

Integer operator+(Integer a,Integer b){
    return Integer(a.val + b.val);
}

ostream& operator<<(ostream& os,const Integer& i){
    return os<<i.val<<endl;
};

//输入流对象（可以把实现写在类内，但一般是在类内声明，在类外实现）

/* cin   X   a  Integer
 X       operator>>(Integer a)
 operator>>(istream& is,Integer& a)*/

//istream& operator>>(istream& is,Integer& i){
//    return is>>i.val;
//};

int main(){
    
    Integer a(1);
    
    cin>>a;
    cout<<a;
}




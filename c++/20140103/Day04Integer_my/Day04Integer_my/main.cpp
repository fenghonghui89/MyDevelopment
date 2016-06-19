//友元函数

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
    
//    Integer operator+(const Integer& b){
//        return Integer(val+b.val);
//    }
    
    //友元函数-不受访问权限限制，且获得访问私有成员的权利
    friend Integer operator+(Integer a,Integer b);
};

Integer operator+(Integer a,Integer b){
    return Integer(a.val + b.val);
}

int main(){
    Integer a(1);
    Integer b(2);
    Integer c = a + b;
    c.show();
}




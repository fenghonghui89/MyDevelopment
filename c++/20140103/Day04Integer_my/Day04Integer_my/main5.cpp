//练习：整数类-运算符重载

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
    
    Integer operator!(){
        return Integer(!val);
    }
    
    Integer operator-(){
        return Integer(-val);
    }
    
    Integer operator+(const Integer& i){
        return Integer(val+i.val);
    }
    
    Integer operator-(const Integer& i){
        return Integer(val-i.val);
    }
    
    Integer operator*(const Integer& i){
        return Integer(val*i.val);
    }
    
    Integer operator/(const Integer& i){
        return Integer(val/i.val);
    }
    
    Integer operator%(const Integer& i){
        return Integer(val%i.val);
    }
    
    //++i(自己)
//    Integer operator++(){
//        return Integer(++val);
//    }
    
    //++i(讲师)
    Integer& operator++(){
        ++val;
        //val++;结果一样
        return *this;
    }
    
    //i++(讲师)-哑元
    Integer operator++(int){
        return Integer(val++);
    }
    
    //--i
    Integer& operator--(){
        --val;
        return *this;
    }
    
    //i--
    Integer operator--(int){
        return Integer(val--);
    }
    
    friend Integer&   operator--(Integer& i);
    friend Integer operator--(Integer& i,int);
};

//--i全局
Integer& operator--(Integer& i){
    --i.val;
    return  i;
}

//i--全局（哑元）
Integer operator--(Integer& i,int){
    return  Integer(i.val--);
}

int main(){
    Integer ia(100);
    Integer ib(21);
    
    Integer i1 = !ia;
    i1.show();
    
    Integer i2 = -ia;
    i2.show();
    
    Integer i3 = ia+ib;
    i3.show();
    
    Integer i4 = ia-ib;
    i4.show();
    
    Integer i5 = ia*ib;
    i5.show();
    
    Integer i6 = ia/ib;
    i6.show();
    
    Integer i7 = ia%ib;
    i7.show();
    
    Integer i8 = ++ia;
    i8.show();
    
    Integer i9 = ia++;
    i9.show();
    
    Integer i10 = --ib;
    i10.show();
    
    Integer i11 = ib--;
    i11.show();
}
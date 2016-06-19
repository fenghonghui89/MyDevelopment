//函数对象
//语法：返回值 operator()(参数列表){ }

#include <iostream>
using namespace std;

class Product{
    
    double price;
    int count;
    
public:
    Product(double price,int count):price(price),count(count){
    
    }
    
    double getPrice(){
        return price*count;
    }
    
    //函数对象-1
    double operator()(double p,int c){
        cout<<"double operator()"<<endl;
        return p*c;
    }
};

//函数对象-2
double showSumPrice(double price, int count,Product p){
    cout<<"double showSumPrice"<<endl;
    return p(price,count);
}

int main(){
    
    Product app(1.2,12);
    cout<<app.getPrice()<<endl;
    
    cout<<"-----------------"<<endl;
    
    cout<<app(1.0,12)<<endl;
    
    cout<<"-----------------"<<endl;
    
    cout<<showSumPrice(1.1, 11, app)<<endl;
    
}
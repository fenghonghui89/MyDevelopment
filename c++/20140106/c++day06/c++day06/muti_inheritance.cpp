#include <iostream>
using namespace std;
class Mp3{
private:
    double  price;
public:
    double  getPrice(){return  price;}
public:
    Mp3(double price=0):price(price)
    {cout<<"Mp3()"<<endl;
    }
    ~Mp3(){cout<<"~Mp3()"<<endl;}
};
class Phone{
private:
    double  price;
public:
    double  getPrice(){return  price;}
public:
    Phone(double  price=0):price(price){cout<<"Phone()"<<endl;}
    ~Phone(){cout<<"~Phone()"<<endl;}
};
class Camera{
private:
    double  price;
public:
    double  getPrice(){return  price;}
public:
    Camera(double price=0):price(price){cout<<"Camera()"<<endl;}
    ~Camera(){cout<<"~Camera()"<<endl;}
};

class IPhone:public Mp3, public Phone,public Camera{
public:
    IPhone(double mp3_price=0,double phone_price=0,
           double camera_price=0):
    Mp3(mp3_price),Phone(phone_price),
    Camera(camera_price){
    }
    /* 提供一个成员函数 getPrice 获得价格 */
    double  getPrice(){
    return Mp3::getPrice()+Phone::getPrice()+Camera::getPrice();
    }
};
int main(){
    IPhone  iphone5(50,1500,2500);
    cout<<iphone5.Mp3::getPrice()<<endl;
    cout<<iphone5.getPrice()<<endl;

}





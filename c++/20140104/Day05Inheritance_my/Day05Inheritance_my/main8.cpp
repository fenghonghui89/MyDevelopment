//day02:多继承
//构造函数的调用顺序和继承顺序一致，析构函数的调用顺序则相反
//子类会继承所有父类的数据，如果产生名字冲突，加父类名::数据

#include <iostream>
using namespace std;

class MP3{
private:
    double price;
public:
    double getPrice(){return price;}
public:
    MP3(double price = 0):price(price){cout<<"MP3()"<<endl;}
    ~MP3(){cout<<"~MP3()"<<endl;}
};

class Phone{
private:
    double price;
public:
    double getPrice(){return price;}
public:
    Phone(double price = 0):price(price){cout<<"Phone()"<<endl;}
    ~Phone(){cout<<"~Phone()"<<endl;}
};

class Camera{
private:
    double price;
public:
    double getPrice(){return price;}
public:
    Camera(double price = 0):price(price){cout<<"Camera()"<<endl;}
    ~Camera(){cout<<"~Camera()"<<endl;}
};

class IPhone:public MP3,public Camera,public Phone{
public:
    IPhone(double mp3_price = 0,double phone_price = 0,double camera_price = 0):
    MP3(mp3_price),Phone(phone_price),Camera(camera_price){
    }
    
    double getPrice(){
        return MP3::getPrice()+Phone::getPrice()+Camera::getPrice();
    }
};

int main(){
    IPhone iphone5(50,1500,2500);
    cout<<iphone5.MP3::getPrice()<<endl;
    cout<<iphone5.getPrice()<<endl;
}
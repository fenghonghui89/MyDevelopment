//day02:虚继承
//让孙子类像子类一样可以直接访问最高层类
//共同部分来自最高层类，特有方法来自父类

#include <iostream>
using namespace std;

//抽取共同部分
class Product{
private:
    double price;
public:
    Product(double price = 0):price(price){}
    double getPrice(){return price;}
};

//加上virtual成为虚继承
class MP3:virtual public Product{
public:
    MP3(double mp3_price = 0):Product(mp3_price){}
    void funMP3(){cout<<"播放音乐"<<endl;}
};

class Phone:virtual public Product{
public:
    Phone(double phone_price = 0):Product(phone_price){}
    void funphone(){cout<<"打电话"<<endl;}
};

class Camera:virtual public Product{
public:
    Camera(double camera_price = 0):Product(camera_price){}
    void funCamera(){cout<<"拍照"<<endl;}
};

//直接访问最高层类
class IPhone:public MP3,public Phone,public Camera{
public:
    IPhone(double price = 0):Product(price){
    
    }
};

int main(){
    MP3 mp3(49.8);
    cout<<mp3.getPrice()<<endl;
    mp3.funMP3();
    
    IPhone iphone5(4050);
    cout<<iphone5.getPrice()<<endl;//从爷爷类获得方法
    iphone5.funMP3();
    iphone5.funCamera();
}
#include <iostream>
using namespace std;
/* 抽取共同部分 */
class  Product{
private:
    double  price;
public:
    Product(double  price=0)
    :price(price){}
    double  getPrice(){return   price;}
};
class  Mp3:virtual public Product{
public:
    Mp3(double  mp3_price=0)
    :Product(mp3_price){
    
    }
    void   funplay(){
        cout<<"播放音乐"<<endl;
    }
};
class  Phone:virtual public Product{
public:
    Phone(double  phone_price=0):
    Product(phone_price){
    
    }
    void  funPhone(){
        cout<<"打电话"<<endl;
    }
};
class  Camera:virtual public Product{
public:
    Camera(double  phone_price=0):
    Product(phone_price){
        
    }
    void  funCamera(){
        cout<<"录制视频"<<endl;
    }
};
class  IPhone:public Mp3,public Phone,
public Camera{
public:
    IPhone(double price=0):Product(price){
    
    }
};
int main(){
    Mp3    mp3(49.8);
    cout<<mp3.getPrice()<<endl;
    mp3.funplay();
    IPhone  iphone5(4050);
    cout<<iphone5.getPrice()<<endl;
    iphone5.funplay();
    iphone5.funPhone();
}


#include <iostream>
using namespace std;
template <typename T>
class  MyArray{
    T*  data; //根据T的不同存储不同类型的数据
    int   capacity;
    int   size;
    void   expend(){
        capacity=capacity*2+1;
        T* temp=new T[capacity];
        /*复制原来的数据 */
        for(int i=0;i<size;i++){
            temp[i]=data[i];
        }
        delete[] data;
        data=temp;
    }
public:
    class  iterator{
        /* 迭代器管理的数据指针 */
        T*     itdata;
    public:
        iterator(T* data=NULL):
        itdata(data){
        }
        /* ->  *  ++ 实现即可 */
        /* 使用*号获得数据 */
        T&  operator*(){
            return  *itdata;
        }
        T*  operator->(){
            return  itdata;
        }
        /* ++  根据当前迭代器的信息 获得下
         一个元素的迭代器 */
        iterator  operator++(){
            itdata++;
            return  *this;
        }
    };
    /* MyArray 中提供 begin   end */
    iterator   begin(){
        return  data;
    }
    /* 获得最后一个元素后面的迭代器 */
    iterator   end(){
        return  data+size;
    }
    MyArray(int capacity=5):capacity(capacity),size(0){
        /* 动态申请存储数据的内存 */
        data=new T[capacity];
    }
    ~MyArray(){
        if(data){
            delete[] data;
            data=NULL;
        }
    }
    MyArray(const MyArray& ma){
        size=ma.size;
        capacity=ma.capacity;
        data=new T[capacity];
        for(int i=0;i<size;i++){
            data[i]=ma.data[i];
        }
    }
    /* 赋值运算符 */
    
    /* 得到元素个数 */
    int   masize(){
        return  size;
    }
    /* 通过下标得到数据  [] */
    T&   operator[](int ind){
        return data[ind];
    }
    /* 给数组 赋值的函数 */
    void   push_back(const T&  t){
        /*如果数据空间不足 则扩容 */
        if(size==capacity){
            expend();
        }
        data[size++]=t;
    }
};
struct  Emp{
    string   name;
    int      age;
    friend  ostream& operator<<(ostream& os,const Emp& e){
        return os<<e.name<<":"<<e.age;
    }
};
int   main(){
    MyArray<Emp>   emps;
    Emp    emp={"zhangsan",23};
    Emp    emp2={"zhouxingxing",50};
    emps.push_back(emp );
    emps.push_back(emp2);
    
    cout<<*emps.begin()<<endl;
    cout<<emps.begin()->name<<endl;
    cout<<*++emps.begin()<<endl;
    cout<<(++emps.begin())->name<<endl;
    /*MyArray<int>   datas;
    datas.push_back(199);
    datas.push_back(300);
    MyArray<int>::iterator  it;
    it=datas.begin();
    cout<<*it<<endl;*/
}


//5.1 c++ 中的结构
#include <iostream>
using  namespace   std;

struct Emp{
    int  eno;
    char name[30];
    double salary;
    void  show(){
        cout<<eno<<":"<<name<<":"<<
        salary<<endl;
    }
};

void  show(struct Emp  e){
    cout<<e.eno<<":"<<e.name<<":"<<
    e.salary<<endl;
}

int main(){
    struct var_emp_c;//c下的定义变量
    
    //c++下的定义变量（省略struct，相当于写了typedef struct Emp Emp;）
    Emp  var_emp={100,"xiaoqiang",1};
    
    show(var_emp);
    var_emp.show();
}


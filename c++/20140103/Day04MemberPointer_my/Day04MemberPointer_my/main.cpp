#include <iostream>
using namespace std;

struct Date{
    int  year;
    int  month;
    int  day;
    
public:
    Date(int year=2014,int month=1,int day=3){
        this->year = year;
        this->month = month;
        this->day = day;
    }
};

int main(int argc, const char * argv[])
{
    int Date::*mptr;//定义一个成员指针，指向成员year
    mptr = &Date::year;//给指针赋值
    
    Date date;
    cout<<date.*mptr<<endl;
    
    mptr = &Date::month;//改变指向
    
    Date* date1 = new Date;
    cout<<date1->*mptr<<endl;
}


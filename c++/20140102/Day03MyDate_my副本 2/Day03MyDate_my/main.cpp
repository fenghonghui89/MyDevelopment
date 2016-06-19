//
//  main.cpp
//  Day03MyDate_my
//
//  Created by HanyFeng on 14-1-4.
//  Copyright (c) 2014年 Hany. All rights reserved.
//

#include <iostream>
#include "MyDate.h"
using namespace std;

void showDate(MyDate* md){
    cout<<md->year<<"-"<<md->month<<"-"<<md->day<<endl;
}

int main(int argc, const char * argv[])
{
    MyDate md;
    md.show();
    
    MyDate md2(2015,1,1);
    md2.show();
    
    MyDate md3(2016,1,1);
    showDate(&md3);
}


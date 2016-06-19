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
int main(int argc, const char * argv[])
{
    MyDate md;
    md.show();
    
    cout<<&md<<endl;
    cout<<md.getSelfAddress()<<endl;
}


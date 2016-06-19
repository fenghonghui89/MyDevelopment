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
    md->show();
}

int main(int argc, const char * argv[])
{
//方法的返回值是对象
    MyDate md1A;
    cout<<"md1A address:"<<&md1A<<endl;
//    md1A.increamentDay1().increamentDay1().increamentDay1();
    md1A = md1A.increamentDay1().increamentDay1().increamentDay1();
    md1A.show();
    printf("\n");
    
    MyDate* md2A = new MyDate;
    cout<<"md2A address:"<<md2A<<endl;
//    md2A->increamentDay1().increamentDay1().increamentDay1();
    *md2A = md2A->increamentDay1().increamentDay1().increamentDay1();
    md2A->show();
    printf("\n");
    
    MyDate md31;
    MyDate& md3A = md31;
    cout<<"md31 address:"<<&md31<<endl;
    cout<<"md3A address:"<<&md3A<<endl;
//    md3A.increamentDay1().increamentDay1().increamentDay1();
    md3A = md3A.increamentDay1().increamentDay1().increamentDay1();
    md3A.show();
    printf("\n");

//方法的返回值是指针
    MyDate md1B;
    cout<<"md1B address:"<<&md1B<<endl;
    md1B.increamentDay2()->increamentDay2()->increamentDay2();
    md1B.show();
    printf("\n");
    
    MyDate* md2B = new MyDate;
    cout<<"md2B address:"<<md2B<<endl;
    md2B->increamentDay2()->increamentDay2()->increamentDay2();
    md2B->show();
    printf("\n");
    
    MyDate md32;
    MyDate& md3B = md32;
    cout<<"md32 address:"<<&md32<<endl;
    cout<<"md3B address:"<<&md3B<<endl;
    md3B.increamentDay2()->increamentDay2()->increamentDay2();
    md3B.show();
    printf("\n");

//方法的返回值是引用
    MyDate md1C;
    cout<<"md1C address:"<<&md1C<<endl;
    md1C.increamentDay3().increamentDay3().increamentDay3();
    md1C.show();
    printf("\n");

    MyDate* md2C = new MyDate;
    cout<<"md2C address:"<<md2C<<endl;
    md2C->increamentDay3().increamentDay3().increamentDay3();
    md2C->show();
    printf("\n");

    MyDate md33;
    MyDate& md3C = md33;
    cout<<"md33 address:"<<&md33<<endl;
    cout<<"md3C address:"<<&md3C<<endl;
    md3C.increamentDay3().increamentDay3().increamentDay3();
    md3C.show();
    printf("\n");

//方法的返回值为空
    MyDate md1D;
    md1D.increamentDay4();
    md1D.show();
    
    MyDate* md2D = new MyDate;
    md2D->increamentDay4();
    md2D->show();
    
    MyDate md34;
    MyDate& md3D = md34;
    md3D.increamentDay4();
    md3D.show();
    
}


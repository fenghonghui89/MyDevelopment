//
//  MD_C_Union_CFile.c
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/7.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#include "MD_C_Union_CFile.h"
void cUnionTest0();
void cUnionTest1();

void cUnionTest()
{
    cUnionTest0();
}

#pragma mark - 联合体
void cUnionTest0()
{
    //TODO:定义一个联合体
    union {
        int age;
        char name[20];
    }person = {2};
    person.age = 13;
    person.name[0] = 's';
    printf("person's age:%d\n",person.age);
    printf("person's name:%s\n",person.name);
    printf("person's size:%ld\n\n",sizeof(person));
    
    
    
    
    
    //TODO:定义联合类型、起别名
    //定义一个联合类型
    union PERSON{
        int age;
        char *name;
    };
    //根据联合类型定义联合体
    union PERSON person1;
    person1.age = 13;
    person1.name = "sss";
    printf("person1's age:%d\n",person1.age);
    printf("person1's name:%s\n",person1.name);
    printf("person1's size:%ld\n\n",sizeof(person1));
    
    //给联合类型起别名
    typedef union PERSON Person;
    Person person2 = {12};
    person2.age = 13;
    person2.name = "hany";
    printf("person2's age:%d\n",person2.age);
    printf("person2's name:%s\n",person2.name);
    printf("person2's size:%ld\n\n",sizeof(person2));
}


#pragma mark - 结合上面的内容，定义联合放在函数的外面
typedef union {
    int num;
    char n[2];
    double f;
    int *p;
}lian_he;

void cUnionTest1()
{
    //声明一个联合变量
    lian_he l;
    
    //联合变量所占用的内存空间
    printf("l num:%d\n",l.num);
    printf("l n[0]:%c\n",l.n[0]);
    printf("l f:%f\n",l.f);
    printf("l p:%p\n",l.p);
    printf("lian_he l size:%ld\n\n",sizeof(l));
    
    l.num = 10;
    printf("l num:%d\n",l.num);
    printf("l n[0]:%c\n",l.n[0]);
    printf("l f:%f\n",l.f);
    printf("l p:%p\n",l.p);
    printf("lian_he l size:%ld\n\n",sizeof(l));
    
    l.n[0] = 'a';
    printf("l num:%d\n",l.num);
    printf("l n[0]:%c\n",l.n[0]);
    printf("l f:%f\n",l.f);
    printf("l p:%p\n",l.p);
    printf("lian_he l size:%ld\n\n",sizeof(l));
    
    l.f = 1.11111;
    printf("l num:%d\n",l.num);
    printf("l n[0]:%c\n",l.n[0]);
    printf("l f:%f\n",l.f);
    printf("l p:%p\n",l.p);
    printf("lian_he l size:%ld\n\n",sizeof(l));

    int i = 20;
    l.p = &i;
    printf("l num:%d\n",l.num);
    printf("l n[0]:%c\n",l.n[0]);
    printf("l f:%f\n",l.f);
    printf("l p:%p\n",l.p);
    printf("lian_he l size:%ld\n\n",sizeof(l));
}
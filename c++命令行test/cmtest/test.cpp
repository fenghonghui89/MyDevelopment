//
//  test.cpp
//  cmtest
//
//  Created by 冯鸿辉 on 16/6/24.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "test.hpp"
#include <iostream>

#include<iostream>
#include<functional>
#include<numeric>
#include<algorithm>

using namespace std;



struct node{
  int data;
  node * next;
};

#define M 5

void test_0();
void test_1();
int fun(int n);
void create(         node * &head                         );
void reversion(int ary[],int size);
bool symm(long m);


void test_root(){

  

}



void test_1(){

  double a[] = { 1.1, 3.1, 5.1, 7.1, 9.1 }, *p ;
  int i;
  
  for( i = 0; i<5; i++ ) //①下标方式访问数组
    cout << "a[" << i << "]=" << a[i] << '\t';
  cout << endl;
  
  for( p = a, i = 0; i<5; i++ ) //②指针变量下标方式访问数组
    cout << "a[" << i << "]=" << p[i] << '\t';
  cout << endl;
  
  for( i = 0; i<5; i++ ) //③指针方式访问数组
    cout << "a[" << i << "]=" << *( a+i ) << '\t';
  cout << endl;
  
  for( p = a; p<a+5; p++ ) //④指针变量间址方式访问数组
    cout << "a[" << p-a << "]=" << *p << '\t';
  cout << endl;

}

bool symm(long m)//函数
{
  long temp=m,n=0;
  while (temp){
    n = n*10 + temp%10;
    temp = temp/10;
  }
  
  return(m==n);
}

void test_0(){
  

  for (int i = 1;i <= 99;i++){
    if((i * i- i)% 10==0){
      cout<<i<<' ';
    }
  }
}


void reversion(int ary[],int size)
{
  int *a = ary, *b = ary + size - 1, t;
  while (a < b)
  {
    t = *a,*a = *b; *b =1;
    a++,b++;
  }
}


void create(         node * &head                         )
{
  node *p, *q;
  p=new node;
  cin>>p->data;
  q=p;
  while(          p -> data != '0'                       )
  {if(head==NULL) head=p;
  else         head = new node             ;
    q=p;
    p -> next = head                     ;
    cin>>p->data;
  }
  q->next=NULL;
  delete p;
}

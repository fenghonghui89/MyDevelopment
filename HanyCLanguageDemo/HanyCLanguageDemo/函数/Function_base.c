//
//  Function_base.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "Function_base.h"

void Function_base_root(){

}
#pragma mark - ********** knowledge **************
#pragma mark - 递归、递推
/*
 递归算法：递归过程一般通过函数或子函数过程来实现。
 递归方法：在函数或子函数的内部，直接或间接地调用自己的算法。
 递归算法可以求阶乘，但要有退出条件，否则会造出死循环
 */
int f1(int n)
{
  printf("进入了f1函数 n:%d\n",n);
  if(n==1) return 1;
  return n*f1(n-1);//f1(1)
}

//递推
int f2(int n)
{
  int res=1;
  for (int i=1; i<=n; i++) {
    res=res*i;
  }
  return res;
}

#pragma mark - 变量的作用域、全局变量、局部变量、代码块

int i4 = 40;//全局变量

void test()
{
  int i4 = 60;//局部变量
  printf("test i4:%d\n",i4);
}

void test2()
{
  int i2=10;
  printf("i2:%d\n",i2);
  
  //代码块/代码段
  {
    int i2=22;
    printf("block i2:%d\n",i2);
  }
  test();
  printf("main i4:%d\n",i4);
}

#pragma mark - 终止程序
int testb()
{
  printf("终止程序");
  exit(0);//终止程序，终止所有函数；exit(0)在stdlib.h头文件内
  //return 0;return只会终止当前函数。
}
#pragma mark - *********** practice **************
#pragma mark - 练习：放球取球
/*
 作业：使用程序解决放球、取球的问题。
 依次向网兜中放球，当网兜满的时候要提示
 满了，当取球时，网兜中没有球要提法空了。
 如果网兜中有球，可以得到具体的值。
 思路：
 a.保存数据容器
 b.放入数据的操作
 c.取出数据的操作
 d.标识
 e.空/满/当前状态
 f.得到最后的数据（元素）
 */
int isFull();
int isEmpty();
void showStack();
int pop();
void push(int num);
int count = -1;//状态标识
int stack[3]={0};//创建保存球的容器

void runStack()
{
  showStack();
  push(1);
  push(2);
  push(3);
  push(1);
  showStack();
  printf("取出的球为:%d\n",pop());
  printf("取出的球为:%d\n",pop());
  printf("取出的球为:%d\n",pop());
  printf("取出的球为:%d\n",pop());
  showStack();
  
}

#pragma mark action
//查看数组中的状态
void showStack()
{
  printf("showStack()\n");
  for (int i=2; i>=0; i--) {
    printf("stack[%d]:%d\n",i,stack[i]);
  }
}

//从容器中取出数据
int pop()
{
  int temp=0;
  if (!isEmpty()) {
    temp = stack[count];
    stack[count] = 0;
    count--;
    return temp;
  }else{
    printf("取值不成功\n");
    return 0;
  }
}

//向容器中添加数据
void push(int num)
{
  if(!isFull()){
    //不满的时候才可以添加数据
    ++count;
    stack[count] = num;
    printf("添加数据成功: statck[%d]:%d\n",count,stack[count]);
  }else{
    printf("添加数据不成功\n");
  }
}

//判断容器是否满了
int isFull(){
  if(count==2){
    printf("容器已满，不可添加数据\n");
    return 1;
  }else{
    printf("容器未满，可添加数据\n");
    return 0;
  }
}

//判断容器是否为空
int isEmpty(){
  if (count==-1) {
    printf("容器为空，不可取出数据\n");
    return 1;
  }else{
    printf("容器不为空，可取出数据\n");
    return 0;
  }
}

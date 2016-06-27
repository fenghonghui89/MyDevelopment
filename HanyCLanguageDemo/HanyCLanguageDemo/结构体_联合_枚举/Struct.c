//
//  Struct.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "Struct.h"

void Struct_root(){
  
}

#pragma mark - ********** knowledge **************

#pragma mark 定义
void cStructTest0()
{

  struct{
    int age;
    char *name;
  }person = {18,"hany"};//可以不赋值
  person.age = 20;
  person.name = "mary";
  printf("person age:%d\n",person.age);
  printf("person name:%s\n",person.name);
  printf("person size:%ld\n\n",sizeof(person));
  
}

#pragma mark 定义结构类型、起别名
void struct_other(){

  //定义结构类型
  struct PERSON{
    int age;
    char *name;
  };
  
  //根据结构类型定义一个结构体
  struct PERSON person1 = {13,"bb"};//可以不赋值
  person1.age = 2;
  person1.name = "Ann";
  printf("person1 age:%d\n",person1.age);
  printf("person1 name:%s\n",person1.name);
  
  //给结构类型起别名
  typedef struct PERSON Person;
  Person person2 = {1,"Pe"};
  person2.age = 18;
  person2.name = "Jam";
  printf("person2 age:%d\n",person2.age);
  printf("person2 name:%s\n",person2.name);
}

#pragma mark 定义结构放在函数的外面
typedef struct {
  int age;
  char *name;
}Human;
void cStructTest1()
{
  Human human = {18,"Peter"};
  printf("human age:%d\n",human.age);
  printf("human name:%s\n",human.name);
}



#pragma mark - *********** practice **************
/*
 定义一个学生结构体，学号、姓名、年龄、
 性别(F、M)，创建三个学生，并输入信息，
 输出信息内容。
 */
typedef struct{
  int id;
  char name[20];
  int age;
  char sex;
}Student;

void cStructTest2()
{
  //保存学生信息
  Student students[3];
  
  //输入学生信息
  int i = 0;
  for (i=0; i<3; i++) {
    printf("请输入第%d个学生信息:\n",i+1);
    printf("请输入学号:\n");
    scanf("%d",&students[i].id);
    printf("请输入年龄:\n");
    scanf("%d",&students[i].age);
    printf("请输入姓名:\n");
    scanf("%s",students[i].name);
    
    //清除缓冲区的内容
    scanf("%*c");
    printf("请输入性别:\n");
    scanf("%c",&students[i].sex);
  }
  
  //输出学生信息
  for (i=0; i<3; i++) {
    printf("输出第%d个学生信息:\n",i+1);
    printf("学号:%d\n",students[i].id);
    printf("年龄:%d\n",students[i].age);
    printf("请输入姓名:%s\n",students[i].name);
    printf("请输入性别:%c\n",students[i].sex);
  }
}

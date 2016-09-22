//
//  FreeTest.c
//  HanyCLanguageDemo
//
//  Created by 冯鸿辉 on 16/6/27.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "FreeTest.h"

#include <stdio.h>

#pragma mark - *********** knowledge ***********
#pragma mark - *********** test ***********
static void test1(){

  int a = ({
    int b = 2;
    int c = 2;
    b+c;
  });
  printf("a:%d",a);
}
#pragma mark - *********** root ***********
void root_FreeTest(){

  printf("hello world!\n");

}


//
//  MD_C_ValueSize_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/4/24.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_C_ValueSize_ViewController.h"
@interface MD_C_ValueSize_ViewController()
@end
@implementation MD_C_ValueSize_ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self valueTest0];
}

-(void)valueTest0
{
    bool bc = true;//C:or false
    BOOL boc = YES;//OC:or no
    
    int *ic = NULL;//C
    int *ioc = nil;//OC
    
    id pid = nil;//oc的id类型相当于void*
}

-(void)valueTest1
{
    /*
     sizeof计算数据类型所占空间
     不同数据类型所占空间不能按照理论得出，编译器和CPU不同，所占空间也不同。
     */
    printf("sizeof(char):%ld\n",sizeof(char));
    printf("sizeof(short int):%ld\n",sizeof(short int));
    printf("sizeof(int):%ld\n",sizeof(int));
    printf("sizeof(long int):%ld\n",sizeof(long int));
    printf("sizeof(long long int):%ld\n",sizeof(long long int));
    printf("sizeof(float):%ld\n",sizeof(float));
    printf("sizeof(double):%ld\n",sizeof(double));
    printf("sizeof(long double):%ld\n",sizeof(long double));
    
    int i=3ul;
    printf("sizeof(int i=3ul):%ld\n",sizeof(i));
}

@end

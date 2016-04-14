//
//  MDBlockNormalViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/4/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//








//函数
//声明
int sum(int num,int num2);
//定义
int sum(int num,int num2){
    return num+num2;
}



#import "MDBlockNormalViewController.h"

@interface MDBlockNormalViewController ()

@end

@implementation MDBlockNormalViewController

#pragma mark - vc lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self testBlock0];
//    [self testBlock1];
//    [self testBlock2];
  [self testBlock3];
}

#pragma mark - block常用方法
-(void)testBlock0
{
    [self testBlock00];
//    [self testBlock01];
//    [self testBlock02];
//    [self testBlock03];
}

//TODO:block及其用法
-(void)testBlock00
{
    //block
    ^void(void){NSLog(@"this is block");};
    ^int(int a){return a*a;};
  
    //block的用法
    int get = ^int(int a){return a*a;}(5);
    NSLog(@"get:%d", get);
}

//TODO:block指针及其用法
-(void)testBlock01
{
    //block指针
    int(^blockP1)(int,int);//声明，注意可带可不带形参名
    blockP1 = ^int(int a,int b){return a+b;};//定义
    int get1 = blockP1(3,4);//使用
    NSLog(@"get1:%d",get1);
    
    int(^blockPP)(int,int) = ^int(int a,int b){return a+b;};
    int get2 = blockPP(4,5);
    NSLog(@"get2:%d",get2);
}

//TODO:在外面声明block指针
//block指针可以只在外面声明 必须带typedef 否则不能调用
typedef int(^Sum1)(int,int);
-(void)testBlock02
{
    //定义外面声明的block
    Sum1 s1 = ^int(int a, int b){
        return a+b;
    };
    NSLog(@"s1:%d",s1(1,3));
}

//TODO:在外面声明和定义block指针
//直接声明+定义
int(^Sum2)(int,int) = ^int(int a,int b){
    return a+b;
};

-(void)testBlock03
{
    int s2 = Sum2(1,2);
    NSLog(@"s2:%d",s2);
}

#pragma mark - block做参数的函数/block做参数的方法

-(void)testBlock1
{
//    [self testBlock10];
    [self testBlock11];
}

//TODO:block做参数的函数
-(void)testBlock10
{
    int(^blockP)(int,int) = ^int(int a,int b){return a+b;};
    fundation(blockP);
}

void fundation (int (^block1)(int,int))//参数写法：block指针
{
    if (block1) {
        int get = block1(1,2);
        NSLog(@"get:%d",get);
    }
}

//TODO:block做参数的方法
-(void)testBlock11
{
    int(^blockP)(int,int) = ^int(int a,int b){return a+b;};
    [self method:blockP];
}


-(void)method:(int(^)(int,int))block//参数写法：block指针，指针名提取出来做形参 block也可以做返回值
{
    if (block) {
        int get = block(3,4);
        NSLog(@"get:%d",get);
    }
}

#pragma mark - 用block对数组排序
-(void)testBlock2
{
    [self sortedArray];
}

-(void)sortedArray
{
    NSMutableArray* array = [NSMutableArray arrayWithObjects:@"abc",@"ccd",@"bbd", nil];
    
    //方法1：直接传block
    NSArray* array2 = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* str = obj1;
        NSString* str2 = obj2;
        return [str compare:str2];}];
    NSLog(@"array2:%@",array2);
    
    //方法2：声明并定义一个block指针，再传block指针
    NSComparisonResult(^selectorBlock)(id,id);
    selectorBlock = ^NSComparisonResult(id obj1, id obj2) {
        NSString* str = obj1;
        NSString* str2 = obj2;
        return [str compare:str2];
    };
    
    NSArray *array3 = [array sortedArrayUsingComparator:selectorBlock];
    NSLog(@"array3:%@",array3);
    
}

#pragma mark - block做回调参数
-(void)testBlock3
{
  [self.delegate blockDelegate:self block:^(BOOL b) {
    if (b == YES) {
      NSLog(@"block delegate 传入yes");
    }
  }];
  
}

#pragma mark - block做block参数
-(void)retryBlockMethod:(MDBlockNormalViewControllerRetryBlock)block
{
  retryblock reb= ^void(BOOL b){
    if (b == YES)
      NSLog(@"block做block参数");
  };
  block(YES,reb);
}
@end

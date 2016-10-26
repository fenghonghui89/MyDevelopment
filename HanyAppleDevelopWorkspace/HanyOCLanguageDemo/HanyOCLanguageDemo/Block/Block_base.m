//
//  Block_base.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

/*
 函数的声明与定义
 */
int sum(int num,int num2);
int sum(int num,int num2){
  return num+num2;
}

#import "Block_base.h"

@implementation Block_base


-(void)root_Block_base{

}

#pragma mark - < method >
#pragma mark - * block常用方法
-(void)testBlock0{
  [self testBlock00];
//    [self testBlock01];
//    [self testBlock02];
//    [self testBlock03];
}

//block及其用法
-(void)testBlock00{
  
  //block 返回值不加括号 参数加括号
  ^void(void){NSLog(@"this is block");};
  ^int(int a){return a*a;};
  
  //block的用法
  int get = ^int(int a){return a*a;}(5);
  NSLog(@"get:%d", get);
}

//block指针及其用法
-(void)testBlock01{
  
  //block指针
  int(^blockP1)(int,int);//声明 返回值不加括号 参数加括号 注意可带可不带形参名
  blockP1 = ^int(int a,int b){return a+b;};//定义
  int get1 = blockP1(3,4);//使用
  NSLog(@"get1:%d",get1);
  
  int(^blockPP)(int,int) = ^int(int a,int b){return a+b;};
  int get2 = blockPP(4,5);
  NSLog(@"get2:%d",get2);
}


/*
 在外面声明block指针
 block指针可以只在外面声明 必须带typedef 否则不能调用
 */
typedef int(^Sum1)(int,int);
-(void)testBlock02{
  //定义外面声明的block
  Sum1 s1 = ^int(int a, int b){
    return a+b;
  };
  NSLog(@"s1:%d",s1(1,3));
}

/*
 在外面声明和定义block指针
 直接声明+定义
 */
int(^Sum2)(int,int) = ^int(int a,int b){
  return a+b;
};

-(void)testBlock03
{
  int s2 = Sum2(1,2);
  NSLog(@"s2:%d",s2);
}

#pragma mark - * block做参数

-(void)testBlock1{
  
//    [self testBlock10];
  [self testBlock11];
}

#pragma mark - ***** block做参数的函数
/*
 block做参数的函数
 参数写法：block指针 回值不加括号 参数加括号
 */
-(void)testBlock10{
  
  int(^blockP)(int,int) = ^int(int a,int b){return a+b;};
  fundation(blockP);
}

void fundation (int(^block1)(int,int)){
  
  if (block1) {
    int get = block1(1,2);
    NSLog(@"get:%d",get);
  }
}

#pragma mark - ***** block做参数的方法
/*
 block做参数的方法
 参数写法：block指针，回值不加括号 参数加括号，指针名提取出来做形参 block也可以做返回值
 */
-(void)testBlock11{
  
  int(^blockP)(int,int) = ^int(int a,int b){return a+b;};
  [self method:blockP];
}


-(void)method:(int(^)(int,int))block{
  
  if (block) {
    int get = block(3,4);
    NSLog(@"get:%d",get);
  }
}

#pragma mark - ***** block做callback参数
-(void)downloadFile{
  
  NSLog(@"1.下载文件中..下载完成，返回数据到页面");
  
  [self.delegate blockDelegate:self data:10000 finishDownload:^(NSInteger clientId, Type_Block block) {
    
    NSLog(@"3.编号%ld的页面说：已经收到文件..",(long)clientId);
    
    NSInteger serverId = 222;
    void(^resultBlock)(void) = ^void(void){
      NSLog(@"5.客户端回复：已经关闭客户端端口..");
    };
    block(serverId,resultBlock);
  }];
  
}

#pragma mark - ***** block做block的参数
//eg1
-(void)retryBlockMethod:(Type_BiggerBlock)block
{
  Type_Block reb= ^void(NSInteger value,void(^ablock)(void)){
    NSLog(@"ablock..%ld",(long)value);
    ablock();
  };
  
  block(1,reb);
}

//eg2
-(void)blockTest{
  
  [self blockTest0:^{
    NSLog(@"~~~~~~~~");
  }];
}

-(void)blockTest1:(void(^)(void))blocktest{
  
  blocktest();
}

-(void)blockTest0:(void(^)(void))blocktest{
  
  [self blockTest1:^{
    blocktest();
  }];
}

#pragma mark - * 用block对数组排序
-(void)testBlock2{
  
  [self sortedArray];
}

-(void)sortedArray{
  
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





#pragma mark - * blck做属性
//eg3
-(instancetype)init{

  if (self = [super init]) {
    self.bigBlockParam = ^(NSInteger value,Type_Block block){
      NSLog(@"value1:%ld",(long)value);
      
      void(^ablock)(void) = ^void(void){};
      block(11,ablock);
    };

  }
  return self;
}

-(void)blockparamaTest{
  
  //eg1
  void(^ablock)(void) = ^void(void){};
  self.blockParama(YES,ablock);
  
  //eg2
  self.bigBlockParam(YES,self.blockParama);
}

@end

//
//  Block_value.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

#import "Block_value.h"
#import "Block_base.h"


@interface Block_value ()<Block_base_Delegate>
@property(nonatomic,copy)void(^block)(BOOL b);
@end

@implementation Block_value
-(void)root_Block_value{

}

#pragma mark - < method > -
#pragma mark 可以读取和Block pointer同一个Scope的变量值
-(void)test1
{
  int v1 = 8;
  int(^count)(int) = ^int(int a){
    return v1 + a;
  };
  int result = count(5);
  NSLog(@"result:%d",result);//13
}

#pragma mark 变量在主体中做了一次copy操作，copy的值是变量的值
-(void)test2
{
  //  static int v1 = 8;//结果为8 详见test4
  int v1 = 8;
  int(^count)(int) = ^int(int a){
    return v1 + a;
  };
  
  v1 = 3;
  int result = count(5);
  NSLog(@"result:%d",result);//13
}

#pragma mark 如果是指针，它的值是可以在block里被改变的
-(void)test3
{
  NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@"one", @"two", @"three", nil];
  int result = ^(int a){
    [mutableArray removeLastObject];
    return a*a;
  }(5);
  
  NSLog(@"result:%d  test array:%@",result, mutableArray);
}

#pragma mark __block / static 修饰变量
-(void)test4_static{
  
  //直接读取static类型的变量
  static int outA = 8;
  int (^myPtr)(int) = ^(int a){
    return outA + a;
  };
  outA = 5;
  int result = myPtr(3);
  NSLog(@"result:%d", result);//8
  
  //static类型变量，可以在block内修改
  static int outA1 = 8;
  int (^myPtr1)(int) = ^(int a){
    outA1 = 5;
    return outA1 + a;
  };
  int result1 = myPtr1(3);
  NSLog(@"result1:%d", result1);//8
}

-(void)test5_block{
  
  __block int num = 5;
  
  int (^myPtr1)(void) = ^(void){return num++;};
  int (^myPtr2)(void) = ^(void){return num++;};
  
  int result = myPtr1();//result的值为5，num的值为6
  result = myPtr2();//result的值为6，num的值为7
  NSLog(@"result:%d", result);//6
}

#pragma mark block delegate
-(void)test6
{

  
  Block_base *obj = [Block_base new];
  obj.delegate = self;
  
}

-(void)blockDelegate:(Block_base *)vc block:(Block_base_block)block{
  block(YES);
}

#pragma mark block做block参数
-(void)test7
{
  Block_base *obj = [Block_base new];
  [obj retryBlockMethod:^(BOOL a, retryblock reb) {
    reb(YES);
  }];
}

#pragma mark block循环引用问题
-(void)test8{
  
  //block持有self
  void(^block)(BOOL a) = ^(BOOL a){
    [self hash];
  };
  
  //block持有self self持有block
  self.block = ^(BOOL b){
    [self hash];
  };
  
  //解决(ios下)
//  __weak typeof(self) weakSelf = self;
//  self.block = ^(BOOL a){
//    __strong typeof(self) strongSelf = weakSelf;//可忽略
//    [strongSelf isViewLoaded];
//  };
}

@end

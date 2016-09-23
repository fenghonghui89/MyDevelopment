//
//  MD_KVC_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/8.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_KVC_VC.h"

@interface People : NSObject
-(id)initWithDic:(NSDictionary *)jsonObj;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)NSArray *guys;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,assign)BOOL isGuys;
@end

@implementation People
-(id)initWithDic:(NSDictionary *)jsonObj{
  
  if (self == [super init]) {
    [self setValuesForKeysWithDictionary:jsonObj];
  }
  return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
  
  if ([key isEqualToString:@"name1"]) {
    self.name = value;
  }else if ([key isEqualToString:@"ageXXX"]) {
    self.age = value;
  }else{
    [super setValue:value forUndefinedKey:key];
  }
}


@end

@interface MD_KVC_VC ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MD_KVC_VC

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  [self test3];
}

#pragma mark - <<<<< method >>>>>

-(void)data{

  self.dataArray = [NSMutableArray array];
  
  for (int i = 0; i<20; i++) {
    People *people = [People new];
    people.name = [NSString stringWithFormat:@"name_%d",i];
    people.age = [NSString stringWithFormat:@"age_%d",i];
    [self.dataArray addObject:people];
  }
}


#pragma mark valueForKey 简化代码 不能传递关系 会为nil
-(void)test{
  
  [self data];
  
  NSString *tag = arc4random()%2==2?@"name":@"age";
  
  People *people = [self.dataArray objectAtIndex:10];
  
  //no kvc
//  if ([tag isEqualToString:@"name"]) {
//    NSLog(@"name:%@",people.name);
//  }
//  if ([tag isEqualToString:@"age"]) {
//    NSLog(@"age:%@",people.age);
//  }
  
  //kvc
  NSLog(@"%@:%@",tag,[people valueForKey:tag]);
}

#pragma mark valueForKeyPath 传递关系
-(void)test2{
  
  [self data];
  
  for (People *people in self.dataArray) {
    NSLog(@"%@",[people valueForKeyPath:@"name.capitalizedString"]);//首字母大写
  }
}

#pragma mark setValue:forUndefinedKey: 处理未定义的key
-(void)test1{

  [self data];
  
  NSDictionary *jsonObj = @{@"name1":@"Hany",@"age":@"12"};
  People *people = [[People alloc] initWithDic:jsonObj];
  NSLog(@"%@ %@",people.name,people.age);
}

#pragma mark setValuesForKeysWithDictionary 快速赋值
-(void)test3{

  NSDictionary *jsonObj = @{@"name":@"Jim",
                            @"age":@"32",
                            @"guys":@[
                                @{@"name":@"Hany",@"age":@"12"},
                                @{@"name":@"Peter",@"age":@"13"}
                                ]};
  
  People *people = [[People alloc] initWithDic:jsonObj];
  NSLog(@"%@",people.sex);
  
}



@end

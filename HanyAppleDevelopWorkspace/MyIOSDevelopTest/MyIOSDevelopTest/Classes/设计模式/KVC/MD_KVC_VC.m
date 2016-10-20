//
//  MD_KVC_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/8.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_KVC_VC.h"


#pragma mark - ************ Father People *************
@interface Father : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;
@end

@interface People : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,strong)NSArray *guys;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,assign)BOOL isGuys;
@property(nonatomic,strong)Father *father;
-(id)initWithDic:(NSDictionary *)jsonObj;
@end

@implementation People
-(id)initWithDic:(NSDictionary *)jsonObj{
  
  if (self == [super init]) {
    [self setValuesForKeysWithDictionary:jsonObj];
  }
  return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
  
  DRLog(@"forUndefinedKey..%@ %@",key,value);
  if ([key hasPrefix:@"name"]) {
    self.name = value;
  }else if ([key hasPrefix:@"age"]) {
    self.age = [value integerValue];
  }else{
    [super setValue:value forUndefinedKey:key];
  }
}

-(void)setNilValueForKey:(NSString *)key{

  DRLog(@"setNilValueForKey..");
  [super setNilValueForKey:key];
}

@end


#pragma mark - ************ MD_KVC_VC *************
@interface MD_KVC_VC ()

@end

@implementation MD_KVC_VC

#pragma mark - < overwrite >
- (void)viewDidLoad {
  
  [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  [self test1];
}
#pragma mark - < method >

-(NSArray *)data{

  NSMutableArray *dataArray = [NSMutableArray array];
  
  for (int i = 0; i<20; i++) {
    People *people = [People new];
    people.name = [NSString stringWithFormat:@"name_%d",i];
    people.age = i;
    [dataArray addObject:people];
  }
  
  return dataArray;
}


#pragma mark * valueForKey 简化代码 不能传递关系 会为nil
/*
 基本类型用%@和valueForKey 不会有问题？
 */
-(void)test{
  
  NSString *tag = arc4random()%2==2?@"name":@"age";
  
  People *people = [[self data] objectAtIndex:10];
  
  //no kvc
//  if ([tag isEqualToString:@"name"]) {
//    NSLog(@"name:%@",people.name);
//  }
//  if ([tag isEqualToString:@"age"]) {
//    NSLog(@"age:%d",people.age);
//  }
  
  //kvc
  NSLog(@"%@:%@",tag,[people valueForKey:tag]);//name_10 or 10
}

#pragma mark * valueForKeyPath 传递关系
/*
 基本类型用%@和valueForKeyPath 不会有问题？
 */
-(void)test2{
  
  for (People *people in [self data]) {
//    NSLog(@"%@",[people valueForKeyPath:@"name.capitalizedString"]);//首字母大写
    NSLog(@"%@",[people valueForKeyPath:@"age"]);// 1 2 3..
  }
}

#pragma mark * setValuesForKeysWithDictionary 快速赋值
/*
 如果有属性类型是基本类型 setValuesForKeysWithDictionary也可以正确赋值
 但如果类型是自定义类型，则无法正确解析
 */
-(void)test3{

  NSDictionary *jsonObj = @{@"namexxx":@"Jim",
                            @"agexxx":@(32),
                            @"sex":@"boy",
                            @"isGuys":@(1),
                            @"father":@{
                                @"name":@"Boo",
                                @"age":@(33)
                                },
                            @"guys":@[
                                @{@"name":@"Hany",@"age":@"12"},
                                @{@"name":@"Peter",@"age":@"13"}
                                ]};
  
  People *people = [[People alloc] initWithDic:jsonObj];
  NSLog(@"people..%@ %ld",people.name,(long)people.age);
  
}

#pragma mark * setValue:forUndefinedKey: 处理未定义的key
-(void)test1{
  
//  NSDictionary *jsonObj = @{@"name111":@"Hany",@"age111":@(12)};
//  People *people = [[People alloc] initWithDic:jsonObj];
  People *people = [People new];
  [people setNilValueForKey:@"name"];
  NSLog(@"%@ %ld",people.name,(long)people.age);
  
}

@end

//
//  TRStudent.m
//  my08
//
//  Created by apple on 13-10-26.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRStudent.h"

@implementation TRStudent

#pragma mark - init

+(id)studentInitWithName:(NSString*)name AndAge:(int)age{
  TRStudent* student = [[TRStudent alloc] initwithName:name AndAge:age];
  return student;
}
-(id)initwithName:(NSString*)name AndAge:(int)age{
  if (self == [super init]) {
    self.name = name;
    self.age = age;
  }
  return self;
}

#pragma mark - method
#pragma mark base
-(NSString*)description{
  
  NSLog(@"执行了description方法");
  return [NSString stringWithFormat:@"age:%d",self.age];
}

#pragma mark NSSet hash
//1.先比较对象的hash值（重写hash方法）
-(NSUInteger)hash{
  
  return self.age;
}

//2.hash值一样则用isEqual比较对象的类型关系和值是否一样
-(BOOL)isEqual:(id)object{
  
  NSLog(@"执行了isEqual");
  if (![object isKindOfClass:[TRStudent class]]) {//2.1先比较对象的类型关系
    return YES;
  }else {
    TRStudent* tempStudent = object;//2.2再比较对象的值的关系
    if ([self.name isEqual:object]) {
      return YES;
    }else{
      return NO;
    }
  }
}

#pragma mark other
-(void)study{
  
  NSLog(@"study~");
}
@end

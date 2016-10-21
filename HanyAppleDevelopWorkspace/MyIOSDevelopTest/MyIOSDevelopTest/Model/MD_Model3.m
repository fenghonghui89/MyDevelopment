//
//  MD_Model3.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//


#import "MD_Model3.h"
#import "MDRootDefine.h"
#import <objc/runtime.h>

#pragma mark - ******************** TRStudent ********************
@implementation TRStudent

#pragma mark - < overwrite >
#pragma mark * description
-(NSString *)description{
  return [self yy_modelDescription];
}

-(NSString *)debugDescription{
  return [self yy_modelDescription];
}

#pragma mark * hash
-(NSUInteger)hash{

//  NSUInteger hashValue = self.age ^ [self.name hash];
//  DRLog(@"TRStudent hash.. %lu",(unsigned long)hashValue);
//  return hashValue;
  
  return [self yy_modelHash];
}

-(BOOL)isEqual:(id)object{
  
//  BOOL result = NO;
//  if (![object isKindOfClass:[TRStudent class]] || !object) {
//    result = NO;
//  }
//  
//  if (self == object) {
//    result = YES;
//  }
//  
//  TRStudent *student = object;
//  BOOL b_name = (!self.name && !student.name) || [self.name isEqual:student.name];
//  BOOL b_age = self.age == student.age;
//  result = b_name && b_age;
//  
//  DRLog(@"TRStudent isEqual..name:%d,age:%d,result:%d",b_name,b_age,result);
//  return result;
  
  return [self yy_modelIsEqual:object];
}

#pragma mark - < method >
#pragma mark * costom init
+(TRStudent *)studentWithName:(NSString *)name age:(NSInteger)age{

  return [[TRStudent alloc] initWithName:name age:age];
}

-(instancetype)initWithName:(NSString *)name age:(NSInteger)age{

  self = [super init];
  if (self) {
    self.name = name;
    self.age = age;
  }
  
  return self;
}

#pragma mark * compare
//按照姓名排序
-(NSComparisonResult)compareStudentWithName:(TRStudent*)student{
  return [self.name compare:student.name];//只能用于字符串比较，默认升序，暂时未知如何降序
}

//按照年龄排序(该方法更直观，如果要逆向输出，可以加负号或者大(小)于改为小(大)于)
-(NSComparisonResult)compareStudentWithAge:(TRStudent*)student{
  if (self.age<student.age) {//大小写只能用于数字比较，不能用于字符串比较
    return NSOrderedAscending;
  }else if(self.age>student.age) {
    return NSOrderedDescending;
  }
  
  return NSOrderedDescending;
}

//年龄一样的情况下，按照姓名排序
-(NSComparisonResult)compareStudentWithSameAge:(TRStudent*)student{
  if (self.age<student.age) {
    return NSOrderedAscending;
  }else if(self.age>student.age) {
    return NSOrderedDescending;
  }else if(self.age==student.age){
    return [self.name compare:student.name];
  }
  
  return NSOrderedDescending;
}

#pragma mark * other
-(void)studentRun{

  DRLog(@"TRStudent run..");
}

#pragma mark - < callback >
#pragma mark * NSCopying
-(id)copyWithZone:(NSZone *)zone{
  
//  TRStudent *person = [TRStudent new];
//  person.age = self.age;
//  person.name = self.name;
//  return person;
  
  return [self yy_modelCopy];
}
#pragma mark * NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder{
  
  DRLog(@"initWithCoder..");
  
//  self = [super init];
//  if (self) {
//    self.age = [aDecoder decodeIntegerForKey:@"age"];
//    self.name = [aDecoder decodeObjectForKey:@"name"];
//  }
//  return self;

  self = [super init];
  return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
  
  DRLog(@"encodeWithCoder..");
  
//  [aCoder encodeObject:_name forKey:@"name"];
//  [aCoder encodeInteger:_age forKey:@"age"];
  
  [self yy_modelEncodeWithCoder:aCoder];
}

#pragma mark * TRStudy
-(void)studentStudy{

  DRLog(@"TRStudent study...");
}

@end



#pragma mark - ******************** TRBook ********************
@implementation TRBook
#pragma mark - < overwrite >
#pragma mark * hash
-(NSUInteger)hash{
  
  return [self yy_modelHash];
}

-(BOOL)isEqual:(id)object{
  
  return [self yy_modelIsEqual:object];
}
#pragma mark - < method >
#pragma mark * custom init
-(instancetype)initWithName:(NSString *)name author:(NSString *)author price:(NSString *)price page:(NSInteger)page{
  
  self = [super init];
  if (self) {
    self.name = name;
    self.author = author;
    self.price = price;
    self.page = page;
  }
  
  return self;
}

#pragma mark - < callback >
#pragma mark * NSCoding
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
  
  self = [super init];
  return [self yy_modelInitWithCoder:aDecoder];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
  
  [self yy_modelEncodeWithCoder:aCoder];
}

@end

#pragma mark - ******************** TRSchool ********************
@implementation TRSchool
#pragma mark - < overwrite >
#pragma mark * hash
-(NSUInteger)hash{
  
  return [self yy_modelHash];
}

-(BOOL)isEqual:(id)object{
  
  return [self yy_modelIsEqual:object];
}

#pragma mark - < method >
#pragma mark * custom init
-(instancetype)initWithSchoolName:(NSString *)schoolName schoolCode:(NSInteger)schoolCode{
  
  self = [super init];
  if (self) {
    self.schoolName = schoolName;
    self.schoolCode = schoolCode;
  }
  return self;
}

#pragma mark - < callback >
#pragma mark * NSCoding
-(instancetype)initWithCoder:(NSCoder *)aDecoder{

  self = [super init];
  return [self yy_modelInitWithCoder:aDecoder];
}

-(void)encodeWithCoder:(NSCoder *)aCoder{

  [self yy_modelEncodeWithCoder:aCoder];
}
@end


#pragma mark - ******************** TRMidStudent ********************
@implementation TRMidStudent
#pragma mark - < method >
#pragma mark * other
+(NSArray *)testData{
  
  TRMidStudent *student = [TRMidStudent new];
  student.age = 12;
  student.name = @"Tom";
  
  TRBook *book1 = [[TRBook alloc] initWithName:@"西游记" author:@"a1" price:@"10" page:100];
  TRBook *book2 = [[TRBook alloc] initWithName:@"红楼梦" author:@"a2" price:@"20" page:200];
  TRBook *book3 = [[TRBook alloc] initWithName:@"三国演义" author:@"a3" price:@"30" page:300];
  TRBook *book4 = [[TRBook alloc] initWithName:@"水浒传" author:@"a4" price:@"40" page:400];
  student.books = @[book1,book2,book3,book4];
  
  TRSchool *school = [[TRSchool alloc] initWithSchoolName:@"一中" schoolCode:111];
  student.school = school;
  
  
  
  TRMidStudent *student1 = [TRMidStudent new];
  student1.age = 12;
  student1.name = @"Tom";
  
  TRBook *book5 = [[TRBook alloc] initWithName:@"西游记" author:@"a1" price:@"10" page:100];
  TRBook *book6 = [[TRBook alloc] initWithName:@"红楼梦" author:@"a2" price:@"20" page:200];
  TRBook *book7 = [[TRBook alloc] initWithName:@"三国演义" author:@"a3" price:@"30" page:300];
  TRBook *book8 = [[TRBook alloc] initWithName:@"水浒传" author:@"a4" price:@"40" page:400];
  student1.books = @[book5,book6,book7,book8];
  
  TRSchool *school1 = [[TRSchool alloc] initWithSchoolName:@"一中" schoolCode:111];
  student1.school = school1;
  
  return @[student,student1];
}

@end


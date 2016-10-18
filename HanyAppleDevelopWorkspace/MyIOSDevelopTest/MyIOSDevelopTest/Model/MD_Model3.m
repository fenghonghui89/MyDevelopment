//
//  MD_Model3.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Model3.h"
#import "MDRootDefine.h"


#pragma mark - ******************** TRPerson ********************
@implementation TRPerson

#pragma mark - < method >
+(TRPerson *)testData{
  
  TRPerson *person = [TRPerson new];
  person.age = 12;
  person.name = @"Tom";
  
  TRBook *book1 = [[TRBook alloc] initWithName:@"西游记" author:@"a1" price:@"10" page:@"100"];
  TRBook *book2 = [[TRBook alloc] initWithName:@"红楼梦" author:@"a2" price:@"20" page:@"200"];
  TRBook *book3 = [[TRBook alloc] initWithName:@"三国演义" author:@"a3" price:@"30" page:@"300"];
  TRBook *book4 = [[TRBook alloc] initWithName:@"水浒传" author:@"a4" price:@"40" page:@"400"];
  //  person.books = @[book1,book2,book3,book4];
  person.books = @{@"book1":book1,@"book2":book2,@"book3":book3,@"book4":book4};
  
  return person;
}

#pragma mark - < callback >
#pragma mark * NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
  
  DRLog(@"encodeWithCoder..");
  [aCoder encodeObject:_name forKey:@"name"];
  [aCoder encodeInteger:_age forKey:@"age"];
  [aCoder encodeObject:_books forKey:@"books"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
  
  DRLog(@"initWithCoder..");
  self = [super init];
  if (self) {
    self.age = [aDecoder decodeIntegerForKey:@"age"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.books = [aDecoder decodeObjectForKey:@"books"];
  }
  return self;
}


@end

#pragma mark - ******************** TRBook ********************
@implementation TRBook

-(instancetype)initWithName:(NSString *)name author:(NSString *)author price:(NSString *)price page:(NSString *)page{
  
  self = [super init];
  if (self) {
    self.name = name;
    self.author = author;
    self.price = price;
    self.page = page;
  }
  
  return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
  
  self = [super init];
  if (self) {
    _name = [aDecoder decodeObjectForKey:@"name"];
    _author = [aDecoder decodeObjectForKey:@"author"];
    _price = [aDecoder decodeObjectForKey:@"price"];
    _page = [aDecoder decodeObjectForKey:@"page"];
  }
  
  return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
  
  [aCoder encodeObject:_name forKey:@"name"];
  [aCoder encodeObject:_author forKey:@"author"];
  [aCoder encodeObject:_price forKey:@"price"];
  [aCoder encodeObject:_page forKey:@"page"];
}
@end


//
//  TRPerson.m
//  my02
//
//  Created by apple on 13-10-25.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

//2.实现协议规定的方法
#import "TRPerson.h"
#import "TRBook.h"

@implementation TRPerson

- (void)encodeWithCoder:(NSCoder *)aCoder{
  
  [aCoder encodeObject:_name forKey:@"name"];
  [aCoder encodeInteger:_age forKey:@"age"];
  [aCoder encodeObject:_books forKey:@"books"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
  self = [super init];
  if (self) {
    self.age = [aDecoder decodeIntegerForKey:@"age"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.books = [aDecoder decodeObjectForKey:@"books"];
  }
  return self;
}

+(TRPerson *)testData{

  TRPerson *person = [TRPerson new];
  person.age = 12;
  person.name = @"Tom";
  
  TRBook *book1 = [[TRBook alloc] initWithName:@"西游记" author:@"a1" price:@"10" page:@"100"];
  TRBook *book2 = [[TRBook alloc] initWithName:@"红楼梦" author:@"a2" price:@"20" page:@"200"];
  TRBook *book3 = [[TRBook alloc] initWithName:@"三国演义" author:@"a3" price:@"30" page:@"300"];
  TRBook *book4 = [[TRBook alloc] initWithName:@"水浒传" author:@"a4" price:@"40" page:@"400"];
  person.books = @[book1,book2,book3,book4];
  
  return person;
}
@end

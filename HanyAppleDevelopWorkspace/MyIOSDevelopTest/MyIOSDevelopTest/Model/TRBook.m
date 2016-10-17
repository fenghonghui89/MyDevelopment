//
//  TRBook.m
//  Day11SaxXML
//
//  Created by Tarena on 13-12-16.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRBook.h"

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

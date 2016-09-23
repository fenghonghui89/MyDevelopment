//
//  TRPerson.m
//  my02
//
//  Created by apple on 13-10-25.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

//2.实现协议规定的方法
#import "TRPerson.h"

@implementation TRPerson

- (void)encodeWithCoder:(NSCoder *)aCoder{
  [aCoder encodeObject:_name forKey:@"name"];
  [aCoder encodeInt:_age forKey:@"age"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
  self = [super init];
  if (self) {
    self.age = [aDecoder decodeIntForKey:@"age"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
  }
  return self;
}

@end

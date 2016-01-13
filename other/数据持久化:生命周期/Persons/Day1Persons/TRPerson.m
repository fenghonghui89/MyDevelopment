//
//  TRPerson.m
//  Day1ArchiverPerson
//
//  Created by Tarena on 13-12-2.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

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

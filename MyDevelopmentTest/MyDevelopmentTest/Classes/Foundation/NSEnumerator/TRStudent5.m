//
//  TRStudent.m
//  my02
//
//  Created by apple on 13-10-29.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRStudent5.h"

@implementation TRStudent5
-(NSString *)description{
    return [NSString stringWithFormat:@"name:%@ age:%d",self.name,self.age];
}

+(id)studentInitWithName:(NSString*)name AndAge:(int)age{
    TRStudent5* student = [[TRStudent5 alloc] initwithName:name AndAge:age];
    return student;
}
-(id)initwithName:(NSString*)name AndAge:(int)age{
    if (self == [super init]) {
        self.name = name;
        self.age = age;
    }
    return self;
}

@end

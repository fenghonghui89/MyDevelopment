//
//  TRStudent.m
//  my02
//
//  Created by apple on 13-10-30.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRStudent7.h"

@implementation TRStudent7

-(NSString *)description{
    return [NSString stringWithFormat:@"name:%@ age:%d",self.name,self.age];
}

+(id)studentInitWithName:(NSString*)name AndAge:(int)age{
    TRStudent7* student = [[TRStudent7 alloc] initwithName:name AndAge:age];
    return student;
}
-(id)initwithName:(NSString*)name AndAge:(int)age{
    if (self == [super init]) {
        self.name = name;
        self.age = age;
    }
    return self;
}

-(NSUInteger)hash//1.先比较对象的hash值（重写hash方法）
{
    return self.age;
}

-(BOOL)isEqual:(id)object//2.hash一样则用isEqual比较对象的类型关系和值是否一样
{
    NSLog(@"执行了isEqual");
    if (![object isKindOfClass:[TRStudent7 class]]) {//2.1先比较对象的类型关系
        return YES;
    }else {
        TRStudent7* tempStudent = object;//2.2再比较对象的值的关系
        if ([self.name isEqual:object]) {
            return YES;
        }else{
            return NO;
        }
    }
}


@end

//
//  TRStudent.m
//  my03
//
//  Created by apple on 13-10-29.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRStudent8.h"

@implementation TRStudent8

-(NSString *)description{
return [NSString stringWithFormat:@"name:%@ age:%d",self.name,self.age];
}

+(id)studentInitWithName:(NSString*)name AndAge:(int)age{
    TRStudent8* student = [[TRStudent8 alloc] initwithName:name AndAge:age];
    return student;
}
-(id)initwithName:(NSString*)name AndAge:(int)age{
    if (self == [super init]) {
        self.name = name;
        self.age = age;
    }
    return self;
}

-(NSUInteger)hash
{
    return self.age;
}

-(BOOL)isEqual:(id)object
{
    NSLog(@"执行了isEqual方法");
    if ([object isKindOfClass:[TRStudent8 class]]) {
        return YES;
    }else{
        TRStudent8* tempStudent = object;
        if ([tempStudent.name isEqual:object]) {
            return YES;
        }else {
            return NO;
        }
    }
}
@end

//
//  TRStudent.m
//  my05
//
//  Created by apple on 13-10-29.
//  Copyright (c) 2013年 Hany. All rights reserved.
//



#import "TRStudent6.h"

@implementation TRStudent6

-(id)copyWithZone:(NSZone*)zone{//2.深拷贝：重写copyWithZone方法
    return [[TRStudent6 alloc] initwithName:self.name AndAge:self.age];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"name:%@ age:%d",self.name,self.age];
}

+(id)studentInitWithName:(NSString*)name AndAge:(int)age{
    TRStudent6* student = [[TRStudent6 alloc] initwithName:name AndAge:age];
    return student;
}
-(id)initwithName:(NSString*)name AndAge:(int)age{
    if (self == [super init]) {
        self.name = name;
        self.age = age;
    }
    return self;
}

//按照姓名排序
-(NSComparisonResult)compareStudentWithName:(TRStudent6*)student{
    return [self.name compare:student.name];//只能用于字符串比较，默认升序，暂时未知如何降序
}

//按照年龄排序(该方法更直观，如果要逆向输出，可以加负号或者大(小)于改为小(大)于)
-(NSComparisonResult)compareStudentWithAge:(TRStudent6*)student{
    if (self.age<student.age) {//大小写只能用于数字比较，不能用于字符串比较
        return NSOrderedAscending;
    }else if(self.age>student.age) {
        return NSOrderedDescending;
    }
    
    return NSOrderedDescending;
}

//年龄一样的情况下，按照姓名排序
-(NSComparisonResult)compareStudentWithSameAge:(TRStudent6*)student{
    if (self.age<student.age) {
        return NSOrderedAscending;
    }else if(self.age>student.age) {
        return NSOrderedDescending;
    }else if(self.age==student.age){
        return [self.name compare:student.name];
    }
    
    return NSOrderedDescending;
}
@end

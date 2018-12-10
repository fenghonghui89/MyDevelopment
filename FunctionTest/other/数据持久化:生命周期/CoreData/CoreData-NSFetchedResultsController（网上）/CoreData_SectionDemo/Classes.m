//
//  Classes.m
//  CoreData_SectionDemo
//
//  Created by Ibokan on 14-1-10.
//  Copyright (c) 2014年 Zhang_Dinghui. All rights reserved.
//

#import "Classes.h"
#import "Student.h"


@implementation Classes

@dynamic name;
@dynamic id;
@dynamic students;

- (NSString *)description{
    return self.name;
}
@end

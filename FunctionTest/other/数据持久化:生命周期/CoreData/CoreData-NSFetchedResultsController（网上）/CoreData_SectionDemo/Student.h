//
//  Student.h
//  CoreData_SectionDemo
//
//  Created by Ibokan on 14-1-10.
//  Copyright (c) 2014年 Zhang_Dinghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Classes;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Classes *classes;

@end

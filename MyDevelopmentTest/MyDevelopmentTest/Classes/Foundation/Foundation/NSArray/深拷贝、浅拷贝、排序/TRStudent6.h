//
//  TRStudent.h
//  my05
//
//  Created by apple on 13-10-29.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRStudent6 : NSObject <NSCopying>//1.深拷贝：先遵守NSCopying协议

@property(nonatomic,copy)NSString* name;
@property(nonatomic,assign)int age;

+(id)studentInitWithName:(NSString*)name AndAge:(int)age;
-(id)initwithName:(NSString*)name AndAge:(int)age;

-(NSComparisonResult)compareStudentWithName:(TRStudent6*)student;
-(NSComparisonResult)compareStudentWithAge:(TRStudent6*)student;
-(NSComparisonResult)compareStudentWithSameAge:(TRStudent6*)student;
@end

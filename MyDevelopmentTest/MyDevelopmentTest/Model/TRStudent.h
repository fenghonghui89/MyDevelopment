//
//  TRStudent.h
//  my08
//
//  Created by apple on 13-10-26.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRStudent : NSObject
@property(nonatomic,assign) int age;
@property(nonatomic,copy)NSString *name;
-(void)study;
+(id)studentInitWithName:(NSString*)name AndAge:(int)age;
@end

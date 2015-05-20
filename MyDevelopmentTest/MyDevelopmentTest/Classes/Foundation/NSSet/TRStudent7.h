//
//  TRStudent.h
//  my02
//
//  Created by apple on 13-10-30.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRStudent7 : NSObject

@property(nonatomic,copy)NSString* name;
@property(nonatomic,assign)int age;

+(id)studentInitWithName:(NSString*)name AndAge:(int)age;
-(id)initwithName:(NSString*)name AndAge:(int)age;

@end

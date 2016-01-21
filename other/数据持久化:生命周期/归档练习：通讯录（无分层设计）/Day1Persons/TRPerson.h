//
//  TRPerson.h
//  Day1ArchiverPerson
//
//  Created by Tarena on 13-12-2.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPerson : NSObject<NSCoding>
@property (nonatomic,copy)NSString *name;
@property (nonatomic)int age;
@end

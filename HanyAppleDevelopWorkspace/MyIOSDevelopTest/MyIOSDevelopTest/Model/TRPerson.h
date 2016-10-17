//
//  TRPerson.h
//  my02
//
//  Created by apple on 13-10-25.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPerson : NSObject<NSCoding>//1.遵循协议
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,strong)NSArray *books;
+(TRPerson *)testData;
@end

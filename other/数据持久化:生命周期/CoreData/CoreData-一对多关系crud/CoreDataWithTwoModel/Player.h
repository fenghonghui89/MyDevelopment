//
//  Player.h
//  CoreDataWithTwoModel
//
//  Created by hanyfeng on 14-8-26.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//
@class Team;
#import <Foundation/Foundation.h>

@interface Player : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSNumber *age;
@property(nonatomic,strong)Team *team;
@end

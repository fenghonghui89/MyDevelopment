//
//  Player_MO.h
//  CoreDataWithTwoModel
//
//  Created by hanyfeng on 14-8-26.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team_MO;

@interface Player_MO : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) Team_MO *team_MO;

@end

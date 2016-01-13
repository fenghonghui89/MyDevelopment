//
//  Team_MO.h
//  CoreDataWithTwoModel
//
//  Created by hanyfeng on 14-8-26.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Team_MO : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSSet *players_MO;
@end

@interface Team_MO (CoreDataGeneratedAccessors)

- (void)addPlayers_MOObject:(NSManagedObject *)value;
- (void)removePlayers_MOObject:(NSManagedObject *)value;
- (void)addPlayers_MO:(NSSet *)values;
- (void)removePlayers_MO:(NSSet *)values;

@end

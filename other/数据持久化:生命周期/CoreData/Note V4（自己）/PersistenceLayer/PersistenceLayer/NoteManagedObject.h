//
//  NoteManagedObject.h
//  PersistenceLayer
//
//  Created by hanyfeng on 14-5-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteManagedObject : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;

@end

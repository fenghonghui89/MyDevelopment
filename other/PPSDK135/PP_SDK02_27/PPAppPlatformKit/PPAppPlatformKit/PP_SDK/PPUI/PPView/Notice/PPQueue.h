//
//  PPQueue.h
//  TestMarqueLabel
//
//  Created by Seven on 13-12-13.
//  Copyright (c) 2013年 1. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PPQueue : NSObject
{
    
    int _maxSize;
    int _head;
    int _rear;
    
    NSMutableArray *_dataArray;
}
@property(nonatomic,readonly,getter = isFull)BOOL full;
@property(nonatomic,readonly,getter = isEmpty)BOOL empty;


- (id)initWithSize:(int)size;

- (BOOL)enqueue:(NSObject *)object;

- (NSObject *)dequeue;

- (int)getQueueHead;

- (void)displayQueue;

- (void)releaseData;




@end

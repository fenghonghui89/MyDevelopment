//
//  PPQueue.m
//  TestMarqueLabel
//
//  Created by Seven on 13-12-13.
//  Copyright (c) 2013年 1. All rights reserved.
//

#import "PPQueue.h"
#import "PPAppPlatformKitConfig.h"

@implementation PPQueue

/**
 初始化一个默认长度的队列，默认长度是20
 */
- (id)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        _head = 0;
        _rear = 0;
        _maxSize = 20;
    }
    return self;
}
/**
 初始化一个指定长度的队列
 @param size 队列长度
 */
- (id)initWithSize:(int)size
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        _head = 0;
        _rear = 0;
        _maxSize = size;
    }
    return self;
}

/**
 入队
 @param object 将要加入队列的对象
 @return 是否入队成功
 */
- (BOOL)enqueue:(NSObject *)object{
    if (!self.full) {
        
        if ([_dataArray count] >= _maxSize) {
            [_dataArray replaceObjectAtIndex:_rear withObject:object];
        }
        else
        {
            [_dataArray addObject:object];
        }
        
        
        _rear = (_rear + 1) % _maxSize;
        return YES;
    }
    return NO;
}
/**
 出队
 @param object 将队头元素移出队列
 @return 移出队列的元素
 */
- (NSObject *)dequeue{
    if (!self.empty) {
        if (_head + 1 == _maxSize) {
            
            NSObject *object = [_dataArray objectAtIndex:_head];
            _head = 0;
//            [_dataArray removeObjectAtIndex:_maxSize - 1];
            return object;
        }
        
        
        NSObject *object = [_dataArray objectAtIndex:_head];
        _head ++;
//        [_dataArray removeObjectAtIndex:_head - 1];
        return object;
    }
    return nil;
}

- (int)getQueueHead{
    return _head;
}

//- (int)getQueueLength{
//    return _rear - _head;
//}

- (BOOL)isEmpty{
    if (_head == _rear) {
        return YES;
    }
    return NO;
}

- (BOOL)isFull{
    if ((_rear + 1) % _maxSize == _head) {
        return YES;
    }
    return NO;
}

- (void)displayQueue{
    if (!self.isEmpty) {
        for (int i = _head; i != _rear; i = (i + 1) % _maxSize) {
//            if (PP_ISNSLOG) {
                NSLog(@"-------rear = %@",[[_dataArray objectAtIndex:i] description]);
//            }

        }
    }
    
}

- (void)releaseData
{
    [_dataArray removeAllObjects];
    _head = 0;
    _rear = 0;
    
}

- (void)dealloc
{
    NSLog(@"queue dealloc");
    [_dataArray release];
    _dataArray = nil;
    [super dealloc];
}

@end

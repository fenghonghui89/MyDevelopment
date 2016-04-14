/*	NSLock.h
	Copyright (c) 1994-2015, Apple Inc. All rights reserved.
*/

#import <Foundation/NSObject.h>

@class NSDate;

NS_ASSUME_NONNULL_BEGIN

@protocol NSLocking

- (void)lock;
- (void)unlock;

@end

@interface NSLock : NSObject <NSLocking> {
@private
    void *_priv;
}

- (BOOL)tryLock;//试图获取锁并返回结果
- (BOOL)lockBeforeDate:(NSDate *)limit;//阻塞到传入的NSDate日期为止

@property (nullable, copy) NSString *name NS_AVAILABLE(10_5, 2_0);

@end

@interface NSConditionLock : NSObject <NSLocking> {
@private
    void *_priv;
}

- (instancetype)initWithCondition:(NSInteger)condition NS_DESIGNATED_INITIALIZER;//初始化一个条件锁并写上条件

@property (readonly) NSInteger condition;
- (void)lockWhenCondition:(NSInteger)condition;//如果没有其他线程获得该锁，且条件等于condition，则获得该锁
- (BOOL)tryLock;
- (BOOL)tryLockWhenCondition:(NSInteger)condition;
- (void)unlockWithCondition:(NSInteger)condition;//解锁并把条件设置为condition
- (BOOL)lockBeforeDate:(NSDate *)limit;
- (BOOL)lockWhenCondition:(NSInteger)condition beforeDate:(NSDate *)limit;

@property (nullable, copy) NSString *name NS_AVAILABLE(10_5, 2_0);

@end

@interface NSRecursiveLock : NSObject <NSLocking> {
@private
    void *_priv;
}

- (BOOL)tryLock;
- (BOOL)lockBeforeDate:(NSDate *)limit;

@property (nullable, copy) NSString *name NS_AVAILABLE(10_5, 2_0);

@end



NS_CLASS_AVAILABLE(10_5, 2_0)
@interface NSCondition : NSObject <NSLocking> {
@private
    void *_priv;
}

- (void)wait;//阻塞，直到收到signal的信号
- (BOOL)waitUntilDate:(NSDate *)limit;//直到收到信号或到期之前都阻塞
- (void)signal;//发信息给wait的锁，一个信号解一个wait，没有wait则不做任何事
- (void)broadcast;//发信号给所有wati

@property (nullable, copy) NSString *name NS_AVAILABLE(10_5, 2_0);

@end

NS_ASSUME_NONNULL_END

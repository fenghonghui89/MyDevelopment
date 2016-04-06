//
//  KeyChainStore.h
//  KeychainTest0
//
//  Created by 冯鸿辉 on 16/4/5.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject

//增
+ (void)add:(NSString *)service data:(id)data;
+ (void)add:(NSString *)service password:(NSString *)password userName:(NSString *)userName;
//查
+ (id)find:(NSString *)service;

//删
+ (void)deleteKeyData:(NSString *)service;

//改
+(void)updateKeyData:(NSString *)service data:(id)data;


@end

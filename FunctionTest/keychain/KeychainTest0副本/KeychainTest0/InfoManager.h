//
//  UUID.h
//  KeychainTest0
//
//  Created by 冯鸿辉 on 16/4/5.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoManager : NSObject

+(NSString *)findInfo:(NSString *)service;
+(void)addInfo:(NSString *)data service:(NSString *)service;
+(void)updateInfo:(NSString *)data service:(NSString *)service;
+(void)deleteInfo:(NSString *)service;
@end

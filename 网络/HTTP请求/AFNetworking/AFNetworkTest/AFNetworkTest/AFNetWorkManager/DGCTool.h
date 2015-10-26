//
//  DGCTool.h
//  AFNetworkTest
//
//  Created by hanyfeng on 15/10/26.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGCTool : NSObject
+ (BOOL)cureentThreadIsMain;
+(NSString *)md5:(NSString *)str;
@end

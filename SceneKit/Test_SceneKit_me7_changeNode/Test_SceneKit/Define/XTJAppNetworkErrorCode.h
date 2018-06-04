//
//  XTJAppNetworkErrorCode.h
//  BJ3DProject
//
//  Created by hanyfeng on 2018/5/16.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTJAppNetworkCodeDefine.h"
@interface XTJAppNetworkErrorCode : NSObject
+(XTJNetwrokResponseCode)changeErrorCode:(NSString *)errorCode;
@end

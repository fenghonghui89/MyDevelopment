//
//  DGCDelegateInfo.h
//  AFNetworkTest
//
//  Created by hanyfeng on 15/10/26.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDDefine.h"
#define DGC_DELEGATE_INFO_KEY @"DelegateInfo"
@interface DGCDelegateInfo : NSObject
@property (nonatomic,weak)id delegate;
@property (nonatomic,assign)DGCRequestCode code;
@property (nonatomic,strong)NSDictionary * info;
@end

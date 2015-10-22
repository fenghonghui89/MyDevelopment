//
//  AFNetworkManager.h
//  AFNetworkTest
//
//  Created by hanyfeng on 15/9/28.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetworkManager : NSObject
+(AFNetworkManager *)share;
-(void)request;
@end

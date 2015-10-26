//
//  ReachabilityManager.h
//  NetWorkTest
//
//  Created by hanyfeng on 15/9/18.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ReachabilityNetworkType) {
    ReachabilityNetworkTypeNotReachable                        = 1,//无网络
    
    ReachabilityNetworkTypeReachableViaWiFi                    = 2,//只wifi--无Host
    ReachabilityNetworkTypeReachableViaWiFiAndNotReachableHost = 3,//有wifi  && Host
    
    ReachabilityNetworkTypeReachableViaWWAN                    = 4,//只有3G,4G--无Host
    ReachabilityNetworkTypeReachableViaWWANAndNotReachableHost = 5,//有3G,4G && Host
    
    ReachabilityNetworkTypeReachableViaWiFiAndReachableViaWWAN = 6,//wifi,3G,4G--无Host
    ReachabilityNetworkTypeReachableAll                        = 7,//wifi,3G,4G,Host
};

//监听域名
static  NSString * remoteHostName = @"www.baidu.com";
@interface ReachabilityManager : NSObject
@property (nonatomic,assign)ReachabilityNetworkType networkType; //请监听这个值的变化

+ (instancetype)share;
/**
 *  开启监听网络链接情况,可以设置reachabilityHostname为官方网站
 *
 *  @return YES/NO
 */
- (BOOL)startListenNetworkLink;

/**
 *  关闭监听网络链接情况
 */
- (void)stopListenNetworkLink;

/**
 *  清除ReachabilityManager缓存
 */
- (void)clearCache;
@end

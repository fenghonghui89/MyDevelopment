//
//  ReachabilityManager.m
//  NetWorkTest
//
//  Created by hanyfeng on 15/9/18.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "ReachabilityManager.h"
#import "Reachability.h"
@interface ReachabilityManager()
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic,assign)NetworkStatus hostNetworkStatus;

@property (nonatomic) Reachability *internetReachability;
@property (nonatomic,assign)NetworkStatus internetNetworkStatus;

@property (nonatomic) Reachability *wifiReachability;
@property (nonatomic,assign)NetworkStatus wifiNetworkStatus;
@end
@implementation ReachabilityManager

+(ReachabilityManager *)share
{
    static ReachabilityManager *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self addReachabilityNotification];
        
        self.hostNetworkStatus = NotReachable;
        self.hostReachability = [Reachability reachabilityWithHostname:remoteHostName]; //检测和服务器的链接变化
        
        self.internetNetworkStatus = NotReachable;
        self.internetReachability = [Reachability reachabilityForInternetConnection]; //检测3G，4G网变化

        self.wifiNetworkStatus = NotReachable;
        self.wifiReachability = [Reachability reachabilityForLocalWiFi]; //检测本地WIFI变化
    }
    return self;
}

/**
 *  清除ReachabilityManager缓存
 */
- (void)clearCache
{
    [self stopListenNetworkLink];
    self.hostReachability = nil;
    self.internetReachability = nil;
    self.wifiReachability = nil;
    [self removeReachabilityNotification];
}

#pragma mark - < Notification > -

- (void)addReachabilityNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
}

- (void)removeReachabilityNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* reachability = [note object];
    NSParameterAssert([reachability isKindOfClass:[Reachability class]]);
    [self handleReachabilityStatus:reachability];
}

#pragma mark - < Start && Stop > -

/**
 *  开启监听网络链接情况,可以设置reachabilityHostname为官方网站
 *
 *  @return YES/NO
 */
- (BOOL)startListenNetworkLink
{
    BOOL hostFlag = [self.hostReachability startNotifier];
    BOOL internetFlag = [self.internetReachability startNotifier];
    BOOL wifiFlag = [self.wifiReachability startNotifier];
    
    [self handleReachabilityStatus:self.wifiReachability];
    [self handleReachabilityStatus:self.internetReachability];
    [self handleReachabilityStatus:self.hostReachability];
    
    return hostFlag && internetFlag && wifiFlag;
    
//    BOOL hostFlag = [self.hostReachability startNotifier];
//    [self handleReachabilityStatus:self.hostReachability];
//    return hostFlag;
    
//    BOOL internetFlag = [self.internetReachability startNotifier];
//    [self handleReachabilityStatus:self.internetReachability];
//    return internetFlag;
    
//    BOOL wifiFlag = [self.wifiReachability startNotifier];
//    [self handleReachabilityStatus:self.wifiReachability];
//    return wifiFlag;
}

/**
 *  关闭监听网络链接情况
 */
- (void)stopListenNetworkLink
{
    [self.hostReachability stopNotifier];
    [self.internetReachability stopNotifier];
    [self.wifiReachability stopNotifier];
}

#pragma mark - < 处理网络变化 > -

- (void)handleReachabilityStatus:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    if (reachability == self.hostReachability) {
        self.hostNetworkStatus = netStatus;
        NSLog(@"host netStatus:%@ %d",reachability,netStatus);
    }else if (reachability == self.internetReachability) {
        self.internetNetworkStatus = netStatus;
        NSLog(@"int netStatus:%@ %d",reachability,netStatus);
    }else if (reachability == self.wifiReachability){
        self.wifiNetworkStatus = netStatus;
        NSLog(@"wifi netStatus:%@ %d",reachability,netStatus);
    }
    
    switch (self.wifiNetworkStatus) {
        case NotReachable:{
            switch (self.internetNetworkStatus) {
                case NotReachable:{
                    self.networkType = ReachabilityNetworkTypeNotReachable;
                    break;
                }
                case ReachableViaWWAN:{
                    if (self.hostNetworkStatus == NotReachable) {
                        self.networkType = ReachabilityNetworkTypeReachableViaWWAN;
                    }else{
                        self.networkType = ReachabilityNetworkTypeReachableViaWWANAndNotReachableHost;
                    }
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case ReachableViaWWAN:{
            switch (self.internetNetworkStatus) {
                case NotReachable:{
                    self.networkType = ReachabilityNetworkTypeNotReachable;
                    break;
                }
                case ReachableViaWWAN:{
                    if (self.hostNetworkStatus == NotReachable) {
                        self.networkType = ReachabilityNetworkTypeReachableViaWWAN;
                    }else{
                        self.networkType = ReachabilityNetworkTypeReachableViaWWANAndNotReachableHost;
                    }
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case ReachableViaWiFi:{
            switch (self.internetNetworkStatus) {
                case NotReachable:{
                    if (self.hostNetworkStatus == NotReachable) {
                        self.networkType = ReachabilityNetworkTypeReachableViaWiFi;
                    }else{
                        self.networkType = ReachabilityNetworkTypeReachableViaWiFiAndNotReachableHost;
                    }
                    break;
                }
                case ReachableViaWWAN:{
                    if (self.hostNetworkStatus == NotReachable) {
                        self.networkType = ReachabilityNetworkTypeReachableViaWiFiAndReachableViaWWAN;
                    }else{
                        self.networkType = ReachabilityNetworkTypeReachableAll;
                    }
                    break;
                }
                case ReachableViaWiFi:{
                    if (self.hostNetworkStatus == NotReachable) {
                        self.networkType = ReachabilityNetworkTypeReachableViaWiFi;
                    }else{
                        self.networkType = ReachabilityNetworkTypeReachableViaWiFiAndNotReachableHost;
                    }
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

@end

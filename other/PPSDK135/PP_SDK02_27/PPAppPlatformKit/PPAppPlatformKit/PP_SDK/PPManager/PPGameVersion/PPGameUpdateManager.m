//
//  PPGameUpdateManager.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-28.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPGameUpdateManager.h"
#import "PPAppPlatformKit.h"

@implementation PPGameUpdateManager


+ (id)defaultPPGameUpdateManager
{
    PPGameUpdateManager *request = [[[PPGameUpdateManager alloc] init] autorelease];
    return request;
}
- (void)setDelegate:(id<PPGameUpdateManagerDelegate>)delegate
{
    if (_delegate) {
        [_delegate release];
        _delegate = nil;
    }
    
    if (delegate) {
        _delegate = [delegate retain];
    }
}

- (void)cancel
{
    if (_delegate) {
        [_delegate release];
        _delegate = nil;
    }
    
    if (_conn) {
        [_conn cancel];
        [_conn release];
        _conn = nil;
    }
}
#pragma mark - 检查版本更新 -
/**
 *  检查版本更新
 *
 *  @param delegate 代理
 */
- (void)ppRequestGameVersionWithDelegate:(id<PPGameUpdateManagerDelegate>)delegate
{
    [self cancel];
    [self setDelegate:delegate];
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    TRBuffer *buff = [TRBuffer defaultTRBuffer];
    _conn = [[TRHTTPConnection defaultHTTPConnection] retain];

    
    int appid = [[PPAppPlatformKit sharedInstance] appId];
    NSString *bundleid = [infoDict objectForKey:@"CFBundleIdentifier"];
    NSString *version = [infoDict objectForKey:@"CFBundleVersion"];
    
    [buff writeInt32:IH_REQ_QUR_GAMEUPDATE];
    [buff writeInt32:appid];
    [buff writeString:bundleid];
    [buff writeString:version];
    [buff writeLen];
    
    [_conn sendPost:GAMEUPDATE_REQUEST_URL buff:buff userInfo:nil delegate:self];
    if (PP_ISNSLOG) {
        printf("---------------------\n");
        NSLog(@"请求检测更新的地址:   %@ ",  GAMEUPDATE_REQUEST_URL);
        NSLog(@"请求的数据：{ appid:%d,bundleid:%@,version:%@ }",appid,bundleid,version);
        //    for (int i=0; i<buff.bufferLen; i++) {
        //        printf("%02x ",  (unsigned char)buff.body[i]);
        //    }
        printf("---------------------\n");
    }
    
}

#pragma mark -  TRHTTPConnectionDelegate -

- (void)didFinishConnection:(TRHTTPConnection *)conn data:(NSData *)data userInfo:(NSMutableDictionary *)userInfo
{
    id<PPGameUpdateManagerDelegate> delegate = nil;
    if (_delegate)
        delegate = [_delegate retain];
    
    [self cancel];
    if (delegate)
    {
        TRBuffer *buff = [[[TRBuffer alloc] initWithBuffNoCopy:(char*)data.bytes] autorelease];
        //len
        [buff readInt32];
        int commmand = [buff readInt32];
        if (commmand == IH_REQ_QUR_GAMEUPDATE )
        {
            //如果有新版本，则继续读下面的内容
            UpdateStatus status = [buff readInt16];
            if (PP_ISNSLOG) {
                NSLog(@"请求检测新版本的返回的状态-------%d",status);
            }
            PPGameVersion *gameVersion = [[PPGameVersion alloc] init];
            
            [gameVersion setStatus:status];
            if (status == IH_E_UPDATE)
            {
                int isUpdateForce = [buff readInt8];
                int appid = [buff readInt32];
                NSString *version = [buff readString];
                NSString *downloadUrl = [buff readString];
                NSString *artWorkUrl = [buff readString];
                NSString *artWorkUrl108 = [buff readString];
                NSString *newestIpaDescription = [buff readString];
                
                NSMutableArray *historyVersionArray = [[[NSMutableArray alloc] init] autorelease];
                int len = [buff readInt32];
                for (int i = 0; i < len; i++) {
                    NSMutableDictionary *historyVersionDic = [[NSMutableDictionary alloc] init];
                    NSString *historyVersion = [buff readString];
                    NSString *updateDescription = [buff readString];
                    [historyVersionDic setValue:historyVersion forKey:@"historyVersion"];
                    [historyVersionDic setValue:updateDescription forKey:@"updateDescription"];
//                    [historyVersionArray insertObject:historyVersionDic atIndex:0];
                    [historyVersionArray addObject:historyVersionDic];
                    [historyVersionDic release];
                }
                
                [gameVersion setIsUpdateForce:isUpdateForce];
                [gameVersion setAppId:appid];
                [gameVersion setVersion:version];
                [gameVersion setDownloadUrl:downloadUrl];
                [gameVersion setArtWorkUrl:artWorkUrl];
                [gameVersion setArtWorkUrl108:artWorkUrl108];
                [gameVersion setNewestIpaDescription:newestIpaDescription];
                [gameVersion setHistoryVersionArray:historyVersionArray];
                
                if (PP_ISNSLOG) {
                    NSLog(@"游戏新版本的信息appid-------%d",gameVersion.appId);
                    NSLog(@"游戏新版本的信息version-------%@",gameVersion.version);
                    NSLog(@"游戏新版本的信息downloadUrl-------%@",gameVersion.downloadUrl);
                    NSLog(@"游戏新版本的信息artWorkUrl-------%@",gameVersion.artWorkUrl);
                    NSLog(@"游戏新版本的信息artWorkUrl108-------%@",gameVersion.artWorkUrl108);
                    NSLog(@"游戏新版本的信息newestIpaDescription-------%@",gameVersion.newestIpaDescription);
                    NSLog(@"游戏新版本的信息historyVersionArray-------%@",gameVersion.historyVersionArray);
                }
            }
            else
            {
                
            }
            
            if ([delegate respondsToSelector:@selector(didSuccessGetGameUpdateInfoCallBack:)])
            {
                [delegate didSuccessGetGameUpdateInfoCallBack:gameVersion];
            }
            [gameVersion release];
        }
        [delegate release];
    }
}

- (void)didFailConnection:(TRHTTPConnection*)conn errorCode:(TRHTTPConnectionError)errorCode userInfo:(NSMutableDictionary *)userInfo
{
    id<PPGameUpdateManagerDelegate> delegate = nil;
    if (_delegate)
        delegate = [_delegate retain];
    
    [self cancel];
    
    if (delegate) {
        if ([delegate respondsToSelector:@selector(didFailRequestConnectionCallBack:userInfo:)]) {
            [delegate didFailRequestConnectionCallBack:errorCode userInfo:userInfo];
        }
        [delegate release];
    }
}



#pragma mark - Dealloc -
- (void)dealloc
{
    //    NSLog(@"DEALLOC: %@", [self class]);
    
    [self cancel];
    
    [super dealloc];
}



@end

//
//  PPHttpRequest.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-9.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <Foundation/Foundation.h>



@class PPHttpRequest;

/**
 * @protocol   PPAppPlatformKitDelegate
 * @brief   Http接口回调协议
 */
@protocol PPHttpRequestDelegate <NSObject>

/**
 * @brief   接口响应数据
 * @param   INPUT   paramDic       接口字典数据
 * @return  无返回
 */
- (void)ppHttpResponseCallBack:(NSDictionary *)paramDic;


/**
 * @brief   接口错误响应
 * @param   INPUT   paramDic       错误编码
 * @return  无返回
 */
- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError;

@end

@interface PPHttpRequest : NSObject
<
NSURLConnectionDelegate,
NSURLConnectionDataDelegate
>
{
    NSMutableData *_recvData;
}

@property (nonatomic, assign) id<PPHttpRequestDelegate> delegate;


- (void)sendRequest:(NSMutableURLRequest *)paramRequest;

@end

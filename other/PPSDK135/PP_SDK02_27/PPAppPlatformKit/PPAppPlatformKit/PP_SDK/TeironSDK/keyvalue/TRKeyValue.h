//
//  TRKeyValue.h
//  TestSDK
//
//  Created by chenjunhong on 13-6-6.
//  Copyright (c) 2013年 Jun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TeironSDK/net/TRHTTPConnection.h>

//KeyValue请求的URL地址
//static NSString * const KEYVALUE_REQUEST_URL = @"http://ppcloud.25pp.com:8008/i";
static NSString * const KEYVALUE_REQUEST_URL = @"http://ppcloud.25pp.com/i";


//KeyValue相关指令
typedef enum {
    KeyValueRequestAddKey                          = 0x00003020,       //新增key
    KeyValueRequestUpdValue                        = 0x00003021,       //修改value
    KeyValueRequestDelKey                          = 0x00003022,       //删除key
    KeyValueRequestGetValue                        = 0x00003023,       //取回value
    KeyValueRequestGetStamp                        = 0x00003024        //取回key的最后修改时间
} SDKKeyValueRequestCommmand;

//KeyValue全局错误码
typedef enum {
    SDKKeyValueRequestSuccess                      = 0,            //成功
    SDKKeyValueRequestTest                         = 1,            //测试
    SDKKeyValueRequestErrorStoreDataFailed         = 2,            //存储失败/服务器内部错误
    SDKKeyValueRequestErrorDataNotExsits           = 3,            //数据不存在
    SDKKeyValueRequestErrorDataInvalid             = 4,            //无效数据
    SDKKeyValueRequestErrorDatahashInvalid         = 5,            //无效指纹
    SDKKeyValueRequestErrorDataIsExsits            = 6,            //数据已存在
    SDKKeyValueRequestErrorKeyInvalid              = 7,            //无效key
    SDKKeyValueRequestErrorValueInvalid            = 8             //无效value
} SDKKeyValueRequestErrorCode;

//统计相关指令
typedef enum {
    DeviceLoginRecords                       = 0x00000001,       //设备登录记录
} SDKKeyValueBusinessCommmand;


@class TRKeyValueRequest;
@protocol TRKeyValueRequestDelegate <NSObject>

@optional

/**
 * @description 请求失败回调（通信层）
 * @param errorCode: TRHTTPConnectionError
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didFailRequestKeyValueConnection:(TRKeyValueRequest*)tRCountRequest
                               errorCode:(TRHTTPConnectionError)errorCode
                                userInfo:(NSMutableDictionary*)userInfo;


/**
 * @description 请求业务异常回调（业务层）
 * @param errorCode: SDKCountErrorCode
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didFailRequestKeyValue:(TRKeyValueRequest*)tRCountRequest
                     errorCode:(SDKKeyValueRequestErrorCode)errorCode
                      commmand:(SDKKeyValueRequestCommmand)commmand
                      userInfo:(NSMutableDictionary*)userInfo;

/**
 * @description 请求新增key成功回调
 * @param valueId: valueId
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didSuccessRequestAddKey:(TRKeyValueRequest*)tRKeyValueRequest
                        valueId:(unsigned long long)valueId
                       userInfo:(NSMutableDictionary*)userInfo;

/**
 * @description 请求修改value成功回调
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didSuccessRequestUpdValue:(TRKeyValueRequest*)tRKeyValueRequest
                         userInfo:(NSMutableDictionary*)userInfo;

/**
 * @description 请求删除key成功回调
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didSuccessRequestDelKey:(TRKeyValueRequest*)tRKeyValueRequest
                       userInfo:(NSMutableDictionary*)userInfo;

/**
 * @description 请求取回value成功回调
 * @param keyId: keyId 
 * @param key: key
 * @param valueDataList: valueDataList
 * @param lastModify: 最后修改时间 
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didSuccessRequestGetValue:(TRKeyValueRequest*)tRKeyValueRequest
                            keyId:(unsigned long long)keyId
                              key:(NSData*)key
                    valueDataList:(NSArray*)valueDataList
                       lastModify:(unsigned int)lastModify
                         userInfo:(NSMutableDictionary*)userInfo;

/**
 * @description 请求取回key最后修改时间成功回调
 * @param keyId: keyId
 * @param key: key
 * @param lastModify: 最后修改时间
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didSuccessRequestGetStamp:(TRKeyValueRequest*)tRKeyValueRequest
                            keyId:(unsigned long long)keyId
                              key:(NSData*)key
                       lastModify:(unsigned int)lastModify
                         userInfo:(NSMutableDictionary*)userInfo;

@optional

@end

@interface TRKeyValueRequest : NSObject
<TRHTTPConnectionDelegate>
{
    id<TRKeyValueRequestDelegate> _delegate;
    TRHTTPConnection *_conn;

}

+ (id)defaultTRKeyValueRequest;
/**
 * @description 取消请求
 */
- (void)cancel;

/**
 * @description 请求新增key
 * @param key: key
 * @param value: value
 * @param flag: flag (0 默认 | 1 允许添加重复的value)
 * @param timeOut: 请求超时时间（<=0使用默认值）
 * @param userInfo: 自定义数据，回调时返回
 * @param delegate: 委托对象（强引用，引用数+1）
 */
- (void)requestAddKey:(NSData*)key
                value:(NSData*)value
                 flag:(short)flag
              timeOut:(NSTimeInterval)timeOut
             userInfo:(NSMutableDictionary*)userInfo
             delegate:(id<TRKeyValueRequestDelegate>)delegate;

/**
 * @description 请求修改value
 * @param key: key
 * @param valueId: valueId
 * @param value: value
 * @param flag: flag (0 默认 | 1 允许添加重复的value)
 * @param timeOut: 请求超时时间（<=0使用默认值）
 * @param userInfo: 自定义数据，回调时返回
 * @param delegate: 委托对象（强引用，引用数+1）
 */
- (void)requestUpdValue:(NSData*)key
                valueId:(unsigned long long)valueId
                  value:(NSData*)value
                   flag:(short)flag
                timeOut:(NSTimeInterval)timeOut
               userInfo:(NSMutableDictionary*)userInfo
               delegate:(id<TRKeyValueRequestDelegate>)delegate;

/**
 * @description 请求删除key
 * @param key: key
 * @param valueId: valueId
 * @param flag: flag（0:只删除valueId的数据 1:删除key下面的全部数据）
 * @param timeOut: 请求超时时间（<=0使用默认值）
 * @param userInfo: 自定义数据，回调时返回
 * @param delegate: 委托对象（强引用，引用数+1）
 */
- (void)requestDelKey:(NSData*)key
              valueId:(unsigned long long)valueId
                 flag:(short)flag
              timeOut:(NSTimeInterval)timeOut
             userInfo:(NSMutableDictionary*)userInfo
             delegate:(id<TRKeyValueRequestDelegate>)delegate;

/**
 * @description 请求取回value
 * @param key: key
 * @param flag: flag (0)
 * @param timeOut: 请求超时时间（<=0使用默认值）
 * @param userInfo: 自定义数据，回调时返回
 * @param delegate: 委托对象（强引用，引用数+1）
 */
- (void)requestGetValue:(NSData*)key
                   flag:(short)flag
                timeOut:(NSTimeInterval)timeOut
               userInfo:(NSMutableDictionary*)userInfo
               delegate:(id<TRKeyValueRequestDelegate>)delegate;


/**
 * @description 请求取回key最后修改时间
 * @param key: key
 * @param flag: flag (0)
 * @param timeOut: 请求超时时间（<=0使用默认值）
 * @param userInfo: 自定义数据，回调时返回
 * @param delegate: 委托对象（强引用，引用数+1）
 */
- (void)requestGetStamp:(NSData*)key
                   flag:(short)flag
                timeOut:(NSTimeInterval)timeOut
               userInfo:(NSMutableDictionary*)userInfo
               delegate:(id<TRKeyValueRequestDelegate>)delegate;


@end


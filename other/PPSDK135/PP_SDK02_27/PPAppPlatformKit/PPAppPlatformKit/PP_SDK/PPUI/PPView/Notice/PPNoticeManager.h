//
//  PPNoticeManager.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-25.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TeironSDK/net/TRHTTPConnection.h>
#import <TeironSDK/user/TRUserRequest.h>
#import "PPNotice.h"

//static NSString * const NOTI_REQUEST_URL = @"http://passport_i.25pp.com:8008/i";
static NSString * const NOTI_REQUEST_URL = @"http://passport_i.25pp.com/i";


////消息类型
//typedef enum {
//    MessageTypeOfNoti                            = 1,        //公告
//    MessageTypeOfEmail                           = 2,        //邮件
//} MessageType;


//消息类型
typedef enum {
    IH_REQ_QUR_MESSAGE					= 0xFEC00020, //查询信息
    IH_REQ_GET_MESSAGE					= 0xFEC00021, //获取信息
    IH_REQ_SET_MESSAGE					= 0xFEC00022, //设置信息
    IH_REQ_DEL_MESSAGE					= 0xFEC00023, //删除信息
} MessageCommand;


//用户系统全局错误码
typedef enum {
	IH_E_OK                             = 0,	//正常
	IH_E_MESSSGE_NOT_EXIST				= 1,	//信息不存在或无信息
	IH_E_NEGATIVE_VALUE                 = 8,	//无效的请求数据
	IH_E_INVALID_USER_TOKEN				= 18,	//无效的用户token，需重新登陆再次发送处理
} MessageStatus;


//typedef enum {
//    page_count					= 20, //查询信息
//} MessageCommand1;




@class PPNoticeManager;
@protocol PPNoticeManagerDelegate <NSObject>
@optional
/**
 *  成功 获取到Push信息
 *
 *  @param paramMessageCount 信息条数
 *  @param paramPageCount    页数
 *  @param paramItemArray    数据
 */
- (void)didSuccessGetMessageCallBack:(int)paramMessageCount
                               Pages:(int)paramPageCount
                           ItemArray:(NSMutableArray *)paramItemArray;

- (void)didSuccessGetMessageCallBack:(PPNotice *)paramPPNotice;

- (void)didSuccessSetMessageCallBack;


- (void)didSuccessDelMessageCallBack;

- (void)didFailGetMessageCallBack:(MessageStatus)status;

- (void)didSuccessQurMessageCallBack:(PPNotice *)paramPPNotice;

/**
 * @description 请求失败回调（通信层）
 * @param errorCode: TRHTTPConnectionError
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didFailRequestConnectionCallBack:(PPNoticeManager *)ppNoticeManager
                       errorCode:(TRHTTPConnectionError)errorCode
                        userInfo:(NSMutableDictionary*)userInfo;





@end

@interface PPNoticeManager : NSObject<TRHTTPConnectionDelegate,TRUserRequestDelegate>
{
    id<PPNoticeManagerDelegate> _delegate;
    TRHTTPConnection *_conn;
}
@property (nonatomic,retain) NSString *noticePath;




- (void)ppRequestCheckNewMessage:(int)paramClient_flags
                           Token:(char *)paramToken_key
                            Type:(MessageType)paramMessageType
                        delegate:(id<PPNoticeManagerDelegate>)delegate;

- (void)ppRequestGetMessage:(int)paramClient_flags
                      Token:(char *)paramToken_key Type:(MessageType)paramMessageType
                   CurrPage:(int)paramCurrPage
                   delegate:(id<PPNoticeManagerDelegate>)delegate;


- (void)ppRequestSetMessage:(int)paramClient_flags
                      Token:(char *)paramToken_key
               EmailIdArray:(NSArray *)paramEmailIdArray
                     IsRead:(BOOL)paramIsRead
                   delegate:(id<PPNoticeManagerDelegate>)delegate;


- (void)ppRequestDelMessage:(int)paramClient_flags
                      Token:(char *)paramToken_key
               EmailIdArray:(NSArray *)paramEmailIdArray
                   delegate:(id<PPNoticeManagerDelegate>)delegate;

- (NSMutableArray *)getAllNotice;

- (void)deleteNotice:(PPNotice *)paramPPNotice;

- (void)updateNotice:(PPNotice *)paramPPNotice;

- (void)deleteNoticeArray:(NSArray *)paramPPNoticeArray;

- (void)updateNoticeArray:(NSArray *)paramPPNoticeArray;

@end

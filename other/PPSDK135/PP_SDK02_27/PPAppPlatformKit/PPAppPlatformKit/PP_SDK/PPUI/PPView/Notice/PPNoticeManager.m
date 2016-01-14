//
//  PPNoticeManager.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-25.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPNoticeManager.h"
#import <TeironSDK/net/TRBuffer.h>
#import "PPAppPlatformKit.h"
#import "PPCommon.h"

@implementation PPNoticeManager







/**
 * 请求获取最新的邮件  [60秒时间间隔请求]
 * @param paramClient_flags: 备用字段，默认0
 * @param paramToken_key:   Token
 * @param paramMessageType: 信息类型   1为公告,2为邮件
 * @param delegate: 委托对象（强引用，引用数+1）
 * @returns 无
 * @exception
 */
- (void)ppRequestCheckNewMessage:(int)paramClient_flags
                      Token:(char *)paramToken_key
                            Type:(MessageType)paramMessageType
                   delegate:(id<PPNoticeManagerDelegate>)delegate
{
    [self cancel];
    [self setDelegate:delegate];
    
    TRBuffer *buff = [TRBuffer defaultTRBuffer];
    _conn = [[TRHTTPConnection defaultHTTPConnection] retain];
    
    [buff writeInt32:IH_REQ_QUR_MESSAGE];
    [buff writeInt32:paramClient_flags];
    [buff writeMem:paramToken_key len:16];
    [buff writeInt8:paramMessageType];
    [buff writeInt32:[[PPAppPlatformKit sharedInstance] appId]];
    
    [buff writeLen];
    [_conn sendPost:NOTI_REQUEST_URL buff:buff userInfo:nil delegate:self];
    
//    printf("---------------------");
//    printf("\n");
//    printf("ppRequestCheckNewMessage:   ");
//    NSLog(@"%@ ",  NOTI_REQUEST_URL);
//    printf("\n");
//    for (int i=0; i<buff.bufferLen; i++) {
//        printf("%02x ",  (unsigned char)buff.body[i]);
//    }
//    printf("\n");
//    printf("---------------------");
}


/**
 * 请求获取公告【单条公告】或邮件【邮件列表】
 * @param paramClient_flags: 备用字段，默认0
 * @param paramToken_key:   Token
 * @param paramMessageType: 信息类型   1为公告,2为邮件
 * @param delegate: 委托对象（强引用，引用数+1）
 * @returns 无
 * @exception
 */
- (void)ppRequestGetMessage:(int)paramClient_flags
                      Token:(char *)paramToken_key
                       Type:(MessageType)paramMessageType
                   CurrPage:(int)paramCurrPage
                   delegate:(id<PPNoticeManagerDelegate>)delegate
{
    [self cancel];
    [self setDelegate:delegate];
    
    TRBuffer *buff = [TRBuffer defaultTRBuffer];
    _conn = [[TRHTTPConnection defaultHTTPConnection] retain];
    
    [buff writeInt32:IH_REQ_GET_MESSAGE];
    [buff writeInt32:paramClient_flags];
    [buff writeMem:paramToken_key len:16];
    
    [buff writeInt8:paramMessageType];
    [buff writeInt32:[[PPAppPlatformKit sharedInstance] appId]];
    
    if (paramMessageType == MessageTypeOfEmail) {
        [buff writeInt32:paramCurrPage];
        [buff writeInt8:20];//每页显示10条
    }
    
    [buff writeLen];
    
    [_conn sendPost:NOTI_REQUEST_URL buff:buff userInfo:nil delegate:self];
    
    if (PP_ISNSLOG) {
        NSLog(@"请求的地址---%@",NOTI_REQUEST_URL);
        NSLog(@"请求查询的BodyData-----{command = %02x,paramClient_flags,paramToken_key,paramMessageType = %d,appid = %d,paramCurrPage = %d,countsPerPage = %d,}",IH_REQ_GET_MESSAGE,paramMessageType,[[PPAppPlatformKit sharedInstance] appId],paramCurrPage,20);
    }
//    printf("---------------------");
//    printf("\n -%d",buff.bufferLen);
//    printf("ppRequestGetMessage:   ");
//    NSLog(@"%@ ",  NOTI_REQUEST_URL);
//    printf("\n");
//    for (int i=0; i<buff.bufferLen; i++) {
//        printf("%02x ",  (unsigned char)buff.body[i]);
//    }
//    printf("\n");
//    printf("---------------------");
}



/**
 * 请求删除邮件
 * @param paramClient_flags: 备用字段，默认0
 * @param paramToken_key:   Token
 * @param paramMessageType: 信息类型   1为公告,2为邮件
 * @param delegate: 委托对象（强引用，引用数+1）
 * @returns 无
 * @exception
 */
- (void)ppRequestDelMessage:(int)paramClient_flags
                      Token:(char *)paramToken_key
                    EmailIdArray:(NSArray *)paramEmailIdArray
                   delegate:(id<PPNoticeManagerDelegate>)delegate
{
    [self cancel];
    [self setDelegate:delegate];
    
    TRBuffer *buff = [TRBuffer defaultTRBuffer];
    _conn = [[TRHTTPConnection defaultHTTPConnection] retain];
    
    [buff writeInt32:IH_REQ_DEL_MESSAGE];
    [buff writeInt32:paramClient_flags];
    [buff writeMem:paramToken_key len:16];
    
    [buff writeInt8:MessageTypeOfEmail];
    [buff writeInt32:[[PPAppPlatformKit sharedInstance] appId]];
    [buff writeInt16:[paramEmailIdArray count]];
    
    
    for (int i = 0; i < [paramEmailIdArray count]; i++) {
        [buff writeInt32:[[paramEmailIdArray objectAtIndex:i] intValue]];
    }
    [buff writeLen];
    
    [_conn sendPost:NOTI_REQUEST_URL buff:buff userInfo:nil delegate:self];
//    printf("---------------------");
//    printf("\n");
//    printf("ppRequestDelMessage: ");
//    NSLog(@"%@ ",  NOTI_REQUEST_URL);
//    printf("\n");
//    for (int i=0; i<buff.bufferLen; i++)
//    {
//        printf("%02x ",  (unsigned char)buff.body[i]);
//    }
//    printf("\n");
//    printf("---------------------");
}



/**
 * 编辑邮件
 * @param paramClient_flags: 备用字段，默认0
 * @param paramToken_key:   Token
 * @param EmailIdArray: 邮件id的数组
 * @param delegate: 委托对象（强引用，引用数+1）
 * @returns 无
 * @exception
 */
- (void)ppRequestSetMessage:(int)paramClient_flags
                      Token:(char *)paramToken_key
               EmailIdArray:(NSArray *)paramEmailIdArray
                     IsRead:(BOOL)paramIsRead
                   delegate:(id<PPNoticeManagerDelegate>)delegate
{
    [self cancel];
    [self setDelegate:delegate];
    
    TRBuffer *buff = [TRBuffer defaultTRBuffer];
    _conn = [[TRHTTPConnection defaultHTTPConnection] retain];
    
    [buff writeInt32:IH_REQ_SET_MESSAGE];
    [buff writeInt32:paramClient_flags];
    [buff writeMem:paramToken_key len:16];
    [buff writeInt8:MessageTypeOfEmail];
    [buff writeInt32:[[PPAppPlatformKit sharedInstance] appId]];
    [buff writeInt8:paramIsRead];
    
    [buff writeInt16:[paramEmailIdArray count]];
    
    
    for (int i = 0; i < [paramEmailIdArray count]; i++) {
        [buff writeInt32:[[paramEmailIdArray objectAtIndex:i] intValue]];
    }
    
    
    [buff writeLen];
    
    [_conn sendPost:NOTI_REQUEST_URL buff:buff userInfo:nil delegate:self];
  
//    printf("---------------------");
//    printf("\n");
//    printf("ppRequestDelMessage: ");
//    NSLog(@"%@ ",  NOTI_REQUEST_URL);
//    printf("\n");
//    for (int i=0; i<buff.bufferLen; i++)
//    {
//        printf("%02x ",  (unsigned char)buff.body[i]);
//    }
//    printf("\n");
//    printf("---------------------");
}



- (void)didFinishConnection:(TRHTTPConnection *)conn data:(NSData *)data userInfo:(NSMutableDictionary *)userInfo
{
    id<PPNoticeManagerDelegate> delegate = nil;
    if (_delegate)
        delegate = [_delegate retain];
    
    [self cancel];
    if (delegate)
    {
        TRBuffer *buff = [[[TRBuffer alloc] initWithBuffNoCopy:(char*)data.bytes] autorelease];
        //len
        [buff readInt32];
        MessageCommand commmand = [buff readInt32];
        MessageStatus status = [buff readInt16];
        if(PP_ISNSLOG)
        {
            NSLog(@"获取消息-------status = %d",status);
        }
        if (status == IH_E_OK)
        {
            if (commmand == IH_REQ_GET_MESSAGE)
            {
                MessageType type = [buff readInt8];
                if (type == MessageTypeOfEmail)
                {
                    //消息总数
                    int messageCount = [buff readInt32];
                    //页面总数
                    int pagesCount = [buff readInt32];
                    //当前页条数
                    int itemCount = [buff readInt32];
                    NSMutableArray *messageArray = [NSMutableArray arrayWithCapacity:itemCount];
                    for (int i = 0; i < itemCount; i++) {
                        //记录第一条数据得id和时间用来检查是否存在新邮件

                        //读取数据赋值给对象属性.一定要按顺序来
                        PPNotice *ppNotice = [[PPNotice alloc] init];
                        [ppNotice setMessageId:[buff readInt32]];
                        //0:系统 1:玩家 ..目前默认为0
                        [ppNotice setMessageSendType:[buff readInt8]];
                        if([ppNotice messageSendType] == MessageSenderTypeUser)
                        {
                            //						uint64_t user_id; //发送者id
                            //						string user_name; //发送者名称
                        }
                        //0:未读 1:已读
                        [ppNotice setIsRead:[buff readInt8]];
                        [ppNotice setTitle:[buff readString]];
                        [ppNotice setContent:[buff readString]];
                        [ppNotice setSendDate:[buff readInt32]];
                        [ppNotice setMessageType:type];
                        [messageArray addObject:ppNotice];
//                        if (i == 0)
//                        {
//                            [[PPAppPlatformKit sharedInstance] setNewEmailId:[ppNotice messageId]];
//                            [[PPAppPlatformKit sharedInstance] setNewEmailSendDate:[ppNotice sendDate]];
//                        }
                        [ppNotice release];
                    }
                    if (delegate) {
                        if ([delegate respondsToSelector:@selector(didSuccessGetMessageCallBack:Pages:ItemArray:)]) {
                            [delegate didSuccessGetMessageCallBack:messageCount Pages:pagesCount ItemArray:messageArray];
                        }
                    }
                }
                else if (type == MessageTypeOfNoti)
                {
                    //读取新公告
                    PPNotice *ppNotice = [[PPNotice alloc] init];
                    [ppNotice setMessageId:[buff readInt32]];
                    //0:系统 1:玩家 ..目前默认为0
                    [ppNotice setMessageSendType:MessageSenderTypeSystem];
                    //0:未读 1:已读
                    [ppNotice setIsRead:NO];
                    [ppNotice setStartTime:[buff readInt32]];
                    [ppNotice setEndTime:[buff readInt32]];
                    [ppNotice setContentType:[buff readInt8]];
                    [ppNotice setTitle:[buff readString]];
                    [ppNotice setContent:[buff readString]];
                    [ppNotice setSendDate:[buff readInt32]];
                    [ppNotice setMessageType:type];
//                    NSArray *array = [NSArray alloc] init
                    if (delegate) {
                        if ([delegate respondsToSelector:@selector(didSuccessGetMessageCallBack:)]) {
                            [delegate didSuccessGetMessageCallBack:ppNotice];
                        }
                    }
                    [ppNotice release];
                    
                }
                
            }
            else if (commmand == IH_REQ_QUR_MESSAGE)
            {
                MessageType type = [buff readInt8];
                if (type == MessageTypeOfEmail) {
                    PPNotice *ppNotice = [[[PPNotice alloc] init] autorelease];
                    [ppNotice setMessageType:type];
                    [ppNotice setMessageId:[buff readInt32]];
                    [ppNotice setSendDate:[buff readInt32]];
                    [ppNotice setIsRead:[buff readInt8]];
                    [ppNotice setMessageType:type];
                    //先判读本地内存是否获取过列表
                    if ([[PPAppPlatformKit sharedInstance] newEmailId] == 0)
                    {
                        //没有获取过邮件列表.判断返回值是否存在最新记录是否为未读
                        if ([ppNotice messageId] != 0 && [ppNotice isRead] == NO)
                        {
                            //更新本地记录最新邮件id和时间
                            [[PPAppPlatformKit sharedInstance] setNewEmailSendDate:[ppNotice sendDate]];
                            [[PPAppPlatformKit sharedInstance] setNewEmailId:[ppNotice messageId]];
                            //表示有标记未读邮件
                            if ([delegate respondsToSelector:@selector(didSuccessQurMessageCallBack:)]) {
                                [delegate didSuccessQurMessageCallBack:ppNotice];
                            }
                        }
                    }
                    else
                    {
                        //本地记录如果小于获取最新得时间和id.则表示有新邮件
                        if ([ppNotice messageId] > [[PPAppPlatformKit sharedInstance] newEmailId]
                            && [ppNotice sendDate] > [[PPAppPlatformKit sharedInstance] newEmailSendDate])
                        {
                            //更新本地记录最新邮件id和时间
                            [[PPAppPlatformKit sharedInstance] setNewEmailSendDate:[ppNotice sendDate]];
                            [[PPAppPlatformKit sharedInstance] setNewEmailId:[ppNotice messageId]];
                            if ([delegate respondsToSelector:@selector(didSuccessQurMessageCallBack:)]) {
                                [delegate didSuccessQurMessageCallBack:ppNotice];
                            }
                        }
                    }
                }
            }
            else if (commmand == IH_REQ_DEL_MESSAGE)
            {
                if (delegate && [delegate respondsToSelector:@selector(didSuccessDelMessageCallBack)]) {
                    [delegate didSuccessDelMessageCallBack];
                }
            }
            else if (commmand == IH_REQ_SET_MESSAGE)
            {
                if (delegate && [delegate respondsToSelector:@selector(didSuccessSetMessageCallBack)]) {
                    [delegate didSuccessSetMessageCallBack];
                }
            }
            
        }
        else if (status == IH_E_INVALID_USER_TOKEN)
        {
            //无效的用户token，需重新登陆再次发送处理
            //1.取出本地保存的用户名和密码
            NSString *u = [[NSUserDefaults standardUserDefaults] objectForKey:@"PP_U"];
            NSData *p = [[NSUserDefaults standardUserDefaults] objectForKey:@"PP_P"];
         
            
            //再次请求20分钟时效性的token

            [[TRUserRequest defaultTRUserRequest] requestLogin:u password:p
                                                          userType:SDKUserTypeNormal userInfo:nil delegate:self];
            

        }
        else if (status == IH_E_MESSSGE_NOT_EXIST)
        {
            if (delegate && [delegate respondsToSelector:@selector(didFailGetMessageCallBack:)]) {
                [delegate didFailGetMessageCallBack:IH_E_MESSSGE_NOT_EXIST];
            }
        }
        else if (status == IH_E_NEGATIVE_VALUE)
        {
            
            if (delegate && [delegate respondsToSelector:@selector(didFailGetMessageCallBack:)]) {
                [delegate didFailGetMessageCallBack:IH_E_NEGATIVE_VALUE];
            }
        }
        else
        {
            NSLog(@"未知错误");
        }
        [delegate release];
    }
}


- (void)didFailConnection:(TRHTTPConnection*)conn errorCode:(TRHTTPConnectionError)errorCode userInfo:(NSMutableDictionary *)userInfo
{
    id<PPNoticeManagerDelegate> delegate = nil;
    if (_delegate)
        delegate = [_delegate retain];
    
    [self cancel];
    
    if (delegate) {
        if ([delegate respondsToSelector:@selector(didFailRequestConnectionCallBack:errorCode:userInfo:)]) {
            [delegate didFailRequestConnectionCallBack:self errorCode:errorCode userInfo:userInfo];
        }
        [delegate release];
    }
}

- (void)didSuccessRequestLogin:(TRUserRequest *)tRUserRequest tokenKey:(NSString *)tokenKey userId:(unsigned long long)userId userName:(NSString *)userName tmpUserName:(NSString *)tmpUserName userInfo:(NSMutableDictionary *)userInfo
{
    //处理20分钟token登录验证方式,保存token在本地做邮件接口验证参数.其他方式保持不变
    if ([[userInfo objectForKey:@"userType_"] intValue] == 0) {
        char hexToKen[16];
        str_to_hex((char *)[tokenKey UTF8String], 32, (unsigned char *)hexToKen);
        if (PP_ISNSLOG) {
            NSLog(@"%@",tokenKey);
        }

        [[PPAppPlatformKit sharedInstance] setCurrent20MinToken:tokenKey];
    }
}

/**
 description:修改一条公告
 @param paramPPNotice:要修改的公告对象
 */
- (void)updateNotice:(PPNotice *)paramPPNotice
{
    NSString *path = [self getNoticePath];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    if (array == nil) {
        NSDictionary *noticeDic = [PPCommon getObjectData:paramPPNotice];
        array = [[NSMutableArray alloc] init];
        [array insertObject:noticeDic atIndex:0];
        BOOL sucess = [array writeToFile:path atomically:YES];
        if (sucess) {
            
        }
        [array release];
    }
    else
    {
        for (int i = 0; i < [array count]; i++) {
            NSDictionary *dic = [array objectAtIndex:i];
            int messageId = [[dic objectForKey:@"messageId"] intValue];
            if (messageId == [paramPPNotice messageId]) {
                [array removeObjectAtIndex:i];
                NSDictionary *noticeDic = [PPCommon getObjectData:paramPPNotice];
                [array insertObject:noticeDic atIndex:i];
                [array writeToFile:path atomically:YES];
                break;
            }
        }
        [array release];
    }
}

/**
 description:删除一条公告
 @param paramPPNotice:要删除的公告对象
 */
- (void)deleteNotice:(PPNotice *)paramPPNotice
{
    NSString *path = [self getNoticePath];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    if (array && [array count] > 0) {

        for (int i = 0; i < [array count]; i++) {
            NSDictionary *dic = [array objectAtIndex:i];
            int messageId = [[dic objectForKey:@"messageId"] intValue];
            if (messageId == [paramPPNotice messageId]) {
                [array removeObjectAtIndex:i];
                [array writeToFile:path atomically:YES];
                break;
            }
        }
    }
    if (array) {
        [array release];
        array = nil;
    }
}

/**
 description:删除一组公告
 @param paramPPNoticeArray:公告数组
 */
- (void)deleteNoticeArray:(NSArray *)paramPPNoticeArray
{
    NSString *path = [self getNoticePath];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    if (array && [array count] >= [paramPPNoticeArray count]) {

        for (PPNotice *paramNotice in paramPPNoticeArray) {
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *dic = [array objectAtIndex:i];
                int messageId = [[dic objectForKey:@"messageId"] intValue];
                if (messageId == [paramNotice messageId]) {
                    [array removeObjectAtIndex:i];
                    break;
                }
            }
        }
        [array writeToFile:path atomically:YES];
        
    }
    if (array) {
        [array release];
    }
}

/**
 description:修改一组公告
 @param paramPPNoticeArray:公告的id数组
 */
- (void)updateNoticeArray:(NSArray *)paramPPNoticeArray
{
    NSString *path = [self getNoticePath];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    if (array) {
        for (PPNotice *paramNotice in paramPPNoticeArray) {
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *dic = [array objectAtIndex:i];
                int messageId = [[dic objectForKey:@"messageId"] intValue];
                if (messageId == [paramNotice messageId]) {
                    [array removeObjectAtIndex:i];
                    NSDictionary *noticeDic = [PPCommon getObjectData:paramNotice];
                    [array insertObject:noticeDic atIndex:i];
                    break;
                }
            }
        }
        [array writeToFile:path atomically:YES];
        
    }
    if (array) {
        [array release];
    }
}

- (NSMutableArray *)getAllNotice
{
    NSString *path = [self getNoticePath];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    return [array autorelease];
}

/**
 description:获取公告存储的本地路径
 @return 公告存储路径，包括文件本身
 */
- (NSString *)getNoticePath
{
    if (_noticePath) {
        if (PP_ISNSLOG) {
            NSLog(@"获取公告存储路径：%@",_noticePath);
        }
        return _noticePath;
    }
    else{
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *directory = [NSString stringWithFormat:@"%@",[[[PPAppPlatformKit sharedInstance] currentUserName] lowercaseString]];
        NSString *userDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:directory];
        NSString *path = [userDirectory stringByAppendingPathComponent:@"PPNoticeData.plist"];
        if (PP_ISNSLOG) {
            NSLog(@"获取公告存储路径：%@",path);
        }
        return path;
    }
}

- (void)dealloc{
    [_noticePath release];
    _noticePath = nil;
    [self cancel];
    [super dealloc];
}

- (void)setDelegate:(id<PPNoticeManagerDelegate>)delegate
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


@end

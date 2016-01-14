//
//  PPNotice.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-25.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger, MessageSenderType) {
    MessageSenderTypeSystem = 0,                  //系统发送
    MessageSenderTypeUser   = 1                 // 玩家发送
};

typedef NS_ENUM(NSInteger, ContentType) {
    ContentTypeText = 0,                  //系统发送
    ContentTypeHyperLink = 1                 // 玩家发送
};

//消息类型
typedef enum {
    MessageTypeOfNoti                            = 1,        //公告
    MessageTypeOfEmail                           = 2,        //邮件
} MessageType;


@interface PPNotice : NSObject
{

}

@property (nonatomic, assign) MessageType messageType;
@property (nonatomic, assign) NSInteger messageId;
@property (nonatomic, assign) MessageSenderType messageSendType;
@property (nonatomic, assign) BOOL isRead;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, assign) NSTimeInterval sendDate;



@property (nonatomic ,assign) NSTimeInterval startTime;
@property (nonatomic ,assign) NSTimeInterval endTime;
@property (nonatomic ,assign) ContentType contentType;

- (PPNotice *)initWithDictionary:(NSDictionary *)dictionary;

@end

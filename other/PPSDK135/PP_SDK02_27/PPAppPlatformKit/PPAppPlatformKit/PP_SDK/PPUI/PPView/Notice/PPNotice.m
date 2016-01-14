//
//  PPNotice.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-25.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPNotice.h"

@implementation PPNotice

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (PPNotice *)initWithDictionary:(NSDictionary *)dictionary
{
    if (!self)
    {
        self = [super init] ;
    }
    
    _title = [[NSString alloc] initWithString:[dictionary objectForKey:@"title"]];
    
    _startTime = [[dictionary objectForKey:@"startTime"] intValue];
    _sendDate = [[dictionary objectForKey:@"sendDate"] intValue];
    _messageSendType =(MessageSenderType) [dictionary objectForKey:@"messageSendType"];
    _messageId = [[dictionary objectForKey:@"messageId"] intValue];
    _isRead = [[dictionary objectForKey:@"isRead"] boolValue];
    
    _endTime = [[dictionary objectForKey:@"endTime"] intValue];
    _contentType = (ContentType)[dictionary objectForKey:@"contentType"];
    _content = [[NSString alloc] initWithString:[dictionary objectForKey:@"content"]];
    _messageType =(MessageType)[dictionary objectForKey:@"messageType"];
    

    return self;
}



- (void)dealloc
{
    [_title release];
    _title = nil;
    [_content release];
    _content = nil;
    [super dealloc];
}

@end

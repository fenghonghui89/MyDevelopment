//
//  TRTool.h
//  Day09SocketChatAndSendFile
//
//  Created by HanyFeng on 13-12-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRTool : NSObject
+(NSMutableData*)appendHeaderDataOf:(NSString*)headerString ToFileData:(NSMutableData*)fileData;
@end

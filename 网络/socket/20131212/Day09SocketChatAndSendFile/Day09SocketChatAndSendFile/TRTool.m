//
//  TRTool.m
//  Day09SocketChatAndSendFile
//
//  Created by HanyFeng on 13-12-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRTool.h"

@implementation TRTool
+(NSMutableData*)appendHeaderDataOf:(NSString*)headerString ToFileData:(NSMutableData*)fileData{
    NSData* headerData = [headerString dataUsingEncoding:NSUTF8StringEncoding];
    [fileData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
    return fileData;
}
@end

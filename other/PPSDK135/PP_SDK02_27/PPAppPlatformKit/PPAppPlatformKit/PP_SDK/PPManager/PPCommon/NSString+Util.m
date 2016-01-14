//
//  NSString+Util.m
//  PPAppInstall
//
//  Created by kang on 13-11-8.
//  Copyright (c) 2013年 kosin. All rights reserved.
//

#import "NSString+Util.h"
#import "PPbase64.h"
//#import "ASIHTTPRequest.h"
@implementation NSString (Util)
- (NSString *)downurlBase64ConverToNomalUrl{
    NSString *stringValue = [self decodeBase64ToString];
    return stringValue;
   

}

//- (NSString *)_encodeStringToBase64{
//    NSString *stringValue = self;
//    Byte inputData[[stringValue lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];//prepare a Byte[]
//    [[stringValue dataUsingEncoding:NSUTF8StringEncoding] getBytes:inputData];//get the pointer of the data
//    size_t inputDataSize = (size_t)[stringValue length];
//    BOOL wrapped = NO;
//    size_t outputDataSize = EstimateBas64EncodedDataSize(inputDataSize,wrapped);//calculate the decoded data size
//    Byte outputData[outputDataSize];//prepare a Byte[] for the decoded data
//
//    Base64EncodeData(inputData, inputDataSize, (char *)outputData, &outputDataSize,wrapped);//decode the data
//    NSData *theData = [[NSData alloc] initWithBytes:outputData length:outputDataSize];
//    NSString *urlValue = [[[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding] autorelease];
//    [theData release];
//    urlValue = [urlValue stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    return urlValue;
//}

- (NSString *)encodeStringToBase64{

    NSString *stringValue = self;
    Byte inputData[[stringValue lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];//prepare a Byte[]
    [[stringValue dataUsingEncoding:NSUTF8StringEncoding] getBytes:inputData];//get the pointer of the data
    size_t inputDataSize = (size_t)[stringValue length];
    BOOL wrapped = NO;
    size_t outputDataSize = PPEstimateBas64EncodedDataSize(inputDataSize,wrapped);//calculate the decoded data size
    Byte outputData[outputDataSize];//prepare a Byte[] for the decoded data
    
    PPBase64EncodeData(inputData, inputDataSize, (char *)outputData, &outputDataSize,wrapped);//decode the data
    NSData *theData = [[NSData alloc] initWithBytes:outputData length:outputDataSize];
    NSString *urlValue = [[[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding] autorelease];
    [theData release];
    urlValue = [urlValue stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return urlValue;

}

- (NSString *)decodeBase64ToString{
    NSString *stringValue = self;
    Byte inputData[[stringValue lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];//prepare a Byte[]
    [[stringValue dataUsingEncoding:NSUTF8StringEncoding] getBytes:inputData];//get the pointer of the data
    size_t inputDataSize = (size_t)[stringValue length];
    size_t outputDataSize = PPEstimateBas64DecodedDataSize(inputDataSize);//calculate the decoded data size
    Byte outputData[outputDataSize];//prepare a Byte[] for the decoded data
    PPBase64DecodeData(inputData, inputDataSize, outputData, &outputDataSize);//decode the data
    NSData *theData = [[NSData alloc] initWithBytes:outputData length:outputDataSize];
    NSString *urlValue = [[[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding] autorelease];
    [theData release];
    return urlValue;
}

//   ‘+’ 换成 ‘_’
//   ‘=’ 换成 ‘-’
//   ‘/’ 换成 ‘,’
- (NSString *)encodeStringToBase64URLFormat{
    NSString *string = [self encodeStringToBase64];
    NSMutableString *var_string = [NSMutableString stringWithString:string];
    NSRange rang = NSMakeRange(0, var_string.length);
    while ([var_string rangeOfString:@"="].location != NSNotFound) {
        rang.length = [var_string rangeOfString:@"="].location + 1;
        [var_string replaceOccurrencesOfString:@"=" withString:@"-" options:NSBackwardsSearch range:rang];
    }
    rang = NSMakeRange(0, var_string.length);
    while ([var_string rangeOfString:@"+"].location != NSNotFound) {
        rang.length = [var_string rangeOfString:@"+"].location + 1;
        [var_string replaceOccurrencesOfString:@"+" withString:@"_" options:NSBackwardsSearch range:rang];
    }
    rang = NSMakeRange(0, var_string.length);
    while ([var_string rangeOfString:@"/"].location != NSNotFound) {
        rang.length = [var_string rangeOfString:@"/"].location + 1;
        [var_string replaceOccurrencesOfString:@"/" withString:@"," options:NSBackwardsSearch range:rang];
    }
    return var_string;
}
- (NSString *)decodeBase64URLFormatToString{
    NSMutableString *var_string = [NSMutableString stringWithString:self];
    NSRange rang = NSMakeRange(0, var_string.length);
    while ([var_string rangeOfString:@"-"].location != NSNotFound) {
        rang.length = [var_string rangeOfString:@"-"].location + 1;
        [var_string replaceOccurrencesOfString:@"-" withString:@"=" options:NSBackwardsSearch range:rang];
    }
    rang = NSMakeRange(0, var_string.length);
    while ([var_string rangeOfString:@"_"].location != NSNotFound) {
        rang.length = [var_string rangeOfString:@"_"].location + 1;
        [var_string replaceOccurrencesOfString:@"_" withString:@"+" options:NSBackwardsSearch range:rang];
    }
    rang = NSMakeRange(0, var_string.length);
    while ([var_string rangeOfString:@","].location != NSNotFound) {
        rang.length = [var_string rangeOfString:@","].location + 1;
        [var_string replaceOccurrencesOfString:@"," withString:@"/" options:NSBackwardsSearch range:rang];
    }
    return [var_string decodeBase64ToString];
}
@end

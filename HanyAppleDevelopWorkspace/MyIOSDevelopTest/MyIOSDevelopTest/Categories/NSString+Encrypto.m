//
//  NSString+Crypto.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/1.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "NSString+Encrypto.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Encrypto)
- (NSString*) sha1
{
  const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
  NSData *data = [NSData dataWithBytes:cstr length:self.length];
  
  uint8_t digest[CC_SHA1_DIGEST_LENGTH];
  
  CC_SHA1(data.bytes, data.length, digest);
  
  NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
  
  for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
  
  return output;
}

-(NSString *) md5
{
  const char *cStr = [self UTF8String];
  unsigned char digest[CC_MD5_DIGEST_LENGTH];
  CC_MD5( cStr, strlen(cStr), digest );
  
  NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  
  for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
  
  return output;
}

- (NSString *) sha1_base64
{
  const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
  NSData *data = [NSData dataWithBytes:cstr length:self.length];
  
  uint8_t digest[CC_SHA1_DIGEST_LENGTH];
  
  CC_SHA1(data.bytes, data.length, digest);
  
  NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
  NSString * output = [base64 base64EncodedStringWithOptions:0];
  return output;
}

- (NSString *) md5_base64
{
  const char *cStr = [self UTF8String];
  unsigned char digest[CC_MD5_DIGEST_LENGTH];
  CC_MD5( cStr, strlen(cStr), digest );
  
  NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
  NSString * output = [base64 base64EncodedStringWithOptions:0];
  return output;
}

- (NSString *) base64
{
  NSData * data = [self dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
  NSString * output = [data base64EncodedStringWithOptions:0];
  return output;
}
@end

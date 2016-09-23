//
//  CustomURLProtocol.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "CustomURLProtocol.h"

static NSString * const URLProtocolHandledKey = @"URLProtocolHandledKey";

@interface CustomURLProtocol ()<NSURLConnectionDelegate>
@property (nonatomic, strong) NSURLConnection *connection;
@end
@implementation CustomURLProtocol

#pragma mark - ******* override *********

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
  //只处理http和https请求
  NSString *scheme = [[request URL] scheme];
  if ( ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
        [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame))
  {
    //看看是否已经处理过了，防止无限循环
    if ([NSURLProtocol propertyForKey:URLProtocolHandledKey inRequest:request]) {
      return NO;
    }
    
    return YES;
  }
  return NO;
}

+ (NSURLRequest *) canonicalRequestForRequest:(NSURLRequest *)request {
  
  NSMutableURLRequest *mutableReqeust = [request mutableCopy];
  mutableReqeust = [self redirectHostInRequset:mutableReqeust];
  return mutableReqeust;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
{
  return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)startLoading
{
  NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
  
  //标识该request已经处理过了，防止无限循环
  [NSURLProtocol setProperty:@YES forKey:URLProtocolHandledKey inRequest:mutableReqeust];
  self.connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:self];
}

- (void)stopLoading
{
  [self.connection cancel];
}

#pragma mark - ******* method *********
+(NSMutableURLRequest*)redirectHostInRequset:(NSMutableURLRequest*)request
{
  if ([request.URL host].length == 0) {
    return request;
  }
  
  NSString *originUrlString = [request.URL absoluteString];
  NSString *originHostString = [request.URL host];
  NSRange hostRange = [originUrlString rangeOfString:originHostString];
  if (hostRange.location == NSNotFound) {
    return request;
  }
  
  //定向到bing搜索主页
  NSString *ip = @"tpages.cn";
  
  //替换域名
  NSString *urlString = [originUrlString stringByReplacingCharactersInRange:hostRange withString:ip];
  NSURL *url = [NSURL URLWithString:urlString];
  request.URL = url;
  
  return request;
}

#pragma mark - ******** callback ********
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [self.client URLProtocol:self didLoadData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
  [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  [self.client URLProtocol:self didFailWithError:error];
}
@end

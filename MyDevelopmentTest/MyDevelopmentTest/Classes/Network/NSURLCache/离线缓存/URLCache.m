//
//  URLCache.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "URLCache.h"

static NSString *cacheDirectory;
static NSSet *supportSchemes;

@implementation URLCache

@synthesize cachedResponses, responsesInfo;


+ (void)initialize {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  cacheDirectory = [paths objectAtIndex:0];
  supportSchemes = [NSSet setWithObjects:@"http", @"https", @"ftp", nil];
}

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path {
  if (self = [super initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path]) {
    cachedResponses = [[NSMutableDictionary alloc] init];
    NSString *path = [cacheDirectory stringByAppendingPathComponent:@"responsesInfo.plist"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:path]) {
      responsesInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    } else {
      responsesInfo = [[NSMutableDictionary alloc] init];
    }
  }
  return self;
}

- (void)removeCachedResponseForRequest:(NSURLRequest *)request {
  NSLog(@"removeCachedResponseForRequest:%@", request.URL.absoluteString);
  [cachedResponses removeObjectForKey:request.URL.absoluteString];
  [super removeCachedResponseForRequest:request];
}

- (void)removeAllCachedResponses {
  NSLog(@"removeAllObjects");
  [cachedResponses removeAllObjects];
  [super removeAllCachedResponses];
}

- (void)saveInfo {
  if ([responsesInfo count]) {
    NSString *path = [cacheDirectory stringByAppendingPathComponent:@"responsesInfo.plist"];
    [responsesInfo writeToFile:path atomically: YES];
  }	
}


- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
  if ([request.HTTPMethod compare:@"GET"] != NSOrderedSame) {
    return [super cachedResponseForRequest:request];
  }
  
  NSURL *url = request.URL;
  if (![supportSchemes containsObject:url.scheme]) {
    return [super cachedResponseForRequest:request];
  }
  
  NSString *absoluteString = url.absoluteString;
  NSLog(@"%@", absoluteString);
  NSCachedURLResponse *cachedResponse = [cachedResponses objectForKey:absoluteString];
  if (cachedResponse) {
    NSLog(@"cached: %@", absoluteString);
    return cachedResponse;
  }
  
  NSDictionary *responseInfo = [responsesInfo objectForKey:absoluteString];
  if (responseInfo) {
    NSString *path = [cacheDirectory stringByAppendingPathComponent:[responseInfo objectForKey:@"filename"]];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:path]) {
      
      NSData *data = [NSData dataWithContentsOfFile:path];
      NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:[responseInfo objectForKey:@"MIMEType"] expectedContentLength:data.length textEncodingName:nil];
      cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
      
      [cachedResponses setObject:cachedResponse forKey:absoluteString];
      NSLog(@"cached: %@", absoluteString);
      return cachedResponse;
    }
  }
  
  return nil;
}


@end
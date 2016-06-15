//
//  URLCache.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "URLCache.h"
#import "NSString+Encrypto.h"
static NSString *cacheDirectory;
static NSSet *supportSchemes;//支持的协议集合

@implementation URLCache

@synthesize cachedResponses, responsesInfo;

#pragma mark init
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

#pragma mark remove
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

#pragma mark save
- (void)saveInfo {
  if ([responsesInfo count]>0) {
    NSString *path = [cacheDirectory stringByAppendingPathComponent:@"responsesInfo.plist"];
    [responsesInfo writeToFile:path atomically: YES];
  }	
}




- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
  
  //只对get http https ftp做处理，其他交给父类来处理
  if ([request.HTTPMethod compare:@"GET"] != NSOrderedSame) {
    return [super cachedResponseForRequest:request];
  }
  
  NSURL *url = request.URL;
  if (![supportSchemes containsObject:url.scheme]) {
    return [super cachedResponseForRequest:request];
  }
  
  //接着判断是不是已经在cachedResponses里了，这样的话直接拿出来即可
  NSString *absoluteString = url.absoluteString;
  NSCachedURLResponse *cachedResponse = [cachedResponses objectForKey:absoluteString];
  if (cachedResponse) {
    NSLog(@"cachedResponse: %@", absoluteString);
    return cachedResponse;
  }
  
  //再查查responsesInfo里有没有，如果有的话，说明可以从磁盘获取
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
  }else{
    NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:request.timeoutInterval];
    newRequest.allHTTPHeaderFields = request.allHTTPHeaderFields;
    newRequest.HTTPShouldHandleCookies = request.HTTPShouldHandleCookies;
    
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:newRequest returningResponse:&response error:&error];
    if (error) {
      NSLog(@"%@\nnot cached: %@", error,absoluteString);
      return nil;
    }
    
    NSString *filename = [absoluteString sha1];
    NSString *path = [cacheDirectory stringByAppendingPathComponent:filename];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager createFileAtPath:path contents:data attributes:nil];
    
    NSURLResponse *newResponse = [[NSURLResponse alloc] initWithURL:response.URL MIMEType:response.MIMEType expectedContentLength:data.length textEncodingName:nil];
    responseInfo = [NSDictionary dictionaryWithObjectsAndKeys:filename, @"filename", newResponse.MIMEType, @"MIMEType", nil];
    [responsesInfo setObject:responseInfo forKey:absoluteString];
    NSLog(@"saved: %@", absoluteString);
    
    cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:newResponse data:data];
    [cachedResponses setObject:cachedResponse forKey:absoluteString];
    return cachedResponse;

  }
  
  
  return nil;
}


@end
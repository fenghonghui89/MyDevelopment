//
//  MD_NSError_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/13.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSError_VC.h"

@interface MD_NSError_VC ()

@end

@implementation MD_NSError_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self test];
}

-(void)test{

  NSString * const AFNetworkingOperationFailingURLResponseErrorKey = @"com.alamofire.serialization.response.error.response";
  NSString * const AFNetworkingOperationFailingURLResponseDataErrorKey = @"com.alamofire.serialization.response.error.data";
  
  NSHTTPURLResponse *errorResponse = [[NSHTTPURLResponse alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"] statusCode:1000 HTTPVersion:nil headerFields:nil];
  NSString *msg = [NSString stringWithFormat:@"{\"message\":\"%@\"}",@"Parameters error"];
  NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *errorUserInfo = @{AFNetworkingOperationFailingURLResponseErrorKey:errorResponse,
                                  NSLocalizedDescriptionKey:@"自定义网络错误",
                                  AFNetworkingOperationFailingURLResponseDataErrorKey:data};
  NSError *customError = [[NSError alloc] initWithDomain:@"customError.com" code:1422 userInfo:errorUserInfo];
  
  NSString *desc = customError.localizedDescription;
  NSInteger code = customError.code;
  NSLog(@"%@ %d",desc,code);
}

@end

//
//  MD_HTTP_Base_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/22.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_HTTP_Base_VC.h"

@interface MD_HTTP_Base_VC ()

@end

@implementation MD_HTTP_Base_VC


- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self httpGet];
}

-(void)httpGet{
  NSURL *url = [NSURL URLWithString:@"http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getRegionDataset?"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  NSURLResponse *response = nil;
  NSError *error = nil;
  
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if (error) {
    NSLog(@"error:%@",error.localizedDescription);
  }else{
    NSLog(@"response:%@",response);
    NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
  }
}

-(void)httpPost{
  NSString *urlStr = @"http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getRegionDataset";
  NSURL *url = [NSURL URLWithString:[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  
  NSString *postBody = @"theRegionCode=广东";
  NSData *postBodyData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setHTTPBody:postBodyData];
  [request setHTTPMethod:@"POST"];
  
  NSURLResponse *respone = nil;
  NSError *error = nil;
  
}
@end

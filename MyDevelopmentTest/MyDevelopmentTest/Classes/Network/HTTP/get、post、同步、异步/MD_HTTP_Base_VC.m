//
//  MD_HTTP_Base_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/22.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_HTTP_Base_VC.h"

@interface MD_HTTP_Base_VC ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property(nonatomic,strong)NSMutableData *allData;
@end

@implementation MD_HTTP_Base_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  [self viewDidAppear:animated];
  [self httpGet_Asynchronous];
}

#pragma mark - < method > -

-(void)request{
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
  [request setHTTPMethod:@"POST"];
  [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setHTTPBody:UIImageJPEGRepresentation([UIImage imageNamed:@"Argentina"], 0.3)];
}

-(void)httpGet_Synchronous{
  
  NSURL *url = [NSURL URLWithString:@"http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getRegionCountry?"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  NSHTTPURLResponse *response = nil;
  NSError *error = nil;
  
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if (error) {
    NSLog(@"error:%@",error.localizedDescription);
  }else{
    NSLog(@"response:%@",[response allHeaderFields]);
    NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
  }
}

-(void)httpPost_Synchronous{
  
  NSString *urlStr = @"http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getSupportCityDataset";
  NSURL *url = [NSURL URLWithString:[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  
  NSString *postBody = @"theRegionCode=广东";
  NSData *postBodyData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setHTTPBody:postBodyData];
  [request setHTTPMethod:@"POST"];
  
  NSHTTPURLResponse *respone = nil;
  NSError *error = nil;
  
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respone error:&error];
  if (error) {
    NSLog(@"error:%@",[error localizedDescription]);
  }else{
    NSLog(@"response:%@",[respone allHeaderFields]);
    NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
  }
  
}


-(void)httpGet_Asynchronous{

  NSString *path = @"http://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=%E9%A3%8E%E6%99%AF&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&cs=1089582262,166446285&os=3455816664,2170262247&simid=3539015477,341945575&pn=0&rn=1&di=88624025820&ln=1000&fr=&fmq=1458701574831_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&is=&istype=0&ist=&jit=&bdtype=0&gsm=0&objurl=http%3A%2F%2Ftupian.enterdesk.com%2F2013%2Fmxy%2F12%2F10%2F15%2F3.jpg";
  NSURL *url = [NSURL URLWithString:path];
  
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  
  NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
  [connection start];
  
  
}

-(void)httpPost_Asynchronous{
  NSString *urlStr = @"http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getSupportCityDataset";
  NSURL *url = [NSURL URLWithString:[urlStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  
  NSString *postBody = @"theRegionCode=广东";
  NSData *postBodyData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  [request setHTTPBody:postBodyData];
  [request setHTTPMethod:@"POST"];

  NSURLConnection *connetction = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
  [connetction start];

}

#pragma mark - < callback > -
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
  
  NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
  NSLog(@"~didReceiveResponse:%@",[httpResponse allHeaderFields]);
  self.allData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
  NSLog(@"~didReceiveData：%lu",(unsigned long)data.length);
  [self.allData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
  NSLog(@"~didFailWithError:%@",[error localizedDescription]);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
  NSLog(@"~connectionDidFinishLoading");
  [self.allData writeToFile:@"/Users/hanyfeng/Desktop/net.jpg" atomically:YES];
}
@end

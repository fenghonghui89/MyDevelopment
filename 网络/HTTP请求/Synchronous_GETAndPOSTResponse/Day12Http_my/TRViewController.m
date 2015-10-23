//
//  TRViewController.m
//  Day12Http_my
//
//  Created by HanyFeng on 13-12-20.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self syGetGetData];
}

-(void)syGetGetData
{
    NSString *pathGET = @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theCityCode=江门&theUserID=";
    pathGET = [pathGET stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlGET = [NSURL URLWithString:pathGET];
    NSURLRequest *requestGET = [NSURLRequest requestWithURL:urlGET];
    
    //可设置缓存策略和超时时间的构造方法
    NSMutableURLRequest *test = [[NSMutableURLRequest alloc] initWithURL:urlGET cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    //发出“同步”请求，得到响应头和数据
    NSHTTPURLResponse *hur = nil;
    NSError *error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:requestGET returningResponse:&hur error:&error];
    NSLog(@"HTTPURLResponse:%@",[hur allHeaderFields]);
    
    //把得到的数据转为相应类型并输出
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
}

-(void)syPostGetData
{
    NSString* pathPOST = @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather";
    NSURL* urlPOST = [NSURL URLWithString:pathPOST];
    NSMutableURLRequest* requestPOST = [NSMutableURLRequest requestWithURL:urlPOST];
    
    [requestPOST setHTTPMethod:@"POST"];//修改请求方式为POST，默认为GET
    NSData *requestBody = [@"theCityCode=江门&theUserID=" dataUsingEncoding:NSUTF8StringEncoding];//把请求参数转为data
    [requestPOST setHTTPBody:requestBody];//把请求参数放进请求体
    
    //发出“同步”请求，得到响应头和数据
    NSHTTPURLResponse *hur = nil;
    NSError *error = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:requestPOST returningResponse:&hur error:&error];
    NSLog(@"HTTPURLResponse:%@",[hur allHeaderFields]);
    
    //把得到的数据转为相应类型并输出
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
}

@end

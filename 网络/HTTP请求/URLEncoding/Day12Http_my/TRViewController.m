//
//  TRViewController.m
//  Day12Http_my
//
//  Created by HanyFeng on 13-12-20.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"
#import "NSString+URLEncoding.h"
@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //如果请求的参数中包含中文并且为Get请求方式，需要将中文进行URL编码
    NSString *path = @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theCityCode=江门&theUserID=";
    NSString *encodingString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodingStringC = [encodingString URLEncodedString];//用CoreFoundation提供的C函数编码（更灵活）
    
    //创建请求URL
	NSURL *url = [NSURL URLWithString:encodingString];
    
    //创建请求对象
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    
    //发出“同步”请求并得到返回的数据
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    //把得到的数据转为相应类型并输出
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //中文GB2312解码（GB2312是国家编码，UTF8是国际通用编码）
    NSString *stringGBK = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    
    NSString *stringC = [string URLDecodedString];//用CoreFoundation提供的C函数解码（更灵活）
    NSLog(@"%@",string);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

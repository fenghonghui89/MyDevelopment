//
//  PPHttpRequest.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "PPHttpRequest.h"
@interface PPHttpRequest()
@property(nonatomic,strong)NSMutableData *receiveData;
@end

@implementation PPHttpRequest

-(void)connectToPPServerAndGetHelpViewData{
    NSLog(@"connectToPPServerAndGetHelpViewData");
    NSString *urlStr = [NSString stringWithFormat:@"https://testpay.25pp.com?act=api.getHelp"];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSURLConnection *urlConnetion = [NSURLConnection connectionWithRequest:urlRequest delegate:self];

    if (urlConnetion) {
        self.receiveData = [NSMutableData data];
        
        //以下两种初始化方法是错误的，因为类方法放入自动释放池，而直接赋值给实例变量是不会retain的，方法结束后就会释放
//        _receiveData = [NSMutableData data];
        
//        NSMutableData *data = [NSMutableData data];
//        _receiveData = data;
    }
}

#pragma mark - NSURLConnectionDelegate -
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_receiveData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_receiveData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"错误");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"NSURLConnection回调");
    NSDictionary *conDicJson = [NSJSONSerialization JSONObjectWithData:_receiveData options:kNilOptions error:nil];
    [self.delegate ppHttpRequest:self andParmaDic:conDicJson];
    
    NSLog(@"获取结束");
}

-(void)dealloc{
    NSLog(@"PPHttpRequest dealloc:%p",self);
    _delegate = nil;
    
    [_receiveData release];
    _receiveData = nil;
    
    [super dealloc];
}
@end

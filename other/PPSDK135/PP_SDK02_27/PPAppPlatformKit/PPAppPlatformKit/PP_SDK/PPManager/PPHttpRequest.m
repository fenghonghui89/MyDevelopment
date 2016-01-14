//
//  PPHttpRequest.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-9.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPHttpRequest.h"
#import "PPAppPlatformKitConfig.h"
#import "PPAppPlatformKit.h"

@implementation PPHttpRequest


- (void)setDelegate:(id<PPHttpRequestDelegate>)delegate
{
    if (_delegate) {
        [_delegate release];
        _delegate = nil;
    }
    
    if (delegate) {
        _delegate = [delegate retain];
    }
}

- (void)cancel
{
    if (_delegate) {
        [_delegate release];
        _delegate = nil;
    }

}

- (void)sendRequest:(NSMutableURLRequest *)paramRequest
{
    if (![NSURLConnection canHandleRequest:paramRequest])
    {
        return;
    }
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:paramRequest delegate:self];
    if (_recvData) {
        [_recvData release];
        _recvData = nil;
    }
    if(connection){
        _recvData = [[NSMutableData alloc] init];
    }
    [connection start];
    
}


#pragma mark - NSURLConnectionDelegate , NSURLConnectionDataDelegate -

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_recvData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_recvData appendData:data];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    id<PPHttpRequestDelegate> delegate = nil;
    if (_delegate) delegate = [_delegate retain];
    
    [self cancel];
    
    if (delegate) {
        if ([delegate respondsToSelector:@selector(ppHttpResponseDidFailWithErrorCallBack:)]) {
            [delegate ppHttpResponseDidFailWithErrorCallBack:error];
        }
        [delegate release];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (PP_ISNSLOG) {
        NSLog(@"开始返回响应");
    }
    
    id<PPHttpRequestDelegate> delegate = nil;
    if (_delegate) delegate = [_delegate retain];
    
    [self cancel];
    
    NSDictionary *conDicJson = [NSJSONSerialization JSONObjectWithData:_recvData options:kNilOptions error:nil];
    if (delegate) {
        if ([delegate respondsToSelector:@selector(ppHttpResponseCallBack:)])
        {
            [delegate ppHttpResponseCallBack:conDicJson];
        }
        [delegate release];
    }
}

#pragma mark - dealloc -

-(void)dealloc
{
    [_recvData release];
    _recvData = nil;
    [super dealloc];
}

@end

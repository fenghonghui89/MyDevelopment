//
//  PPHttpRequest.h
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//协议
@class PPHttpRequest;
@protocol PPHttpRequestDelegate <NSObject>
@optional
-(void)ppHttpRequest:(PPHttpRequest*)ppHttpRequest andParmaDic:(NSDictionary*)parmaDic;
-(void)ppHttpRequest:(PPHttpRequest *)ppHttpRequest sayHello:(NSString *)hello;

@end


@interface PPHttpRequest : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property(nonatomic,assign)id<PPHttpRequestDelegate> delegate;

-(void)connectToPPServerAndGetHelpViewData;
@end

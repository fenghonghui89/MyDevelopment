//
//  PPWebViewData.h
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPHttpRequest.h"

//协议
@class PPWebViewData;
@protocol PPWebViewDataDelegate
@optional
-(void)webViewData:(PPWebViewData*)ppWebViewData andPPHelpViewData:(NSDictionary*)parmaDic;
@end

@interface PPWebViewData : NSObject<PPHttpRequestDelegate>

@property(nonatomic,weak)id<PPWebViewDataDelegate> delegate;

-(void)getHelpViewData;
@end

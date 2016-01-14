////
////  PPAneDelegate.m
////  PPAppPlatformKit
////
////  Created by Seven on 13-6-24.
////  Copyright (c) 2013年 张熙文. All rights reserved.
////
//
//#import "PPAneDelegate.h"
//#import "PPAppPlatformKitConfig.h"
//#import <UIKit/UIKit.h>
//
//
//
//extern FREContext g_ctx;
//
//
//
//@implementation PPAneDelegate
//
//
//-(void)ppAddObserverInit{
//    //添加监听请求登陆【只成功有效】
//    [[PPAppPlatformKit sharedInstance] setDelegate:self];
//}
//
//
//-(void)ppLoginStrCallBack:(NSString *)paramStrToKenKey{
//    FREDispatchStatusEventAsync(g_ctx, (const uint8_t*)"ppLoginCallBack",
//                                (const uint8_t*)[paramStrToKenKey UTF8String]);
//}
//
//
//
//-(void)ppClosePageViewCallBack:(PPPageCode)paramPPPageCode{
//    FREDispatchStatusEventAsync(g_ctx, (const uint8_t*)"ppClosePageViewCallBack",
//                                (const uint8_t*)[[NSString stringWithFormat:@"%d",paramPPPageCode] UTF8String]);
//}
//
//-(void)ppLogOffCallBack{
//    FREDispatchStatusEventAsync(g_ctx, (const uint8_t*)"ppLogOffCallBack",
//                                (const uint8_t*)[@"" UTF8String]);
//}
//
//-(void)ppCloseWebViewCallBack:(PPWebViewCode)paramPPWebViewCode{
//    FREDispatchStatusEventAsync(g_ctx, (const uint8_t*)"ppCloseWebViewCallBack",
//                                (const uint8_t*)[[NSString stringWithFormat:@"%d",paramPPWebViewCode] UTF8String]);
//}
//
//-(void)ppPayResultCallBack:(PPPayResultCode)paramPPPayResultCode{
//    FREDispatchStatusEventAsync(g_ctx, (const uint8_t*)"ppPayResultCallBack",
//                                (const uint8_t*)[[NSString stringWithFormat:@"%d",paramPPPayResultCode] UTF8String]);
//}
//
//-(void)ppVerifyingUpdatePassCallBack{
//    FREDispatchStatusEventAsync(g_ctx, (const uint8_t*)"ppVerifyingUpdatePassCallBack",
//                                (const uint8_t*)[@"" UTF8String]);
//}
//
//@end

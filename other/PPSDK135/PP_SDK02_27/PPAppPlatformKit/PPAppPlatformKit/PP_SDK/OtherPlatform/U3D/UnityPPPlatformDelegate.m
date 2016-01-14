////
////  UnityPPPlatformDelegate.m
////  PPAppPlatformKit
////
////  Created by Server on 13-4-12.
////  Copyright (c) 2013年 张熙文. All rights reserved.
////
//
//
//
//
//#import "UnityPPPlatformDelegate.h"
//#import <UIKit/UIKit.h>
//
//
////#define U3DSEDNOBJECT               "Main Camera"
//
//static BOOL isInitSDK = NO;
//
//static NSString *sendMsgNotiClass;
//
//#if defined(__cplusplus)
//extern "C" {
//#endif
//    extern void UnitySendMessage(const char *, const char *, const char *);
//    extern NSString* CreateNSString (const char* string);
//#if defined(__cplusplus)
//}
//#endif
//
//
//#pragma mark UnityNdComPlatformDelegate
//
//
//@implementation UnityPPPlatformDelegate
//
//
//+ (void)U3D_addObserver
//{
//    if (PP_ISNSLOG) {
//        NSLog(@"U3D_addObserver   BEGIN");
//    }
//    
//    //添加监听请求登陆【只成功有效】
//    UnityPPPlatformDelegate *delegate = [[UnityPPPlatformDelegate alloc] init];
//    [[PPAppPlatformKit sharedInstance] setDelegate:delegate];
//    [delegate release];
//
//
//    if (PP_ISNSLOG) {
//        NSLog(@"U3D_addObserver   END");
//    }
//}
//
//
//-(void)ppClosePageViewCallBack:(PPPageCode)paramPPPageCode{
//    UnitySendMessage([sendMsgNotiClass UTF8String], "U3D_closePageViewCallBack", [[NSString stringWithFormat:@"%d",paramPPPageCode] UTF8String]);
//}
//
//-(void)ppCloseWebViewCallBack:(PPWebViewCode)paramPPWebViewCode{
//    UnitySendMessage([sendMsgNotiClass UTF8String], "U3D_closeWebViewCallBack", [[NSString stringWithFormat:@"%d",paramPPWebViewCode] UTF8String]);
//}
//
//
//-(void)ppLoginStrCallBack:(NSString *)paramStrToKenKey{
//    [[PPAppPlatformKit sharedInstance] getUserInfoSecurity];
//    UnitySendMessage([sendMsgNotiClass UTF8String], "U3D_loginCallBack", [paramStrToKenKey UTF8String]);
//}
//
//
//-(void)ppPayResultCallBack:(PPPayResultCode)paramPPPayResultCode{
//    UnitySendMessage([sendMsgNotiClass UTF8String], "U3D_payResultCallBack", [[NSString stringWithFormat:@"%d",paramPPPayResultCode] UTF8String]);
//}
//
//
//-(void)ppLogOffCallBack{
//    UnitySendMessage([sendMsgNotiClass UTF8String], "U3D_logOffCallBack", "");
//}
//
//-(void)ppVerifyingUpdatePassCallBack{
//    UnitySendMessage([sendMsgNotiClass UTF8String], "U3D_ppVerifyingUpdatePassCallBack", "");
//}
//
//
//@end
//
//
//
//
//
//#if defined(__cplusplus)
//extern "C" {
//#endif
//    
//#pragma mark other useful c func utility
//    // Converts C style string to NSString
//    NSString* CreateNSString (const char* string)
//    {
//        if (string)
//            return [NSString stringWithUTF8String: string];
//        else
//            return [NSString stringWithUTF8String: ""];
//    }
//    
//    // Helper method to create C string copy
//    char* MakeStringCopy (const char* string)
//    {
//        if (string == NULL)
//            return NULL;
//        
//        char* res = (char*)malloc(strlen(string) + 1);
//        strcpy(res, string);
//        return res;
//    }
//    
//#pragma mark c apis
//
//    
//    void U3D_initSDK(int paramAppId,const char *paramAppKey,BOOL paramIsNSlogData,int paramRechargeAmount,
//                     BOOL paramIsLongComet,BOOL paramIsLogOutPushLoginView,BOOL paramIsOpenRecharge,
//                     const char *paramCloseRechargeAlertMessage,
//                     BOOL paramIsDeviceOrientationLandscapeLeft,BOOL paramIsDeviceOrientationLandscapeRight,
//                     BOOL paramIsDeviceOrientationPortrait,BOOL paramIsDeviceOrientationPortraitUpsideDown,
//                     const char *paramSendMsgNotiClass){
//        /**
//         *必须写在程序window初始化之后。详情请commad + 鼠标左键 点击查看接口注释
//         *初始化应用的AppId和AppKey。从开发者中心游戏列表获取（https://pay.25pp.com）
//         *设置是否打印日志在控制台
//         *设置充值页面初始化金额
//         *是否需要客户端补发订单（详情请查阅接口注释）
//         *用户注销后是否自动push出登陆界面
//         *是否开放充值页面【操作在按钮被弹窗】
//         *若关闭充值响应的提示语
//         *初始化SDK界面代码
//         */
//        if (isInitSDK) {
//            return;
//        }
//        isInitSDK = YES;
//        
//       
//
//        
//        [[PPAppPlatformKit sharedInstance] setAppId:paramAppId AppKey:CreateNSString(paramAppKey)];
//        [[PPAppPlatformKit sharedInstance] setIsNSlogData:paramIsNSlogData];
//        [[PPAppPlatformKit sharedInstance] setRechargeAmount:paramRechargeAmount];
//        [[PPAppPlatformKit sharedInstance] setIsLongComet:paramIsLongComet];
//        [[PPAppPlatformKit sharedInstance] setIsLogOutPushLoginView:paramIsLogOutPushLoginView];
//        [[PPAppPlatformKit sharedInstance] setIsOpenRecharge:paramIsOpenRecharge];
//        [[PPAppPlatformKit sharedInstance] setCloseRechargeAlertMessage:CreateNSString(paramCloseRechargeAlertMessage)];
//        [[PPUIKit sharedInstance] checkGameUpdate];
//
//        [PPUIKit setIsDeviceOrientationLandscapeLeft:paramIsDeviceOrientationLandscapeLeft];
//        [PPUIKit setIsDeviceOrientationLandscapeRight:paramIsDeviceOrientationLandscapeRight];
//        [PPUIKit setIsDeviceOrientationPortrait:paramIsDeviceOrientationPortrait];
//        [PPUIKit setIsDeviceOrientationPortraitUpsideDown:paramIsDeviceOrientationPortraitUpsideDown];
//        
//        sendMsgNotiClass = [[NSString alloc] initWithFormat:@"%@",CreateNSString(paramSendMsgNotiClass)];
//        if (PP_ISNSLOG) {
//            NSLog(@"%@",sendMsgNotiClass);
//        }
//        [UnityPPPlatformDelegate U3D_addObserver];
//    }
//    
//    //弹出登录界面
//    void U3D_showLoginView()
//    {
//        [[PPAppPlatformKit sharedInstance] showLogin];
//    }
//    
//    //弹出用户中心
//    void U3D_showCenterView()
//    {
//        if ([[PPAppPlatformKit sharedInstance] currentUserId] <= 0) {
//            [[PPAppPlatformKit sharedInstance] showLogin];
//            return;
//        }
//        [[PPAppPlatformKit sharedInstance] showCenter];
//    }
//    
//
//
//
//    
//    uint64_t U3D_currentUserId(){
//        return [[PPAppPlatformKit sharedInstance] currentUserId];
//    }
//    
//    void U3D_currentUserName(){
//        UnitySendMessage([sendMsgNotiClass UTF8String], "U3D_currentUserName", [[[PPAppPlatformKit sharedInstance] currentUserName] UTF8String]);
//    }
//
//    
//    void U3D_exchangeGoods(double paramPrice,const char *paramBillNo,const char *paramBillTitle,const char *paramRoleId,
//                           int paramZoneId){
//        [[PPAppPlatformKit sharedInstance] exchangeGoods:paramPrice
//                                                  BillNo:CreateNSString(paramBillNo)
//                                               BillTitle:CreateNSString(paramBillTitle)
//                                                  RoleId:CreateNSString(paramRoleId)
//                                                  ZoneId:paramZoneId];
//    }
//    
//    void U3D_getUserInfoSecurity(){
//        [[PPAppPlatformKit sharedInstance] getUserInfoSecurity];
//    }
//    
//    
//    void U3D_alixPayResult(const char*paramURL){
//        [[PPAppPlatformKit sharedInstance] alixPayResult:[NSURL URLWithString:CreateNSString(paramURL)]];
//    }
//    
//    void U3D_PPlogout(){
//        [[PPAppPlatformKit sharedInstance] PPlogout];
//    }
//    
//    
//#if defined(__cplusplus)
//}
//#endif
//
//

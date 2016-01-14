///*
//
// Copyright (c) 2012, DIVIJ KUMAR
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// 
// The views and conclusions contained in the software and documentation are those
// of the authors and should not be interpreted as representing official policies,
// either expressed or implied, of the FreeBSD Project.
// 
// 
// */
//
///*
// * PPANEIOS.m
// * PPANEIOS
// *
// * Created by Seven on 13-6-21.
// * Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
// */
//
//
//
//#import "PPANEIOS.h"
//#import "PPUIKit.h"
//#import "PPLoginView.h"
//#import "PPCenterView.h"
//#import "PPAppPlatformKit.h"
//#import <UIKit/UIKit.h>
//#import "PPANEDelegate.h"
///* PPANEIOSExtInitializer()
// * The extension initializer is called the first time the ActionScript side of the extension
// * calls ExtensionContext.createExtensionContext() for any context.
// *
// * Please note: this should be same as the <initializer> specified in the extension.xml
// */
//static BOOL isInitSDK = NO;
//static PPAneDelegate *ppAneDelegate;
//FREContext g_ctx;
//
//
//
///* PPANEIOSExtFinalizer()
// * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
// *
// * Please note: this should be same as the <finalizer> specified in the extension.xml
// */
//void PPANEIOSExtFinalizer(void* extData)
//{
//    NSLog(@"Entering PPANEIOSExtFinalizer()");
//    
//    // Nothing to clean up.
//    NSLog(@"Exiting PPANEIOSExtFinalizer()");
//    return;
//}
//
//
//
//
//
///* This is a TEST function that is being included as part of this template.
// *
// * Users of this template are expected to change this and add similar functions
// * to be able to call the native functions in the ANE from their ActionScript code
// */
//ANE_FUNCTION(isSupported)
//{
//    NSLog(@"Entering IsSupported()");
//    
//    FREObject fo;
//    
//    FREResult aResult = FRENewObjectFromBool(YES, &fo);
//    if (aResult == FRE_OK)
//    {
//        NSLog(@"Result = %d", aResult);
//    }
//    else
//    {
//        NSLog(@"Result = %d", aResult);
//    }
//    
//	NSLog(@"Exiting IsSupported()");
//	return fo;
//}
//
//#pragma mark - 公开的函数 -
//
////初始化SDK
//FREObject initSDKPlatform(FREContext ctx,
//                          void* funcData, uint32_t argc,
//                          FREObject argv[])
//{
//    //  renRenNDObserver = [[RenRenNDObserver alloc]initWithFREContext:ctx];
//    //    context=ctx;
//    
//    NSLog(@"BEGIN initSDKPlatform");
//    
//    if (isInitSDK) {
//        return NULL;
//    }
//    isInitSDK = YES;
//    
//    
//    int initAppId = 0;
//    FREGetObjectAsInt32(argv[0], &initAppId);
//    
//    NSLog(@"BEGIN initSDKPlatform22");
//    
//    uint32_t appKeyLength;
//    const uint8_t *appKeychar;
//    FREGetObjectAsUTF8(argv[1], &appKeyLength, &appKeychar);
//    NSString *appKey =[NSString stringWithUTF8String:(char*)appKeychar];
//    
//    
//    
//    int rechargeAmount = 0;
//    FREGetObjectAsInt32(argv[2], &rechargeAmount);
//    
//    
//    uint32_t isNSlogDataInt;
//    FREGetObjectAsBool(argv[3], &isNSlogDataInt);
//    
//    BOOL isNSlogData = YES;
//    if(isNSlogDataInt == 0)
//        isNSlogData = NO;
//    
//    
//    uint32_t isLongCometInt;
//    FREGetObjectAsBool(argv[4], &isLongCometInt);
//    
//    BOOL isLongComet = YES;
//    if(isLongCometInt == 0)
//        isLongComet = NO;
//    
//    
//    
//    
//    uint32_t isLogOutPushLoginViewInt;
//    FREGetObjectAsBool(argv[5], &isLogOutPushLoginViewInt);
//    
//    BOOL isLogOutPushLoginView = YES;
//    if(isLogOutPushLoginViewInt == 0)
//        isLogOutPushLoginView = NO;
//    
//    
//    
//    
//    uint32_t isOpenRechargeInt;
//    FREGetObjectAsBool(argv[6], &isOpenRechargeInt);
//    
//    BOOL isOpenRecharge = YES;
//    if(isOpenRechargeInt == 0)
//        isOpenRecharge = NO;
//    
//    
//    
//    uint32_t closeRechargeAlertMessageLength;
//    const uint8_t *closeRechargeAlertMessageChar;
//    FREGetObjectAsUTF8(argv[7], &closeRechargeAlertMessageLength, &closeRechargeAlertMessageChar);
//    NSString *closeRechargeAlertMessage = [NSString stringWithUTF8String:(char*)closeRechargeAlertMessageChar];
//    
//    
//    
//    
//    uint32_t isDeviceOrientationLandscapeLeftInt;
//    FREGetObjectAsBool(argv[8], &isDeviceOrientationLandscapeLeftInt);
//    BOOL IsDeviceOrientationLandscapeLeft = YES;
//    if(isDeviceOrientationLandscapeLeftInt == 0)
//        IsDeviceOrientationLandscapeLeft = NO;
//    
//    
//    uint32_t isDeviceOrientationLandscapeRightInt;
//    FREGetObjectAsBool(argv[9], &isDeviceOrientationLandscapeRightInt);
//    BOOL IsDeviceOrientationLandscapeRight = YES;
//    if(isDeviceOrientationLandscapeRightInt == 0)
//        IsDeviceOrientationLandscapeRight = NO;
//    
//    
//    uint32_t isDeviceOrientationPortraitInt;
//    FREGetObjectAsBool(argv[10], &isDeviceOrientationPortraitInt);
//    BOOL isDeviceOrientationPortrait = YES;
//    if(isDeviceOrientationPortraitInt == 0)
//        isDeviceOrientationPortrait = NO;
//    
//    uint32_t isDeviceOrientationPortraitUpsideDownInt;
//    FREGetObjectAsBool(argv[11], &isDeviceOrientationPortraitUpsideDownInt);
//    BOOL isDeviceOrientationPortraitUpsideDown = YES;
//    if(isDeviceOrientationPortraitUpsideDownInt == 0)
//        isDeviceOrientationPortraitUpsideDown = NO;
//    
//    [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
//    
//    [[PPAppPlatformKit sharedInstance] setAppId:initAppId AppKey:appKey];
//    [[PPAppPlatformKit sharedInstance] setIsNSlogData:isNSlogData];
//    [[PPAppPlatformKit sharedInstance] setRechargeAmount:rechargeAmount];
//    [[PPAppPlatformKit sharedInstance] setIsLongComet:isLongComet];
//    [[PPAppPlatformKit sharedInstance] setIsLogOutPushLoginView:isLogOutPushLoginView];
//    [[PPAppPlatformKit sharedInstance] setIsOpenRecharge:isOpenRecharge];
//    [[PPAppPlatformKit sharedInstance] setCloseRechargeAlertMessage:closeRechargeAlertMessage];
//    [[PPUIKit sharedInstance] checkGameUpdate];
//    
//    [PPUIKit setIsDeviceOrientationLandscapeLeft:IsDeviceOrientationLandscapeLeft];
//    [PPUIKit setIsDeviceOrientationLandscapeRight:IsDeviceOrientationLandscapeRight];
//    [PPUIKit setIsDeviceOrientationPortrait:isDeviceOrientationPortrait];
//    [PPUIKit setIsDeviceOrientationPortraitUpsideDown:isDeviceOrientationPortraitUpsideDown];
//    
//    
//    //添加回调事件，从IOS 向FlashBuilder 通信
//    ppAneDelegate = [[PPAneDelegate alloc] init];
//    [ppAneDelegate ppAddObserverInit];
//    
//    
//    
//    
//    
//    
//    
//    NSLog(@"END initSDKPlatform");
//    return NULL;
//}
////显示登录界面
//FREObject showLoginView(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
//    [[PPAppPlatformKit sharedInstance] showLogin];
//    return NULL;
//}
////显示用户中心
//FREObject showCenterView(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
//    [[PPAppPlatformKit sharedInstance] showCenter];
//    return NULL;
//}
//
////得到用户安全级别
//FREObject getUserInfoSecurity(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
//    [[PPAppPlatformKit sharedInstance] getUserInfoSecurity];
//    return NULL;
//}
////得到用户ID
//FREObject currentUserId(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
//    NSString *currentUId = [NSString stringWithFormat:@"%lld",[[PPAppPlatformKit sharedInstance] currentUserId]];
//    const char *tempStr = [currentUId UTF8String];
//    FREObject resultStr;
//    FRENewObjectFromUTF8(strlen(tempStr) + 1, (const uint8_t*)tempStr, &resultStr);
//    return resultStr;
//    
//}
////得到用户UserName
//FREObject currentUserName(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
//    NSString *currentUName = [NSString stringWithFormat:@"%@",[[PPAppPlatformKit sharedInstance] currentUserName]];
//    const char *tempStr = [currentUName UTF8String];
//    FREObject resultStr;
//    FRENewObjectFromUTF8(strlen(tempStr) + 1, (const uint8_t*)tempStr, &resultStr);
//    return resultStr;
//}
////支付宝快捷支付 回到程序
//FREObject alixPayResult(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
//    uint32_t urlLength;
//    const uint8_t *urlChar;
//    FREGetObjectAsUTF8(argv[0], &urlLength, &urlChar);
//    NSString *ulr = [NSString stringWithUTF8String:(char*)urlChar];
//    [[PPAppPlatformKit sharedInstance] alixPayResult:[NSURL URLWithString:ulr]];
//    return NULL;
//}
////退出
//FREObject logout(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
//    [[PPAppPlatformKit sharedInstance] PPlogout];
//    return NULL;
//}
//
////兑换道具
//
//FREObject exchangeGoods(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
//    double price = 0;
//    FREGetObjectAsDouble(argv[0], &price);
//    
//    uint32_t billNoLength;
//    const uint8_t *billNoChar;
//    FREGetObjectAsUTF8(argv[1], &billNoLength, &billNoChar);
//    NSString *billNo =[NSString stringWithUTF8String:(char*)billNoChar];
//    
//    
//    
//    uint32_t billTitleLength;
//    const uint8_t *billTitleChar;
//    FREGetObjectAsUTF8(argv[2], &billTitleLength, &billTitleChar);
//    NSString *billTitle =[NSString stringWithUTF8String:(char*)billTitleChar];
//    
//    
//    uint32_t roleIdLength;
//    const uint8_t *roleIdChar;
//    FREGetObjectAsUTF8(argv[3], &roleIdLength, &roleIdChar);
//    NSString *roleId =[NSString stringWithUTF8String:(char*)roleIdChar];
//    
//    
//    int zoneId = 0;
//    FREGetObjectAsInt32(argv[4], &zoneId);
//    [[PPAppPlatformKit sharedInstance] exchangeGoods:price BillNo:billNo BillTitle:billTitle RoleId:roleId ZoneId:zoneId];
//    
//    return NULL;
//}
//
//
//#pragma mark - 指定开始/结束函数，开始/结束函数 -
////指定初始化函数和程序退出函数
//void PPANEIOSExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
//{
//    NSLog(@"Entering PPANEIOSExtInitializer()");
//    
//    *extDataToSet = NULL;
//    *ctxInitializerToSet = &ContextInitializer; //初始化函数
//    *ctxFinalizerToSet = &ContextFinalizer;//退出函数
//    
//    NSLog(@"Exiting PPANEIOSExtInitializer()");
//}
//
////初始化函数 ,设置公开的函数，和公开函数的个数
///* ContextInitializer()
// * The context initializer is called when the runtime creates the extension context instance.
// */
//void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
//{
//    NSLog(@"Entering ContextInitializer()");
//    
//    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
//     */
//    
//    *numFunctionsToTest = 9; //设定的支持的函数个数
//    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * 16);
//	func[0].name = (const uint8_t*) "initSDKPlatform";
//	func[0].functionData = NULL;
//    func[0].function = &initSDKPlatform;
//    
//    func[1].name = (const uint8_t*) "showLoginView";
//	func[1].functionData = NULL;
//    func[1].function = &showLoginView;
//    
//    func[2].name = (const uint8_t*) "currentUserId";
//	func[2].functionData = NULL;
//    func[2].function = &currentUserId;
//    
//
//    
//    func[3].name = (const uint8_t*) "currentUserName";
//	func[3].functionData = NULL;
//    func[3].function = &currentUserName;
//    
//    func[4].name = (const uint8_t*) "exchangeGoods";
//	func[4].functionData = NULL;
//    func[4].function = &exchangeGoods;
//    
//    func[5].name = (const uint8_t*) "showCenterView";
//	func[5].functionData = NULL;
//    func[5].function = &showCenterView;
//
//    func[6].name = (const uint8_t*) "getUserInfoSecurity";
//	func[6].functionData = NULL;
//    func[6].function = &getUserInfoSecurity;
//    
//    func[7].name = (const uint8_t*) "alixPayResult";
//	func[7].functionData = NULL;
//    func[7].function = &alixPayResult;
//    
//    func[8].name = (const uint8_t*) "logout";
//	func[8].functionData = NULL;
//    func[8].function = &logout;
//    
//    
//    
//    
//    g_ctx = ctx;
//	*functionsToSet = func;
//    
//    
//    
//    NSLog(@"Exiting ContextInitializer()");
//}
//
//
//
////退出函数
//
///* ContextFinalizer()
// * The context finalizer is called when the extension's ActionScript code
// * calls the ExtensionContext instance's dispose() method.
// * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
// */
//void ContextFinalizer(FREContext ctx)
//{
//    NSLog(@"Entering ContextFinalizer()");
//    
//    // Nothing to clean up.
//    NSLog(@"Exiting ContextFinalizer()");
//    return;
//}
//
//
//
//

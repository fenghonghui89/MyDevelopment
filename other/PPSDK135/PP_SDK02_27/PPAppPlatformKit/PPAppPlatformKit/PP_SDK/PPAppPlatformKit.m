//
//  PPAppPlatform.m
//  PPAppPlatformKit
//
//  Created by 张熙文 on 1/11/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPAppPlatformKit.h"

#import "PPUserInfo.h"
#import "PPAlertSecurityView.h"
#import "PPCommon.h"
#import "PPMakeUser.h"
#import "PPUIKit.h"
#import "PPAlertView.h"
#import "PPAlixPay.h"
#import "PPNewMessageView.h"
#import "PPMarqueeView.h"

PPAppPlatformKit *AppPlatform;




@implementation PPAppPlatformKit

@synthesize delegate;

/**
 * @brief     初始化SDK信息
 * @return    PPAppPlatformKit    生成的PPAppPlatformKit对象实例
 */
+ (PPAppPlatformKit *)sharedInstance
{
    if(!AppPlatform){
        AppPlatform = [[PPAppPlatformKit alloc] init];
        [AppPlatform setCurrentUserId:0];
        [AppPlatform setAppId:0 AppKey:@"0"];
        [AppPlatform setIsNSlogData:NO];
//        [AppPlatform setCurrentAddress:@"https://pay.25pp.com"];
        [AppPlatform setCurrentAddress:@"https://testpay.25pp.com"];
        //        [AppPlatform setCurrentAddress:@"http://192.168.50.18:8000/"];
        //        [AppPlatform setCurrentAddress:@"http://10.4.193.18:8000"];
        [AppPlatform setIsOpenRecharge:YES];
        [AppPlatform setCloseRechargeAlertMessage:@"充值功能暂时不开放"];
        [AppPlatform setIsOneKeyLogin:NO];
        [AppPlatform setIsNeedBind:NO];
        [AppPlatform setCurrentShowUserName:@""];
        [AppPlatform setCurrent20MinToken:@""];
        [AppPlatform performSelector:@selector(countTimer) withObject:nil afterDelay:5];
        
        
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *filePath = [mainBundle pathForResource:[NSString stringWithFormat:@"PPImage.bundle/%@",@"JailBreak"]
                                                  ofType:@"txt"];
        BOOL isMainBundleTure = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        
        NSString *jbDocumentsDirectory= [NSHomeDirectory()
                                         stringByAppendingPathComponent:@"Documents/JailBreak.txt"];
        BOOL isJBDocumentTure = [[NSFileManager defaultManager] fileExistsAtPath:jbDocumentsDirectory];
        
        NSString *zbDocumentsDirectory= [NSHomeDirectory()
                                         stringByAppendingPathComponent:@"Documents/legalCopy.txt"];
        BOOL isZBDocumentTure = [[NSFileManager defaultManager] fileExistsAtPath:zbDocumentsDirectory];
        
        [AppPlatform setIsJailBreak:NO];
        return AppPlatform;
        
        
        if (isJBDocumentTure) {
            if (PP_ISNSLOG) {
                NSLog(@"yueyubao1");
            }
            [AppPlatform setIsJailBreak:YES];
            return AppPlatform;
        }
        else if (isZBDocumentTure)
        {
            if (PP_ISNSLOG) {
                
                NSLog(@"zhengban1");
            }
            [AppPlatform setIsJailBreak:NO];
            return AppPlatform;
        }
        
        
        if (isMainBundleTure) {
            if (PP_ISNSLOG) {
                NSLog(@"yueyubao2");
            }
            [AppPlatform setIsJailBreak:YES];
            [[NSFileManager defaultManager] createFileAtPath:jbDocumentsDirectory contents:nil attributes:nil];
            [[NSFileManager defaultManager] removeItemAtPath:zbDocumentsDirectory error:nil];
            return AppPlatform;
        }else{
            if (PP_ISNSLOG) {
                NSLog(@"zhengban2");
            }
            [AppPlatform setIsJailBreak:NO];
            [[NSFileManager defaultManager] createFileAtPath:zbDocumentsDirectory contents:nil attributes:nil];
            [[NSFileManager defaultManager] removeItemAtPath:jbDocumentsDirectory error:nil];
            return AppPlatform;
        }
        
    }
    return AppPlatform;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _noticeQueue = [[PPQueue alloc] initWithSize:20];
        _isNoticeDisplaying = NO;

    }
    return self;
}

#pragma mark - 显示 登录界面,用户中心,注销退出 , 通知界面 -
/**
 *  显示登录界面
 */
-(void)showLogin
{
    if (![PPUIKit getVerifyingUpdate]) {
        [[PPUIKit sharedInstance] checkGameUpdate];
        return;
    }
    PPLoginView *ppLoginView = [[PPLoginView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppLoginView atIndex:1000];
    [ppLoginView showLoginViewByRight];
    [ppLoginView release];
}

/**
 *  显示用户中心
 */
-(void)showCenter{
    PPCenterView *ppCenterView = [[PPCenterView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppCenterView atIndex:1002];
    [ppCenterView showCenterViewByRight];
    [ppCenterView release];
}

/// <summary>
/// 注销用户
/// </summary>
/// <returns>无返回</returns>
- (void)PPlogout
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PP_A"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    [AppPlatform setIsOneKeyLogin:NO];
    [AppPlatform setIsNeedBind:NO];
    [AppPlatform setCurrentUserId:0];
    [AppPlatform setCurrentUserName:@""];
    [AppPlatform setCurrentShowUserName:@""];
    [AppPlatform setNewEmailId:0];
    [AppPlatform setNewEmailSendDate:0];
    [AppPlatform setCurrent20MinToken:@""];
    
    
    if (_isNoticeDisplaying) {
        [[PPMarqueeView sharedInstance] hiddenMarqueeView];
    }
    
    while (![_noticeQueue isEmpty]) {
        [[_noticeQueue dequeue] release];
    }
    [_noticeQueue releaseData];
}

-(void)showLoginNotiView{
    if (PP_REQUEST_USERID > 0) {
        [[PPLoginSucceedNotiView sharedInstance] showNotiView];
    }
}

#pragma mark - 设置/获取 20分钟Token -

-(NSString *)current20MinToken{
    return current20MinToken;
}

-(void)setCurrent20MinToken:(NSString *)paramCurrent20MinToken{
    if (current20MinToken) {
        [current20MinToken release];
        current20MinToken = nil;
    }
    current20MinToken = [[NSString alloc] initWithString:paramCurrent20MinToken];;
}

#pragma mark - 兑换道具 ,  调出充值并且兑换接口 -
/**
 * @brief     兑换道具
 * @noti      只有余额大于道具金额时候才有客户端回调。余额不足的情况取决与paramIsLongComet参数，paramIsLongComet = YES，则为充值兑换。回调给服务端，paramIsLongComet = NO ，则只是打开充值界面
 * @param     INPUT paramPrice      商品价格，价格必须为大于等于1的int类型
 * @param     INPUT paramBillNo     商品订单号，订单号长度请勿超过30位，参有特殊符号
 * @param     INPUT paramBillTitle  商品名称
 * @param     INPUT paramRoleId     角色id，回传参数若无请填0
 * @param     INPUT paramZoneId     开发者中心后台配置的分区id，若无请填写0
 * @return    无返回
 */

- (void)exchangeGoods:(int)paramPrice
               BillNo:(NSString *)paramBillNo
            BillTitle:(NSString *)paramBillTitle
               RoleId:(NSString *)paramRoleId
               ZoneId:(int)paramZoneId
{

    //兑换道具处理
    PPExchange *exchange = [[PPExchange alloc] init];
    //查询余额
    int money = [[NSString stringWithFormat:@"%f",[exchange ppSYPPMoneyRequest]] intValue];
    if (money == -2) {
        [exchange release];
        return;
    }
    NSString *priStr = [NSString stringWithFormat:@"%d",paramPrice];
    if (billNo) {
        [billNo release];
        billNo = nil;
    }
    
    if (price) {
        [price release];
        price = nil;
    }
    
    if (billTitle) {
        [billTitle release];
        billTitle = nil;
    }
    if (roleId) {
        [roleId release];
        roleId = nil;
    }
    
    billNo = [[NSString alloc] initWithString:paramBillNo];;
    price = [[NSString alloc] initWithString:priStr];
    billTitle = [[NSString alloc] initWithString:paramBillTitle];
    roleId = [[NSString alloc] initWithString:paramRoleId];
    zoneId = paramZoneId;
    
    if(money >= paramPrice){
        //如果PP币余额大于道具的金额。就直接调用兑换接口进行兑换
        PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"确定购买？"];
        [alertView addButtonWithTitle:@"取消" block:^
        {
//            [[[PPAppPlatformKit sharedInstance] delegate] ppPayCancelCallBack];
            [[[PPAppPlatformKit sharedInstance] delegate] ppPayResultCallBack:PPPayResultCodeCancel];
        }];
        [alertView setCancelButtonTitle:@"确定" block:^
        {
            PPExchange *exchange = [[PPExchange alloc] init];
            [exchange ppExchangeToGameRequestWithBillNo:billNo Amount:price RoleId:roleId ZoneId:zoneId];
            [exchange release];
        }];
        [alertView show];
        [alertView release];
    }else {
        //设置订单号
        if (isLongComet) {
            PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"您的PP币不足，您需要先充值后直接为您购买？"];
            [alertView setCancelButtonTitle:@"充值PP币" block:^{
                [self showRechargeAndExchange];
            }];
            [alertView addButtonWithTitle:@"取消" block:^{
                [[[PPAppPlatformKit sharedInstance] delegate] ppPayResultCallBack:PPPayResultCodeCancel];
                
            }];
            [alertView show];
            [alertView release];

        }else{
            PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"您的PP币不足，您需要先充值后再自行购买？"];
            [alertView setCancelButtonTitle:@"充值PP币" block:^{
                PPWebView *ppWebView = [[PPWebView alloc] init];
                [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
                [ppWebView rechargeWebShow:price];
                [ppWebView release];
                
                
            }];
            [alertView addButtonWithTitle:@"取消" block:^{
//                [[[PPAppPlatformKit sharedInstance] delegate] ppPayCancelCallBack];
                [[[PPAppPlatformKit sharedInstance] delegate] ppPayResultCallBack:PPPayResultCodeCancel];
            }];
            [alertView show];
            [alertView release];
        }
          
    }
    [exchange release];
}
/**
 *  调出充值并且兑换接口
 */
-(void)showRechargeAndExchange
{
    PPWebView *ppWebView = [[PPWebView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
    [ppWebView rechargeAndExchangeWebShow:billNo
                                               BillNoTitle:billTitle
                                                  PayMoney:price
                                                    RoleId:roleId
                                                    ZoneId:zoneId];
    [ppWebView release];
}

#pragma mark - 自动登录，充值状态，是否越狱 ，是否为长连接 ,是否允许打印,是否自动push出登陆 -


-(void)setIsAutoLogin:(BOOL)paramIsAutoLogin{
    isAutoLogin = paramIsAutoLogin;
}

-(BOOL)isAutoLogin{
    return isAutoLogin;
}

-(void)setIsOpenRecharge:(BOOL)paramIsOpenRecharge{
    isOpenRecharge = paramIsOpenRecharge;
}

-(BOOL)isOpenRecharge{
    return isOpenRecharge;
}

-(void)setIsJailBreak:(BOOL)paramIsJailBreak{
    isJailBreak = paramIsJailBreak;
}

-(BOOL)isJailBreak{
    return isJailBreak;
}

/**
 *  判断游戏客户端与游戏服务端链接方式是否为长连接【如果游戏服务端能主动与游戏客户端交互
 *  。例如发放道具则为长连接。此处设置影响充值并兑换的方式】
 *
 *  @return BOOL
 */
-(BOOL)isLongComet{
    return isLongComet;
}
/**
 *  设置游戏客户端与游戏服务端链接方式是否为长连接【如果游戏服务端能主动与游戏客户端交互。
 *  例如发放道具则为长连接。此处设置影响充值并兑换的方式】
 *
 *  @param paramIsLongComet BOOL
 */
-(void)setIsLongComet:(BOOL)paramIsLongComet{
    isLongComet = paramIsLongComet;
}

/**
 *  获取SDK是否允许打印日志到控制台
 *
 *  @return BOOL
 */
-(BOOL)isNSlogData{
    return isNSlogData;
}
/**
 *  设置SDK是否允许打印日志到控制台 PS：默认开启
 *
 *  @param paramIsNSlogDatad BOOL
 */
-(void)setIsNSlogData:(BOOL)paramIsNSlogDatad{
    isNSlogData = paramIsNSlogDatad;
}
/**
 *  获取SDK用户注销后是否自动push出登陆
 *
 *  @return BOOL
 */
- (BOOL)isLogOutPushLoginView{
    return isLogOutPushLoginView;
}
/**
 *  设置SDK用户注销后是否自动push出登陆
 *
 *  @param paramIsLogOutPushLoginView BOOL
 */
- (void)setIsLogOutPushLoginView:(BOOL)paramIsLogOutPushLoginView{
    isLogOutPushLoginView = paramIsLogOutPushLoginView;
}


#pragma mark - 设置 (关闭充值提示语 ,请求的主地址,游戏的AppId,充值页面默认金额,currentUserName,currentUserId,newEmailId)-


-(void)setCloseRechargeAlertMessage:(NSString *)paramCloseRechargeAlertMessage{
    [paramCloseRechargeAlertMessage retain];
    if (closeRechargeAlertMessage) {
        [closeRechargeAlertMessage release];
        closeRechargeAlertMessage = nil;
    }
    closeRechargeAlertMessage = paramCloseRechargeAlertMessage;
}

-(NSString *)closeRechargeAlertMessage{
    return closeRechargeAlertMessage;
}


-(void)setCurrentAddress:(NSString *)paramCurrentAddress{
    [paramCurrentAddress retain];
    if (currentAddress) {
        [currentAddress release];
        currentAddress = nil;
    }
    currentAddress = paramCurrentAddress;
}

-(NSString *)currentAddress{
    return currentAddress;
}

/// <summary>
/// 获取该游戏的AppId
/// </summary>
/// <returns>整型AppId</returns>
- (int)appId{
    return appId;
}

/// <summary>
/// 获取该游戏的AppKey
/// </summary>
/// <returns>字符串AppKey</returns>
- (NSString *)appKey{
    return appKey;
}


/// <summary>
/// 设置充值页面默认金额
/// </summary>
/// <param name="Amount">金额</param>
/// <returns>无返回</returns>
-(void)setRechargeAmount:(int)paramAmount{
    rechargeAmount = paramAmount;
}

/// <summary>
/// 获取充值页面默认金额
/// </summary>
/// <returns>返回rechargeAmount</returns>
-(int)getRechargeAmout{
    return rechargeAmount;
}


/// <summary>
/// 获取当前用户currentUserName
/// </summary>
/// <returns>返回currentUserName</returns>
-(NSString *)currentUserName{
    return currentUserName;
}

/// <summary>
/// 设置当前用户名
/// </summary>
/// <param name="CurrentUserName">用户名</param>
/// <returns>无返回</returns>
-(void)setCurrentUserName:(NSString *)paramCurrentUserName{
    [paramCurrentUserName retain];
    if (currentUserName) {
        [currentUserName release];
        currentUserName = nil;
    }
    currentUserName = paramCurrentUserName;
}


/// <summary>
/// 获取当前用户显示currentShowUserName
/// </summary>
/// <returns>返回currentShowUserName</returns>
-(NSString *)currentShowUserName{
    return currentShowUserName;
}

/// <summary>
/// 设置当前UI显示用户名
/// </summary>
/// <param name="CurrentUserName">用户名</param>
/// <returns>无返回</returns>
-(void)setCurrentShowUserName:(NSString *)paramCurrentShowUserName{
    [paramCurrentShowUserName retain];
    if (currentShowUserName) {
        [currentShowUserName release];
        currentShowUserName = nil;
    }
    currentShowUserName = paramCurrentShowUserName;
}

/// <summary>
/// 获取当前用户currentUserId
/// </summary>
/// <returns>返回currentUserId</returns>
-(uint64_t)currentUserId{
    return currentUserId;
}

/// <summary>
/// 设置当前用户的CurrentUserId
/// </summary>
/// <param name="CurrentUserId">用户Id</param>
/// <returns>无返回</returns>
-(void)setCurrentUserId:(uint64_t)paramCurrentUserId{
    currentUserId = paramCurrentUserId;
}

- (int)newEmailId{
    return newEmailId;
}

- (void)setNewEmailId:(int)paramEmailId
{
    newEmailId = paramEmailId;
}

#pragma mark - 设置 （newEmailSendDate，AppKey，AppID，），获取帐号的安全级别 -

- (int)newEmailSendDate{
    return newEmailSendDate;
}

- (void)setNewEmailSendDate:(NSTimeInterval)paramNewEmailSendDate
{
    newEmailSendDate = paramNewEmailSendDate;
}


/// <summary>
/// 设置该游戏的AppKey和AppId。从开发者中心游戏列表获取
/// </summary>
/// <param name="AppId">游戏Id</param>
/// <param name="AppKey">游戏Id</param>
/// <returns>无返回</returns>
- (void)setAppId:(int)paramAppId AppKey:(NSString *)paramAppKey{
    appId = paramAppId;
    [paramAppKey retain];
    if (appKey) {
        [appKey release];
        appKey = nil;
    }
    appKey = paramAppKey;
}



/// <summary>
/// 获取帐号的安全级别
/// </summary>
/// <returns>无返回</returns>
- (void)getUserInfoSecurity{
    [self performSelector:@selector(showLoginNotiView) withObject:nil afterDelay:0.3];
//    PPAccountsSecurityCenter *synNet = [[PPAccountsSecurityCenter alloc] init];
//    //如果一键登录就发临时用户名去查询密保情况【包括绑定用户】
//    if ([[PPAppPlatformKit sharedInstance] isOneKeyLogin]) {
//        [synNet ppQuestionAnswerSettedRequest:[NSString stringWithUTF8String:[[PPAppPlatformKit sharedInstance] getTempLoginUserName]]];
//    }else{
//        [synNet ppQuestionAnswerSettedRequest:[NSString stringWithFormat:@"%@",
//                                               [[PPAppPlatformKit sharedInstance] currentShowUserName]]];
//    }
//    [synNet release];
}

#pragma mark - 后台发送心跳，获取通知，邮件，公告 （一直请求）-

-(void)countTimer
{
    ppSendHrateRequestTimer = [NSTimer scheduledTimerWithTimeInterval: 60.0
                                                               target: self
                                                             selector: @selector(handleTimer)
                                                             userInfo: nil
                                                              repeats: YES];
//    [self performSelector:@selector(a) withObject:nil afterDelay:1];

    [ppSendHrateRequestTimer fire];
}

-(void)handleTimer
{
    //如果用户注销则不发送心跳
    if (PP_REQUEST_USERID > 0) {
        PPOnlineNet *net = [[PPOnlineNet alloc] init];
        [net ppAppOnlineHrateRequest:PP_REQUEST_USERID];
        [net release];
        
        NSString *str = [[PPAppPlatformKit sharedInstance] current20MinToken];
        if (str == nil || str.length <= 1) {
            return;
        }
        char hexToKen[16];
        str_to_hex((char *)[[[PPAppPlatformKit sharedInstance] current20MinToken] UTF8String], 32, (unsigned char *)hexToKen);
        PPNoticeManager *ppNoticeManagerCNM = [[PPNoticeManager alloc] init];
        PPNoticeManager *ppNoticeManagerGM = [[PPNoticeManager alloc] init];
        
        [ppNoticeManagerCNM ppRequestCheckNewMessage:0 Token:hexToKen Type:MessageTypeOfEmail delegate:self];
        [ppNoticeManagerGM ppRequestGetMessage:0 Token:hexToKen Type:MessageTypeOfNoti CurrPage:0 delegate:self];
        [ppNoticeManagerCNM release];
        [ppNoticeManagerGM release];
        
    }
}

#pragma mark - 显示公告，通知，邮件 -

- (void)displayQueue
{
    
    _isNoticeDisplaying = NO;
    PPNotice *ppNotice = (PPNotice *)[_noticeQueue dequeue];
    if (ppNotice)
    {
        _isNoticeDisplaying = YES;
        if (ppNotice.messageType == MessageTypeOfEmail)
        {
            [[PPNewMessageView sharedInstance] showNotiView];
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            {
                [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(displayQueue) userInfo:nil repeats:NO ];
            }else
            {
                [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(displayQueue) userInfo:nil repeats:NO ];
            }
        }
        if (ppNotice.messageType == MessageTypeOfNoti) {
            
            NSString *text = ppNotice.content;
            text =[text stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"\r\n"] withString:[NSString stringWithFormat:@" "]];
            CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(9999, 20) lineBreakMode:NSLineBreakByWordWrapping];
            
            [[PPMarqueeView sharedInstance] setText:text];
            [[PPMarqueeView sharedInstance] showMarqueeView];
            
            
            float time = 0;
            
            UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
            if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
            {
                
                time = (labelSize.width + UI_SCREEN_HEIGHT) / 50 + 2;
            }
            else if (interfaceOrientation == UIInterfaceOrientationPortrait|| interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            {
                time = (labelSize.width + UI_SCREEN_WIDTH) / 50 + 2;
            }
            [self performSelector:@selector(displayQueue) withObject:nil afterDelay:time];
        }
    }
    
}

#pragma mark - PPNoticeManagerDelegate CallBack -
/**
 *  查询新邮件
 *
 *  @param paramPPNotice 数据
 */
- (void)didSuccessQurMessageCallBack:(PPNotice *)paramPPNotice{
    
    if (PP_ISNSLOG) {
        NSLog(@"请求查询新邮件的回调");
    }
    
    //先将对象放到队列中
    [_noticeQueue enqueue:paramPPNotice];
    //接着取出队头元素，判断是邮件还是公告
    if (currentUserId > 0) {
        if (!_isNoticeDisplaying) {
            [self displayQueue];
        }
    }
}
/**
 *  失败 获取到Push信息
 *
 *  @param paramPPNotice 数据
 */
- (void)didFailGetMessageCallBack:(MessageStatus)status
{
    if (PP_ISNSLOG) {
        NSLog(@"status = %u",status);
    }
    
}
/**
 *  成功 获取到Push信息
 *
 *  @param paramPPNotice 数据
 */
- (void)didSuccessGetMessageCallBack:(PPNotice *)paramPPNotice
{
    //先将对象放到队列中
    [_noticeQueue enqueue:paramPPNotice];
    if (currentUserId > 0) {
        if (!_isNoticeDisplaying) {
            [self displayQueue];
        }
    }
    //取出本地公告记录
    //获取路径
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *directory = [NSString stringWithFormat:@"%@",[[[PPAppPlatformKit sharedInstance] currentUserName] lowercaseString]];
    NSString *userDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:directory];
    
    if (PP_ISNSLOG) {
        NSLog(@"请求公告列表的回调");
    }
    
    //获取文件路径
    
    NSString *path = [userDirectory stringByAppendingPathComponent:@"PPNoticeData.plist"];
    
    PPNoticeManager *ppNoticeManager = [[PPNoticeManager alloc] init];
    [ppNoticeManager setNoticePath:path];
    [ppNoticeManager release];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    if (array == nil) {
        //创建文件夹
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir;
        // isDir判断是否为文件夹
        if (! [fileManager fileExistsAtPath:userDirectory isDirectory:&isDir]) {
            
            [fileManager createDirectoryAtPath:userDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSDictionary *noticeDic = [PPCommon getObjectData:paramPPNotice];
        array = [[NSMutableArray alloc] init];
        [array insertObject:noticeDic atIndex:0];
        BOOL sucess = [array writeToFile:path atomically:YES];
        if (sucess) {
            
        }
        [array release];
    }
    else
    {
        if ([array count] == 0)
        {
            NSDictionary *noticeDic = [PPCommon getObjectData:paramPPNotice];
            [array insertObject:noticeDic atIndex:0];
            BOOL sucess = [array writeToFile:path atomically:YES];
            if (sucess) {
                
            }
            [array release];
        }
        else
        {
            for (int i = 0; i < [array count]; i++) {
                NSDictionary *dic = [array objectAtIndex:i];
                int messageId = [[dic objectForKey:@"messageId"] intValue];
                if (messageId != [paramPPNotice messageId]) {
                    NSDictionary *noticeDic = [PPCommon getObjectData:paramPPNotice];
                    [array insertObject:noticeDic atIndex:0];
                    BOOL sucess = [array writeToFile:path atomically:YES];
                    if (sucess) {
                        
                    }
                    [array release];
                    break;
                }
            }
        }
    }
}

/**
 * @description 请求失败回调（通信层） - PPNoticeManagerDelegate
 * @param errorCode: TRHTTPConnectionError
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didFailRequestConnectionCallBack:(PPNoticeManager *)ppNoticeManager
                               errorCode:(TRHTTPConnectionError)errorCode
                                userInfo:(NSMutableDictionary *)userInfo
{
    NSLog(@"请求获取消息失败！");
}


#pragma mark - 快捷支付 结果 -
- (void)alixPayResult:(NSURL *)paramURL
{
    PPAlixPay *ppAlixPay = [[PPAlixPay alloc] init];
    [ppAlixPay handleOpenURL:paramURL];
    [ppAlixPay release];
}
/**
 *  快捷支付 支付结果
 *
 *  @param resultd 结果ID
 */
-(void)paymentResult:(NSString *)resultd
{
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
    if (PP_ISNSLOG) {
        NSLog(@"%d-",result.statusCode);
    }
	if (result)
    {
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            //            NSString *key = AlipayPubKey;
            //            //签约帐户后获取到的支付宝公钥
//                    id<DataVerifier> verifier = CreateRSADataVerifier(key);
            NSString *message = @"";
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            message = @"支付成功";
            //			}
            //            else
            //            {
            //                message = @"签名错误";
            //            }
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:message];
            [alert setCancelButtonTitle:@"确定" block:^{
                
            }];
            [alert addButtonWithTitle:nil block:nil];
            [alert show];
            [alert release];
        }
        else
        {
            //交易失败
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:result.statusMessage];
            [alert setCancelButtonTitle:@"确定" block:^{
            }];
            [alert addButtonWithTitle:nil block:nil];
            [alert show];
            [alert release];
        }
    }
    else
    {
        //失败
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:result.statusMessage];
        [alert setCancelButtonTitle:@"确定" block:^{
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    
    
}

#pragma mark - dealloc -

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - 零时账号，密码 ，一键登录，绑定（过期）-
/**
 * @description 请求验证TokenKey成功回调
 * @param userName: 用户名
 * @param userId: 用户表ID
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didSuccessRequestVerificationTokenKey:(TRUserRequest*)tRUserRequest
                                     userName:(NSString*)userName
                                       userId:(unsigned long long)userId
                                     userInfo:(NSMutableDictionary*)userInfo
{
    
}

-(void)setIsOneKeyLogin:(BOOL)paramIsOneKeyLogin{
    isOneKeyLogin = paramIsOneKeyLogin;
}

-(BOOL)isOneKeyLogin{
    return isOneKeyLogin;
}
-(void)setIsNeedBind:(BOOL)paramIsNeedBind{
    isNeedBind = paramIsNeedBind;
}

-(BOOL)isNeedBind{
    return isNeedBind;
}


-(char *)getTempLoginUserName{
    return tempLoginUserName;
}

-(char *)getTempLoginPassWord{
    return tempLoginPassWord;
}

//- (void)displayQueue
//{
//
//    _isNoticeDisplaying = NO;
//    PPNotice *ppNotice = (PPNotice *)[_noticeQueue dequeue];
//    if (ppNotice)
//    {
//        _isNoticeDisplaying = YES;
//        if (ppNotice.messageType == MessageTypeOfEmail)
//        {
//            [[PPNewMessageView sharedInstance] showNotiView];
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//            {
//                [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(displayQueue) userInfo:nil repeats:NO ];
//            }else
//            {
//                [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(displayQueue) userInfo:nil repeats:NO ];
//            }
//        }
//        if (ppNotice.messageType == MessageTypeOfNoti) {
//
//            NSString *text = ppNotice.content;
//            text =[text stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"\r\n"] withString:[NSString stringWithFormat:@" "]];
//            CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(9999, 20) lineBreakMode:NSLineBreakByWordWrapping];
//
//            [[PPMarqueeView sharedInstance] showMarqueeView];
//            [[PPMarqueeView sharedInstance] setText:text];
//
//            float time = 0;
//
//            UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
//            if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
//            {
//
//                time = (labelSize.width + UI_SCREEN_HEIGHT) / 50 + 2;
//            }
//            else if (interfaceOrientation == UIInterfaceOrientationPortrait|| interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
//            {
//                time = (labelSize.width + UI_SCREEN_WIDTH) / 50 + 2;
//            }
//            [self performSelector:@selector(displayQueue) withObject:nil afterDelay:time];
//        }
//    }
//
//}

@end

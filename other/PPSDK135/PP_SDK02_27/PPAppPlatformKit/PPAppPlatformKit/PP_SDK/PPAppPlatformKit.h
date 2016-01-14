//
//  PPAppPlatform.h
//  PPAppPlatformKit
//  V1.3.4
//  Created by 张熙文 on 1/11/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "PPAppPlatformKitConfig.h"
#import "PPExchange.h"
#import "PPUIKit.h"
#import "PPWebView.h"
#import "PPLoginView.h"
#import "PPCenterView.h"
#import "PPAccountsSecurityCenter.h"
#import "PPLoginSucceedNotiView.h"
#import "PPAlixPay.h"
#import "PPNoticeManager.h"
#import "PPQueue.h"



@class PPAppPlatformKit;

/**
 * @protocol   PPAppPlatformKitDelegate
 * @brief   SDK接口回调协议
 */
@protocol PPAppPlatformKitDelegate <NSObject>
@required
/**
 * @brief   余额大于所购买道具
 * @param   INPUT   paramPPPayResultCode       接口返回的结果编码
 * @return  无返回
 */
- (void)ppPayResultCallBack:(PPPayResultCode)paramPPPayResultCode;
/**
 * @brief   验证更新成功后
 * @noti    分别在非强制更新点击取消更新和暂无更新时触发回调用于通知弹出登录界面
 * @return  无返回
 */
- (void)ppVerifyingUpdatePassCallBack;
/**
 * @brief   登录成功回调【任其一种验证即可】
 * @param   INPUT   paramStrToKenKey       字符串token
 * @return  无返回
 */
- (void)ppLoginStrCallBack:(NSString *)paramStrToKenKey;
/**
 * @brief   关闭Web页面后的回调
 * @param   INPUT   paramPPWebViewCode    接口返回的页面编码
 * @return  无返回
 */
- (void)ppCloseWebViewCallBack:(PPWebViewCode)paramPPWebViewCode;
/**
 * @brief   关闭SDK客户端页面后的回调
 * @param   INPUT   paramPPPageCode       接口返回的页面编码
 * @return  无返回
 */
- (void)ppClosePageViewCallBack:(PPPageCode)paramPPPageCode;
/**
 * @brief   注销后的回调
 * @return  无返回
 */
- (void)ppLogOffCallBack;



@optional
/**
 * @brief   登录成功回调【任其一种验证即可】
 * @param   INPUT   paramHexToKen          2进制token
 * @return  无返回
 */
- (void)ppLoginHexCallBack:(char *)paramHexToKen;

@end

@interface PPAppPlatformKit : NSObject
<
PPNoticeManagerDelegate
>
{
    int appId;
    NSString *appKey;
    NSString *currentUserName;
    uint64_t currentUserId;
    BOOL isNSlogData;
    int rechargeAmount;
    BOOL isLongComet;
    BOOL isLogOutPushLoginView;
    BOOL isAutoLogin;
    NSString *currentAddress;
    BOOL isOpenRecharge;
    NSString *closeRechargeAlertMessage;
    BOOL isOneKeyLogin;
    BOOL isNeedBind;
    NSString *currentShowUserName;
    NSTimer *ppSendHrateRequestTimer;
    
    char tempLoginUserName[16];
    char tempLoginPassWord[16];
    
    
    NSString *price;
    NSString *billNo;
    NSString *billTitle;
    NSString *roleId;
    int zoneId;
    
    UIImage *currentImage;
    id<PPAppPlatformKitDelegate> delegate;
    NSString *current20MinToken;
    NSTimeInterval newEmailSendDate;
    int newEmailId;
    NSDate *startTime;
    
    PPQueue *_noticeQueue;
    BOOL _isNoticeDisplaying;
    UIView *_marqueeView;
    
    BOOL isJailBreak;
    
}

@property (nonatomic, retain) id<PPAppPlatformKitDelegate> delegate;


/**
 * @brief     初始化SDK信息
 * @return    PPAppPlatformKit    生成的PPAppPlatformKit对象实例
 */
+ (PPAppPlatformKit *)sharedInstance;

/**
 * @brief  处理支付宝客户端唤回后的回调数据
 * @note   处理支付宝客户端通过URL启动App时传递的数据,需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @note   需同时在 URL Types 里面添加urlscheme 为PPAppPlatformKit,
 * @param  INPUT  paramURL     启动App的URL
 * @return    无返回
 */
- (void)alixPayResult:(NSURL *)paramURL;


/**
 * @brief     弹出PP登录页面
 * @return    无返回
 */
- (void)showLogin;

/**
 * @brief     弹出PP中心页面
 * @return    无返回
 */
- (void)showCenter;



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
               ZoneId:(int)paramZoneId;



/**
 * @brief     设置关闭充值提示语
 * @param     INPUT paramCloseRechargeAlertMessage      关闭充值时弹窗的提示语
 * @return    无返回
 */
- (void)setCloseRechargeAlertMessage:(NSString *)paramCloseRechargeAlertMessage;


/**
 * @brief     充值状态设置
 * @param     INPUT paramIsOpenRecharge      YES为开启，NO为关闭。
 * @return    无返回
 */
- (void)setIsOpenRecharge:(BOOL)paramIsOpenRecharge;


/**
 * @brief     注销用户，清除自动登录状态
 * @return    无返回
 */
- (void)PPlogout;


/**
 * @brief     设定充值页面默认充值数额
 * @note      paramAmount 大于等于1的整数
 * @param     INPUT paramAmount      充值金额
 * @return    无返回
 */
- (void)setRechargeAmount:(int)paramAmount;



/**
 * @brief     获取用户名
 * @return    返回当前登录用户名
 */
-(NSString *)currentUserName;

/**
 * @brief     获取用户id
 * @return    返回当前登录用户id
 */
- (uint64_t)currentUserId;






/**
 * @brief     设定打印SDK日志
 * @note      发布时请务必改为NO
 * @param     INPUT paramIsNSlogDatad     YES为开启，NO为关闭
 * @return    无返回
 */
- (void)setIsNSlogData:(BOOL)paramIsNSlogData;

/**
 * @brief     设置该游戏的AppKey和AppId。从开发者中心游戏列表获取
 * @param     INPUT paramAppId     游戏Id
 * @param     INPUT paramAppKey    游戏Key
 * @return    无返回
 */
- (void)setAppId:(int)paramAppId AppKey:(NSString *)paramAppKey;





/**
 * @brief     设置注销用户后是否弹出的登录页面
 * @param     INPUT paramIsLogOutPushLoginView    YES为自动弹出登 页面，NO为不弹出登录页面
 * @return    无返回
 */
- (void)setIsLogOutPushLoginView:(BOOL)paramIsLogOutPushLoginView;


/**
 * @brief     设置游戏客户端与游戏服务端链接方式【如果游戏服务端能主动与游戏客户端交互。例如发放道具则为长连接。此处设置影响充值并兑换的方式】
 * @param     INPUT paramIsLongComet    YES 游戏通信方式为长链接，NO 游戏通信方式为长链接
 * @return    无返回
 */
- (void)setIsLongComet:(BOOL)paramIsLongComet;


/**
 * @brief     获取帐号的安全级别[登录验证成功时必须调用]
 * @return    无返回
 */
- (void)getUserInfoSecurity;

/// <summary>
/// 获取该游戏的AppId
/// </summary>
/// <returns>整型AppId</returns>
- (int)appId;

/// <summary>
/// 获取该游戏的AppKey
/// </summary>
/// <returns>字符串AppKey</returns>
- (NSString *)appKey;






/// <summary>
/// 获取关闭充值提示语
/// </summary>
/// <returns>字符串提示语</returns>
-(NSString *)closeRechargeAlertMessage;

/// <summary>
/// 获取当前用户显示currentShowUserName
/// </summary>
/// <returns>返回currentShowUserName</returns>
-(NSString *)currentShowUserName;


/// <summary>
/// 设置当前UI显示用户名
/// </summary>
/// <param name="CurrentUserName">用户名</param>
/// <returns>无返回</returns>
-(void)setCurrentShowUserName:(NSString *)paramCurrentShowUserName;



- (NSString *)current20MinToken;


/// <summary>
/// 设置当前UI显示用户名
/// </summary>
/// <param name="CurrentUserName">用户名</param>
/// <returns>无返回</returns>
-(void)setCurrent20MinToken:(NSString *)paramCurrent20MinToken;




/// <summary>
/// 获取是否允许充值
/// </summary>
/// <returns>bool值</returns>
-(BOOL)isOpenRecharge;


/// <summary>
/// 设置是否为一键登录 【默认为NO】
/// </summary>
/// <returns>无返回</returns>
-(void)setIsOneKeyLogin:(BOOL)paramIsOneKeyLogin;

/// <summary>
/// 获取是否一键登录
/// </summary>
/// <returns>bool值</returns>
-(BOOL)isOneKeyLogin;


/// <summary>
/// 设置是否需要绑定正式帐号
/// </summary>
/// <returns>无返回</returns>
-(void)setIsNeedBind:(BOOL)paramIsNeedBind;

/// <summary>
/// 获取是否需要绑定正式帐号 【需要则为临时帐号，不需要则已经为正式帐号】
/// </summary>
/// <returns>bool值</returns>
-(BOOL)isNeedBind;

    

/// <summary>
/// 设置是否为自动登录【默认为NO】
/// </summary>
/// <returns>无返回</returns>
-(void)setIsAutoLogin:(BOOL)paramIsAutoLogin;

/// <summary>
/// 获取是否为自动登录
/// </summary>
/// <returns>bool值</returns>
-(BOOL)isAutoLogin;



/// <summary>
/// 设置请求的主地址
/// </summary>
/// <returns>返回地址</returns>
-(void)setCurrentAddress:(NSString *)paramCurrentAddress;

/// <summary>
/// 获取当前请求的主地址
/// </summary>
/// <returns>返回地址</returns>
- (NSString *)currentAddress;



/// <summary>
/// 获取充值页面默认金额
/// </summary>
/// <returns>返回rechargeAmount</returns>
-(int)getRechargeAmout;



/// <summary>
/// 设置当前用户名
/// </summary>
/// <param name="CurrentUserName">用户名</param>
/// <returns>无返回</returns>
-(void)setCurrentUserName:(NSString *)paramCurrentUserName;



/// <summary>
/// 设置当前用户的CurrentUserId
/// </summary>
/// <param name="CurrentUserId">用户Id</param>
/// <returns>无返回</returns>
-(void)setCurrentUserId:(uint64_t)paramCurrentUserId;
-(void)setIsJailBreak:(BOOL)paramIsJailBreak;
-(BOOL)isJailBreak;



/// <summary>
/// 获取SDK是否允许打印日志到控制台
/// </summary>
/// <returns>返回BOOL</returns>
-(BOOL)isNSlogData;
/// <summary>
/// 获取SDK用户注销后是否自动push出登陆
/// </summary>
/// <returns>返回BOOL</returns>
- (BOOL)isLogOutPushLoginView;



/// <summary>
/// 判断游戏客户端与游戏服务端链接方式是否为长连接【如果游戏服务端能主动与游戏客户端交互。例如发放道具则为长连接。此处设置影响充值并兑换的方式】
/// </summary>
/// <returns>返回BOOL</returns>
-(BOOL)isLongComet;
- (int)newEmailId;
- (void)setNewEmailId:(int)paramEmailId;
- (int)newEmailSendDate;
- (void)setNewEmailSendDate:(NSTimeInterval)paramNewEmailSendDate;


/**
 *  获取零时账号，零时密码
 */
-(char *)getTempLoginUserName;
-(char *)getTempLoginPassWord;

@end

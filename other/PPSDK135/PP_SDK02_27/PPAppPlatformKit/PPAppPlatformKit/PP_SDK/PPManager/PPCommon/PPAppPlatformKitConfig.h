//
//  PPAppPlatformKitConfig.h
//  PPAppPlatformKit
//
//  Created by 张熙文 on 1/11/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NUMBERS @"\"々ˇ"
//void sha256_memory(const unsigned char *in,
//                   unsigned long len,
//                   unsigned char *dst);






typedef struct MsgGameServerResponse
{
    uint32_t len;
    uint32_t command;
    uint32_t status;                //0为成功，其他为失败
}MSG_GAME_SERVER_RESPONSE;


typedef struct MsgGameServer{
    uint32_t		len;                //21
    uint32_t		commmand;           //[0xAA000021]
    char            token_key[16];
}MSG_GAME_SERVER;

typedef struct MsgGameServer_Str{
    uint32_t		len_str;                //41
    uint32_t		commmand_str;           //[0xAA000022]
    char            token_key_str[33];
}MSG_GAME_SERVER_STR;

//这个打死再也不能改了。。永远都不要改
#define PPFORSERVICENAME1                              @"forServiceName"
#define PPFORSERVICENAME                              @"COM.TEIRON.SDK"
#define PUBLICKEY    @"518a4d67db019244e621b4611f7d0693e8ba0d1ec5f229eb15e9967ccff8c314"
enum {

    PP_Status_BindUserNameRuleError = 0xE0000000,            //用户名不符合规则
    PP_Status_BindUserNameNotExistError = 0xE0000001,        //临时用户名不存在
    PP_Status_BindUPassCheckError = 0xE000001E,               //密码校验错误
    PP_Status_BindUserNameIsBindError = 0xE0000B0D,          //该临时账号已经绑定过正式账号，无法再绑定
    PP_Status_BindUserNameExistError = 0xE000000E ,          //该正式账号已经存在
    PP_Status_BindDBError = 0xE00000DB                      //数据库错误
};


enum {
    PP_Status_RegisterErrorUserRule = 0x00000002,               //用户名不符合规则
    PP_Status_RegisterErrorPassRule = 0x00000003,               //密码格式不符合要求
    PP_Status_RegisterErrorExist = 0x00000005,                  //该用户名已经被注册
    PP_Status_RegisterErrorDatebase = 0x0000006                 //数据库错误
};

enum {
    PP_Status_ChuserErrorAppKey = 0x00000001,                   //appKey不合法
    PP_Status_ChUserErrorPassFormat = 0x00000004,               //密码格式不符合要求
    PP_Status_ChUserErrorUserNotExist = 0x00000005,             //用户名不存在
    PP_Status_ChUserErrorOldPassword  = 0x00000006,             //原密码错误
    PP_Status_ChUserErrorDatabase  = 0x00000007,                //数据库错误
    PP_Status_ChUserErrorOldPassEqualNewPass  = 0x00000008      //旧密码与新密码一致
};

#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

#define PP_APPFILEROOTPATH  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//存放最后一次登陆和登陆列表记录路径
#define PP_RECORDUSERINFO_PATH      NSTemporaryDirectory()
//充值兑换补发订单获取存放路径
#define PP_BILLNOLISTNOTIFICATIONFILEPATH  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"PPBillNoListNotification.plist"]

#define PP_UPDATEGAMEFLAG_FILE          [PP_APPFILEROOTPATH stringByAppendingPathComponent:@"PPUpdateGameFlag.plist"]

//登陆列表记录文件
#define PP_RECORDUSERINFO_FILENAME                                                      @"PPRecordUserInfo.plist"
//最后一次登陆用户记录文件
#define PP_LASTLOGINUSERINFO_FILENAME                                                   @"PPLastLoginUserInfo.plist"

#define PP_NOTI_REGISTER_REQUEST                    0xAA00C101

#define PP_NOTI_REGISTER_RESPONSE                   0xAA00F101

#define PP_NOTI_PS_LOGIN_REQUEST                    0xAA000001
//一键登录请求命令
#define PP_NOTI_PS_ONEKEYLOGIN_REQUEST              0xAA000002
#define PP_NOTI_PS_LOGIN_UPDATE_RESPONSE            0xAA00F005

#define PP_NOTI_PS_VERIFI2_REQUEST                  0xAA000012
#define PP_NOTI_PS_VERIFI2_RESPONSE                 0xAA00F012
//一键登录验证密码命令
#define PP_NOTI_PS_ONEKEYVERIFI2_REQUEST			0xAA000014


#define PP_NOTI_CHUSER_REQUEST                      0xAA00C201
#define PP_NOTI_CHUSER_RESPONSE                     0xAA00F201
#define PP_NOTI_RESET_PASSWORD_REQUEST              0xAA000202


#define ISIPHONE    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISIPAD      [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad


//临时用户请求绑定到正式用户。暂时无用
//#define PP_NOTI_PS_TEMPUSERBINDFORMAL_REQUEST               0xAA000601
//临时用户响应绑定到正式用户。暂时无用
//#define PP_NOTI_PS_TEMPUSERBINDFORMAL_RESPONSE          0xAA00F601

#define PP_MBPROGRESSHUDTEXT                                                            @"玩命加载中..."
#define PP_ADDRESS                                                                      [[PPAppPlatformKit sharedInstance] currentAddress]
#define PP_NEWADDRESS                                                                   @"http://openapi.25pp.com/sdk"
#define PP_ALERTTITLE                                                                      @"温馨提示"
//#define PP_ADDRESS                                                                      @"https://pay.25pp.com"
#define PRIVATEUPPAYKEY                                                                  @"&*JDidlsLD&673TEIR32342KJSD73((2312#>(#@UIjljdsf"
#define MD5_KEY                                                                         @"dieiu69SDEWW24FDSDWE2545drer!`?dfpoqzxvc987CVBWDFCIHOB69!?$[}"
#pragma mark ------------------------ 常用请求接口参数 -----------------------------

#define PP_REQUEST_LOGIN_ADDRESS                                                        @"http://passport_i.25pp.com:8080/i"
#define PP_REQUEST_APPID                                                                [[PPAppPlatformKit sharedInstance] appId]
#define PP_REQUEST_APPKEY                                                               [[PPAppPlatformKit sharedInstance] appKey]
#define PP_REQUEST_VERSION                                                              @"1.3.5"
#define PP_REQUEST_USERID                                                               [[PPAppPlatformKit sharedInstance] currentUserId]
#define PP_REQUEST_USERNAME                                                             [[PPAppPlatformKit sharedInstance] currentUserName]



#define PP_ISNSLOG                                                                      [[PPAppPlatformKit sharedInstance] isNSlogData]
#define PPDEALLOC_ISNSLOG                                                       YES


#define UI_SCREEN_WIDTH                                                                 [[UIScreen mainScreen] bounds].size.width
#define UI_SCREEN_HEIGHT                                                                [[UIScreen mainScreen] bounds].size.height

#define UI_IPHONE_SCREEN_WIDTH                                                          320
#define UI_IPHONE_SCREEN_HEIGHT                                                         480




#define UI_IPAD_SCREEN_X                                                                (UI_SCREEN_WIDTH - UI_IPHONE_SCREEN_WIDTH) / 2
#define UI_IPAD_SCREEN_Y                                                                (UI_SCREEN_HEIGHT - UI_IPHONE_SCREEN_HEIGHT) / 2






#pragma mark ------------------------ PHP接口地址部分定义 -----------------------------

//注册统计
#define PP_PHP_REQUEST_APPONLINEREG_SDKADDRESS                                           @"/index.php?act=apponline.reg"
//在线心跳统计
#define PP_PHP_REQUEST_APPONLINEHRATE_SDKADDRESS                                         @"/index.php?act=apponline.hrate"
//用户转正为有效用户
#define PP_PHP_REQUEST_APPONLINEVORA_SDKADDRESS                                          @"/index.php?act=apponline.vora"




//第一次安装获取帐号信息列表
#define PP_PHP_REQUEST_GETUSERNAMELIST_SDKADDRESS                                        @"/?act=user.getUser_list_sdk"
//注册用户
//#define PP_PHP_REQUEST_REGISTERUSERINFO_SDKADDRESS                                       @"/?act=user.regist_sdk"
//修改密码
#define PP_PHP_REQUEST_UPDATEUSERINFO_SDKADDRESS                                         @"/?act=user.resetUser_pw_sdk"
//临时用户绑定正式用户
#define PP_PHP_REQUEST_TEMPUSERBINDFORMAL_SDKADDRESS                                       @"?act=user.tempUserBindInformal"

#define PP_PHPREQUEST_LOGINFROMSDK_SDKADDRESS                                             @"?act=user.loginFromSdk"

/*帐号完全中心*/
//获取帐号安全级别
#define PP_PHP_REQUEST_ACCOUNTSECURITYLEVEL_SDKADDRESS                                   @"/?act=user.getuser_questions_sdk"
//帮助页面请求地址
#define PP_PHP_REQUEST_HELP_SDKADDRESS                                                   @"?act=api.getHelp"
//绑定密保状态接口
#define PP_PHP_REQUEST_USERINFOSECUITY_SDKADDRESS                                         @"/safety"

//通过邮箱找回帐号的请求地址
#define PP_PHP_REQUEST_FINDUSERNAMEBYEMAIL_SDKADDRESS                         @"/findUserNameByEmail"
//通过手机找回帐号的请求地址
#define PP_PHP_REQUEST_FINDUSERNAMEBYPHONE_SDKADDRESS                         @"/findUserNameByPhone"


//通过邮箱找回密码的请求地址
#define PP_PHP_REQUEST_FINDPWDBYEMAIL_SDKADDRESS                         @"/findPwdByEmail"


//通过密保问题重置密码web页面
#define PP_PHP_REQUEST_FINDPWDBYQUESTIONPAGE                                    @"/findPwdByQuestionPage"
//通过密保电话重置密码web页面
#define PP_PHP_REQUEST_FINDPWDBYPHONEPAGE                                    @"/findPwdByPhonePage"


//手机绑定验证码获取接口
#define PP_PHP_REQUEST_GETPHONECODE_SDKADDRESS                                    @"/getPhoneCode"
//绑定手机接口
#define PP_PHP_REQUEST_GETBANDPHONE_SDKADDRESS                                    @"/bandPhone"
//修改手机验证
#define PP_PHP_REQUEST_GETCHEUSERPHONE_SDKADDRESS                                    @"/chkUserPhone"


//获取邮箱验证码
#define PP_PHP_REQUEST_GETEMAILCODE_SDKADDRESS                                    @"/getEmailCode"

//绑定邮箱
#define PP_PHP_REQUEST_GETBANDEMAIL_SDKADDRESS                                    @"/sendBandEmail"

//获取邮件验证码接口
#define PP_PHP_REQUEST_GETCHECKUSEREMAILCODE_SDKADDRESS                                    @"/chkUserEmailCode"


//获取密保问题列表
#define PP_PHP_REQUEST_GETQUESTIONLIST_SDKADDRESS                                       @"/getQuestionList"
//绑定密保问题
#define PP_PHP_REQUEST_GETBINDQUESTION_SDKADDRESS                                       @"/bandQuestion"


//验证密保问题
#define PP_PHP_REQUEST_GETCHEUSERQUESTION_SDKADDRESS                                       @"/chkUserQuestion"


//充值记录ByData数据接口
#define PP_PHP_REQUEST_RECHARGERECIRDBYTIME_SDKADDRESS                                    @"?act=api.getPayOrderByTime"
//充值记录ByOrderId数据接口
#define PP_PHP_REQUEST_RECHARGERECIRDBYORDERID_SDKADDRESS                                    @"?act=api.getPayOrderByOrderid"
//消费记录查询数据接口ByData
#define PP_PHP_REQUEST_CONSUMPTIONRECORDBYTIME_SDKADDRESS                                    @"?act=api.getExchangeOrderByTime"
//消费记录查询数据接口ByOrderId
#define PP_PHP_REQUEST_CONSUMPTIONRECORDBYORDERID_SDKADDRESS                                    @"?act=api.getExchangeOrderByOrderid"


//忘记密码页面请求地址
#define PP_PHP_REQUEST_FORGETPASSWORD_SDKADDRESS                                         @"/?act=user.forget_pw"
//密保管理页面请求地址
#define PP_PHP_REQUEST_SECURITY_SDKADDRESS                                               @"/?act=user.loginprot"


#define PP_PHP_REQUEST_BBS_SDKADDRESS                                               @"http://bbs.996.com/"


/*充值兑换支付部分*/
//银联支付请求地址
//#define PP_PHP_REQUEST_UNIONPAY_SDKADDRESS                                               @"/?act=pay.getUppayOrderInfo_sdk"

#define PP_PHP_REQUEST_UNIONPAYCREATETIME_SDKADDRESS                                      @"?act=uppay.create_time"
#define PP_PHP_REQUEST_UNIONPAY_SDKADDRESS                                                @"?act=uppay.purchase"

#define PP_PHP_REQUEST_ALIXPAYCREATETIME_SDKADDRESS                                      @"/?act=alisecurity.create_time"
#define PP_PHP_REQUEST_ALIXPAY_SDKADDRESS                                                @"/?act=alisecurity.purchase"

//查询充值记录请求地址
#define PP_PHP_REQUEST_PPRECHARGE_SDKADDRESS                                             @"/?act=pay.record_query"
//查询兑换记录请求地址
#define PP_PHP_REQUEST_PPEXPEND_SDKADDRESS                                               @"/?act=pay.record_pay"
//充值支付并且直接兑换道具请求地址
#define PP_PHP_REQUEST_PAYANDEXCHANGE_SDKADDRESS                                         @"/?act=paybuy.forms"
//充值页面请求地址
#define PP_PHP_REQUEST_PAY_SDKADDRESS                                                    @"/?act=pay.forms"
//订单查询接口请求地址
#define PP_PHP_REQUEST_GETBILLNOLIST_SDKADDRESS                                          @"/?act=client.notify"
//直接兑换道具
#define PP_PHP_REQUEST_EXCHANGE_SDKADDRESS                                               @"/?act=pay.Exchange_PPMtoGame_sdk"
//查询余额
#define PP_PHP_REQUEST_BALANCE_SDKADDRESS                                                @"/?act=pay.getPPMoney_sdk"
//获取订单列表
#define PP_PHP_REQUEST_BILLNOLIST_SDKADDRESS                                             @"/?act=client.notify"



#pragma mark ------------------------ PHP响应接口返回得SDKNAME ------------------------------



//第一次安装获取所有用户名
#define PP_PHP_RESPONSE_GETUSERNAMELIST_SDKNAME                                          @"getUser_list_sdk"
//注册用户
#define PP_PHP_RESPONSE_REGISTERUSERINFO_SDKNAME                                         @"regist_sdk"
//修改密码   
//#define PP_PHP_RESPONSE_UPDATEUSERINFO_SDKNAME                                           @"resetUser_pw_sdk"

//兑换
#define PP_PHP_RESPONSE_EXCHANGE_SDKNAME                                                 @"Exchange_PPMtoGame_sdk"
//查询余额
#define PP_PHP_RESPONSE_BALANCE_SDKNAME                                                  @"getPPMoney_sdk"
//查询订单列表补发
#define PP_PHP_RESPONSE_BILLNOLIST_SDKNAME                                               @"client_billno_notify_sdk"

//临时会员绑定正式会员
#define PP_PHP_RESPONSE_TEMPUSERBINDINFORMAL_SDKNAME                                     @"tempUserBindInformal"

//银联支付从PHP获取时间
#define PP_PHP_RESPONSE_GET_SERVER_TIME_SDKNAME                                           @"get_server_time"
//#define PP_PHP_RESPONSE_UP_PURCHASE_ORDER_SDKNAME                                             @"up_purchase_order"
#define PP_PHP_RESPONSE_GET_GAMEVERSIONUPDATE_SDKNAME                                           @"getVersionUpdate"

#pragma mark ------------------------ PHP响应接口返回通知 ------------------------------


//第一次安装获取所有用户通知
#define PP_PHP_RESPONSE_GETUSERNAMELIST_NOTIFICATION                                     @"PP_PHP_RESPONSE_GETUSERNAMELIST_NOTIFICATION"
//注册用户返回通知
//#define PP_PHP_RESPONSE_REGISTERUSERINFO_NOTIFICATION                                    @"PP_PHP_RESPONSE_REGISTERUSERINFO_NOTIFICATION"
//修改密码返回通知
//#define PP_PHP_RESPONSE_UPDATEUSERINFO_NOTIFICATION                                      @"PP_PHP_RESPONSE_UPDATEUSERINFO_NOTIFICATION"

//查询余额返回通知
#define PP_PHP_RESPONSE_BALANCE_NOTIFICATION                                             @"PP_PHP_RESPONSE_BALANCE_NOTIFICATION"
//检查密码验证返回通知
//#define PP_PHP_RESPONSE_CHECKPASSWORD_NOTIFICATION                                       @"PP_PHP_RESPONSE_CHECKPASSWORD_NOTIFICATION"
//检查密码成功返回通知
//#define PP_PHP_RESPONSE_CHECKSUCCEESS_NOTIFICATION                                       @"PP_PHP_RESPONSE_CHECKSUCCEESS_NOTIFICATION"
//账号安全级别返回通知
//#define PP_PHP_RESPONSE_ACCOUNTSECURITYLEVEL_NOTIFICATION                                @"PP_PHP_RESPONSE_ACCOUNTSECURITYLEVEL_NOTIFICATION"
//一键登录请求检查用户返回通知
//#define PP_PHP_RESPONSE_ONEKEYLOGINCHECKUSEREXISTS_NOTIFICATION                                @"PP_PHP_RESPONSE_NEKEYLOGINCHECKUSEREXISTS_NOTIFICATION"
//一键登录注册请求返回通知
//#define PP_PHP_RESPONSE_ONEKEYLOGINTOREG_NOTIFICATION                                @"PP_PHP_RESPONSE_ONEKEYLOGINTOREG_NOTIFICATION"
//临时会员绑定正式会员
//#define PP_PHP_RESPONSE_TEMPBINDFORMAL_NOTIFICATION                                @"PP_PHP_RESPONSE_TEMPBINDFORMAL_NOTIFICATION"

/**
 *响应错误部分
 */
#define PP_PHP_RESPONSE_CONNECTIONERROR_NOTIFICATION                                     @"PP_PHP_RESPONSE_CONNECTIONERROR_NOTIFICATION"

#define PP_PHP_RESPONSE_GAMEUPDATE_NOTIFICATION                                     @"PP_PHP_RESPONSE_GAMEUPDATE_NOTIFICATION"


#pragma mark ------------------------ SDK发送给游戏客户端通知 ------------------------------





/**
 * @brief PPWeb页面关闭回调参数
 */
typedef enum{
    /**
     * 返回充值页面
     */
	PPWebViewCodeRecharge = 1,
    /**
     * 返回充值并且兑换页面
     */
    PPWebViewCodeRechargeAndExchange = 2,
}PPWebViewCode;


/**
 * @brief 错误范围，用来标识错误是接口返回的还是SDK返回的。
 */
typedef enum{
    /**
     * 关闭接口为登录页面
     */
	PPLoginViewPageCode	= 1,
    /**
     * 关闭接口为注册
     */
    PPRegisterViewPageCode = 2,
}PPPageCode;


/**
 * @brief 错误范围，用来标识错误是接口返回的还是SDK返回的。
 */
typedef enum{
    /**
     * 购买成功
     */
	PPPayResultCodeSucceed	= 0,
    /**
     * 禁止访问
     */
    PPPayResultCodeForbidden = 1,
    /**
     * 该用户不存在
     */
    PPPayResultCodeUserNotExist = 2,
    /**
     * 必选参数丢失
     */
    PPPayResultCodeParamLost = 3,
    /**
     * PP币余额不足
     */
    PPPayResultCodeNotSufficientFunds = 4,
    /**
     * 该游戏数据不存在
     */
    PPPayResultCodeGameDataNotExist = 5,
    /**
     * 开发者数据不存在
     */
    PPPayResultCodeDeveloperNotExist = 6,
    /**
     * 该区数据不存在
     */
    PPPayResultCodeZoneNotExist = 7,
    /**
     * 系统错误
     */
    PPPayResultCodeSystemError = 8,
    /**
     * 购买失败
     */
    PPPayResultCodeFail = 9,
    /**
     * 与开发商服务器通信失败，如果长时间未收到商品请联系PP客服：电话：020-38276673　 QQ：800055602
     */
    PPPayResultCodeCommunicationFail = 10,
    /**
     * 开发商服务器未成功处理该订单，如果长时间未收到商品请联系PP客服：电话：020-38276673　 QQ：800055602
     */
    PPPayResultCodeUntreatedBillNo = 11,
    
    /**
     * 用户中途取消
     */
    PPPayResultCodeCancel = 12,
    
    /**
     * 非法访问，可能用户已经下线
     */
    PPPayResultCodeUserOffLine = 88,
}PPPayResultCode;


//
//  DGCDefine.h
//  AFNetworkTest
//
//  Created by 冯鸿辉 on 15/10/23.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#ifndef DGCDefine_h
#define DGCDefine_h

#pragma mark - Manager 使用的宏
#define DGC_FULLURL_INFO_KEY @"fullurl"
#define HTTP_REQUEST    1
#define JSON_REQUEST    2
#define BINARY_REQUEST  3

#define SORT_DEFAULT    0
#define SORT_TEXT       1

#define LOGIN_USERNAME  1
#define LOGIN_EMAIL     2
#define LOGIN_MOBILE    3
#define LOGIN_NAME      4
#define LOGIN_MD5       (1 << 16)

#pragma mark - 一般字符串
#define firstGetInfo @"firstGetInfo"
#define headerViewPress @"headerViewPress"
#define footerViewPress @"footerViewPress"
#define delegateInfoKey @"delegateInfoKey"
#define NO_DATA_IMG @"noDataImg.png"

#pragma mark - log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define DRLog(fmt,...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#pragma mark - 快捷属性
#define  PROPERTY_NON_ATOMIC_WEAK       @property (nonatomic,weak)
#define  PROPERTY_NON_ATOMIC_ASSIGN     @property (nonatomic,assign)
#define  PROPERTY_NON_ATOMIC_COPY       @property (nonatomic,copy  )
#define  PROPERTY_NON_ATOMIC_STRONG     @property (nonatomic,strong)
#define  PROPERTY_NON_ATOMIC_READONLY   @property (nonatomic,readonly)

#define  PROPERTY_ATOMIC_ASSIGN         @property (atomic,assign  )
#define  PROPERTY_ATOMIC_COPY           @property (atomic,copy  )
#define  PROPERTY_ATOMIC_STRONG         @property (atomic,strong)
#define  PROPERTY_ATOMIC_READONLY       @property (atomic,readonly)

#pragma mark - 编码
//请求报错编码
typedef NS_ENUM(NSInteger, DGCRequestErrorCode) {
  DGCRequestErrorCodeSuccess          = 200,//操作成功
  TRequestErrorCodeBlankUsername    = 400,//账号为空
  TRequestErrorCodeNotExistUserName = 401,//帐号不存在
  TRequestErrorCodeLockUser         = 402,//帐号已锁定
  TRequestErrorCodeNonactivateUser  = 403,//帐号未激活
  TRequestErrorCodePwdIsWrong       = 404,//密码不正确
  TRequestErrorCodeAbnormalRequest  = 405,//请求异常
  TRequestErrorCodeWrongProperty    = -1,//参数不正确或请求时间超过允许范围
  TRequestErrorCodeWrongToken       = -2,//token不正确，可认为是其他设备登录，需要重新登录
  
  TRequestErrorCodeLoginFailer            = 0x00000001,//未登录或登录已失效
  TRequestErrorCodeFormatWrong            = 0x00000002,//输入的数据格式错误
  TRequestErrorCodeInvalidConnent         = 0x00000003,//连接已失效
  TRequestErrorCodeExistBlacklist         = 0x00000004,//在对方黑名单中
  TRequestErrorCodeServerWrong            = 0x00000005,//服务器错误
  TRequestErrorCodeIllegalOperate         = 0x00000006,//非法的操作
  TRequestErrorCodeNotFindUser            = 0x00000007,//未找到该用户
  TRequestErrorCodeNotJurisdiction        = 0x00000008,//没有操作权限
  
  
  TRequestErrorCodePhoneIsRegister        = 0x00010004,//该手机号码已被注册
  TRequestErrorCodePhoneNotRegister       = 0x00010005,//该手机号未注册
  TRequestErrorCodeVerifyCodeOverdue      = 0x00010006,//验证码已过期
  TRequestErrorCodeInvalidVerifyCode      = 0x00010007,//无效验证码
  TRequestErrorCodeNewTokenIsInvalid      = 0x00010009,//刷新令牌已失效
  
  
  TRequestErrorCodeAnalysisFailer         = 0x00011111,//数据解析失败
  TRequestErrorCodeParamWrong             = 0x00011112,//传参错误
  TRequestErrorCodeOther                  = 0x00011113,//其他错误
  TRequestErrorCodeGetTokenFailer         = 0x00011114,//获取token失败
  
  
  TRequestErrorCodeTimeOut                = NSURLErrorTimedOut,//超时
  TRequestErrorCodeNetworkConnectionLost  = NSURLErrorNetworkConnectionLost,//断网
  TRequestErrorCodeNotConnectedToInternet = kCFURLErrorNotConnectedToInternet,//断网
  
  TRequestErrorCodeCannotConnectToHost    = NSURLErrorCannotConnectToHost,//链接不上服务器
  //TODO:其他相关人员后续补上
};

//全局请求编码
typedef NS_ENUM(NSInteger, DGCRequestCode) {
  DGCRequestCodeLogin              = 101,//登录
  DGCRequestCodeLogout              = 102,//退出
  DGCRequestCodeSignup              = 103,//注册
  DGCRequestCodeMyProfile           = 104,//获取我的详情
  DGCRequestCodeMyPosts           = 116,//获取我的帖子
  DGCRequestCodeEditProfile           = 105,//修改我的详情
  DGCRequestCodeEditSetting           = 106,//修改我的个人设置
  DGCRequestCodeGetSetting           = 112,//获取我的个人设置
  DGCRequestCodeMyFriend           = 107,//我的朋友
  DGCRequestCodeMyRequest           = 108,//我的新增请求
  DGCRequestCodeMyBlocked           = 109,//我的黑名单
  DGCRequestCodeMyPublishPosts           = 116,//我的公开帖子
  DGCRequestCodeMyFollows           = 117,//我的已追随
  DGCRequestCodeMyFollowers = 120,//我的关注
  DGCRequestCodeMyBookmarks           = 110,//我的收藏帖子
  DGCRequestCodeMyStatNum          = 111,//提取自己的个人统计信息
  DGCRequestCodeProfileByUser = 114,//获取其他用户详情
  DGCRequestCodeEditMyHeader = 115,//修改个人头像
  DGCRequestCodeEditToSelecetedUser = 118,//对指定用户进行操作
  DGCRequestCodeEditToSelecetedRequest = 119,//对指定请求进行操作
  DGCRequestCodeGetMyFriendsPublishPosts = 121,//所有朋友的公开帖子
  DGCRequestCodeMyLikedposts           = 122,//我的点赞帖子
  
  DGCRequestCodePost = 201,//最新更新帖子列表
  DGCRequestCodeGetPost = 202,//取指定帖子
  DGCRequestcodeCreatPost = 203,//发帖子
  DGCRequestcodeGetPostComments = 204,//指定帖子评论
  DGCRequestcodeCreateComment = 206,//发指定帖子评论
  DGCRequestcodeUploadImg = 205,//上传帖子照片
  DGCRequestcodeEditToSelectedPost = 207,//对指定帖子进行操作
  
  DGCRequestCodeSearch = 301,//搜索
  DGCRequestCodeSearchSelectedContent = 302,//搜索指定内容
  DGCRequestCodeSearchGetSystemTypes = 401,//提取系统数据类型信息
  
  DGCRequestCodePlacesAddNewPlace = 501//提取系统数据类型信息
};

#pragma mark - 对象
#define DGC_KEY_WINDOW [[UIApplication sharedApplication] keyWindow]

#pragma mark - url / key / id

#ifdef FinallyEdition
#define baseURLbyEdition @"http://tpages.cn/portal.php"
#else
#define baseURLbyEdition @"http://dev.123go.net.cn/portal.php"
#endif

#define UMENG_APPKEY @"53ec86c7fd98c5cf630065c6"
#define UMENG_URL @"http://tpages.cn"
#define UMENG_WEIBO_APPKEY @"1234731486"
#define UMENT_WEIBO_SECRET @"8b247cb26df293f6b1270e134839ed0b"
#define UMENG_QQ_APPID @"1105010114"
#define UMENG_QQ_APPKEY @"2s9wL1cScGtIu2dd"
#define UMENG_SHARE_BASEURL @"http://90days.tpages.cn/comments.html#"
#define URL_SCHEME @"UrlSchemeTpagesMall"

#ifdef FinallyEdition
#define UMENG_WECHAT_APPID @"wx907b2964e73e9bb5"
#define UMENG_WECHAT_APPSECRET @"4462d23e308d86eca2bdde345999c9ee"
#else
#define UMENG_WECHAT_APPID @"wxa9cec0d7b7d9d1f1"
#define UMENG_WECHAT_APPSECRET @"b2878be2a0922637868ff90f47351517"
#endif

#pragma mark - 一般方法宏

//单例宏
#define SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)share { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#pragma mark - 坐标系
#define screenBounds [[UIScreen mainScreen] bounds]
#define screenW [DGCTool screenWidth]
#define screenH [DGCTool screenHeight]
#define defaultViewW [DGCTool viewControllerViewWidth]
#define defaultViewH [DGCTool viewControllerViewHeight]

#define viewBounds self.view.bounds
#define viewX self.view.frame.origin.x
#define viewY self.view.frame.origin.y
#define viewW self.view.frame.size.width
#define viewH self.view.frame.size.height

#define naviH [DGCTool navigationBarHeight]
#define stateH [DGCTool stateBarHeight]
#define toolBarH 44
#define tabBarH 49
#define phoneStateH 40 //状态栏20+占用navi20



#pragma mark - 通知
#define Noti_TakeHeaderPhotoSuccess @"Noti_TakeHeaderPhotoSuccess"//发帖成功后刷新首页


#pragma mark - type
typedef NS_ENUM(NSInteger,DGCPageType) {
  DGCPageTypeHome = 1,
  DGCPageTypeFriend = 2,
  DGCPageTypeSearch = 3
};

#pragma mark - 一般数值宏
#define maxCellCount 6
#define PER_PAGE5 5
#define PER_PAGE10 10
#define IMAGE_QUALITY .3
//#define cellImgHeight (screenH-tabBarH-naviH-stateH-48-146) //照片高度 拍照高度
#define cellImgHeight screenW //照片高度 拍照高度
#endif

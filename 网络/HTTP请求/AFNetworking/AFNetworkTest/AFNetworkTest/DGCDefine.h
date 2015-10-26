//
//  DGCDefine.h
//  AFNetworkTest
//
//  Created by 冯鸿辉 on 15/10/23.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#ifndef DGCDefine_h
#define DGCDefine_h

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

#pragma mark 全局请求编码
typedef NS_ENUM(NSInteger, DGCRequestCode) {
    DGCRequestCodeLogin              = 101,//(1.0.1)登录
    TRequestCodeSingleDemandList   = 201,//个性需求列表
    TRequestCodeSingleDemandDetail = 202,//个性需求详情
    TRequestCodeSingleReply        = 203,//个性需求详情商家回复
    TRequestCodeSingleReplyUpload  = 204,//个性需求详情上传图片
    TRequestCodeGroupDemandList     = 205,//团体需求列表
    TRequestCodeGroupDemandDetail     = 206,//团体需求详情
    TRequestCodeGroupReply        = 207,//个性需求详情商家回复
    TRequestCodeGroupReplyUpload  = 208//个性需求详情上传图片
};

#endif

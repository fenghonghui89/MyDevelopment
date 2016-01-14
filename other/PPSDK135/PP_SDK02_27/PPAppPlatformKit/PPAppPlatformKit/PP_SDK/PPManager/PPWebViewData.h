//
//  PPWebViewData.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-9.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPHttpRequest.h"
typedef enum {
    PPOrderStatusFail = 0,                          //失败订单
    PPOrderStatusSucceed = 1,                       //成功订单
    PPOrderStatusCancel = 2,                        //取消订单
    PPOrderStatusAll = 3                            //全部
}PPOrderStatus;

typedef enum {
    PPOrderDataToday = 1,                           //今天
    PPOrderDataTwoMonthsWithin = 2,                 //两个月内
    PPOrderDataLastMonths = 3,                      //上个月
    PPOrderDataLastTwoMonths = 4                    //上两个月
}PPOrderData;

//这个是用来写密保问题的枚举的，待修改
typedef NS_ENUM(NSInteger, Question)
{
    //以下是枚举成员
    QuestionNil = 0,
    QuestionA = 1,
    QuestionB = 2,
    QuestionC = 3,
    QuestionD = 4
};


//忘记密码的各个接口的名字
typedef NS_ENUM(NSInteger, Functions)
{
    //以下是枚举成员
    getPhoneCodeChkUserName = 1,
    //验证用户手机验证码
    findPwdByPhone = 2,
    //重置密码接口(手机)
    resetPwdByPhone = 3,
    //通过邮箱找回密码接口
    findPwdByEmail = 4,
    //验证用户手机验证码
    getUserQuestion = 5,
    //验证用户手机验证码
    chkUserQuestion = 6,
    //重置密码接口(密保)
    resetPwdByQuestion = 7,
    //找回帐号（通过邮箱）
    findUserNameByEmail = 8,
    //找回账号（通过手机）
    findUserNameByPhone = 9
};


@class PPWebViewData;

@protocol PPWebViewDataDelegate <NSObject>
@optional
- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError;
- (void)responseDidFailWithErrorCallBack;
/**
 *  帮助中心的数据
 *
 *  @param paramDic 数据
 */
- (void)helpViewJsonResponseCallBack:(NSDictionary *)paramDic;
- (void)rechargeRecordByTimeJsonResponseCallBack:(NSDictionary *)paramDic;
- (void)rechargeRecordByOrderIdJsonResponseCallBack:(NSDictionary *)paramDic;
- (void)consumptionRecordByTimeJsonResponseCallBack:(NSDictionary *)paramDic;
- (void)consumptionRecordByOrderIdJsonResponseCallBack:(NSDictionary *)paramDic;
- (void)userInfoSecuityCallBack:(NSDictionary *)paramDic;
- (void)verificationCodeCallBack:(NSDictionary *)paramDic;
- (void)bindPhoneCallBack:(NSDictionary *)paramDic;
- (void)checkPhoneCallBack:(NSDictionary *)paramDic;
- (void)verificationEmailCodeCallBack:(NSDictionary *)paramDic;
- (void)bindEmailCallBack:(NSDictionary *)paramDic;
- (void)chkUserEmailCodeCallBack:(NSDictionary *)paramDic;
- (void)questionListCallBack:(NSDictionary *)paramDic;
- (void)bindQuestionCallBack:(NSDictionary *)paramDic;
- (void)checkUserQuestionCallBack:(NSDictionary *)paramDic;
- (void)findUserNameByPhoneCallBack:(NSDictionary *)paramDic;
- (void)findUserNameByEmailCallBack:(NSDictionary *)paramDic;
- (void)findPassWordByUserNameCallBack:(NSDictionary *)paramDic;

- (void)balanceCallBack:(NSDictionary *)paramDic;
@end



/**
 *  所有的PHP请求 的集合
 */
@interface PPWebViewData : NSObject<PPHttpRequestDelegate>
{
    
}
@property (nonatomic, assign) id<PPWebViewDataDelegate> delegate;

- (NSString *)makeSignMD5:(Functions)paramFunctionName
                 Username:(NSString *)paramUsername
                    Phone:(NSString *)paramPhone
               Phone_code:(NSString *)paramPhone_code
                   NewPwd:(NSString *)paramNewPwd
                 nextCode:(NSString *)paramNextCode
                    Email:(NSString *)paramEmail
               Question_1:(Question )paramQuestion_1
               Question_2:(Question )paramQuestion_2
                 Answer_1:(NSString *)paramAnswer_1
                 Answer_2:(NSString *)paramAnswer_2
           NSTimeInterval:(NSString *)paramNSTimeInterval;

/**
 *  获取帮助中心的数据
 */
- (void)getHelpViewJson;

/**
 *  查询 充值记录以 时间，订单号
 */
- (void)getRechargeRecordByTime:(PPOrderStatus)paramOrderStatus
                           Data:(PPOrderData)paramData Page:(int)paramPage;
- (void)getRechargeRecordByOrderId:(NSString *)paramOrderId;


/**
 *  查询 消费记录以 时间，订单号
 */
- (void)getConsumptionRecordByTime:(PPOrderStatus)paramOrderStatus
                              Data:(PPOrderData)paramData Page:(int)paramPage;
- (void)getConsumptionRecordByOrderId:(NSString *)paramOrderId;

/**
 *  用户信息，账号，密码  安全级别
 */
- (void)getUserInfoSecuityToFindPassword:(NSString *)paramUserName;
- (void)getUserInfoSecuity:(NSString *)paramUserName;
/**
 *  检查， 验证，绑定 手机号
 */
- (void)getVerificationCode:(NSString *)paramPhone;
- (void)getChkUserPhone:(NSString *)paramPhone
                   Code:(NSString *)paramCode;
- (void)getBindPhone:(NSString *)paramPhone
                Code:(NSString *)paramCode
            Nextcode:(NSString *)paramNextcode;
/**
 *  检查，验证，绑定 邮箱
 */
- (void)getEmailCode:(NSString *)paramEmail;
- (void)getChkUserEmail:(NSString *)paramEmail Email_Code:(NSString *)paramEmail_Code;
- (void)getBindEmail:(NSString *)paramEmail Nextcode:(NSString *)paramNextcode;

/**
 *  密保问题列表，验证问题，绑定问题
 */
- (void)getChkUserQuestion:(NSDictionary *)paramQuestionDictionary;
- (void)getQuestionList;
- (void)getBindQuestion:(int)paramQuestion_1
             Question_2:(int)paramQuestion_2
               Answer_1:(NSString *)paramAnswer_1
               Answer_2:(NSString *)paramAnswer_2
               NextCode:(NSString *)nextcode;



/**
 *  找回账号，密码，以手机号，邮箱
 */
- (void)getFindPassWordByUserName:(NSString *)paramUserName
                             Sign:(NSString*)paramSign
                             Time:(NSString *)paramTime;
- (void)getFindUserNameByEmail:(NSString *)paramEmail
                          Sign:(NSString*)paramSign
                          Time:(NSString *)paramTime;
- (void)getFindUserNameByPhone:(NSString*)paramPhone
                          Sign:(NSString*)paramSign;

/**
 *  查询余额
 */
- (void)ppPPMoneyRequest;

@end

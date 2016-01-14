//
//  PPWebView.h
//  PPUserUIKit
//
//  Created by seven  mr on 1/24/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "PPBaseView.h"
/**
 * @brief PPWeb页面充值密码参数
 */
typedef enum{
	ResetPassByQuestionPage = 1,
    ResetPassByPhonePage = 2
    
}ResetPass;



@interface PPWebView : PPBaseView
<
UIWebViewDelegate
>
{
    UIWebView *pageWebView;
    PPMBProgressHUD *mbProgressHUD;
    UIImageView *_toolBottomView;
    UIButton *_retreatButton;
    UIButton *_advanceButton;
    UIButton *_refreshButton;
    UIActivityIndicatorView *_indicator;
    int flag;
    NSString *rechargeAndExchangeBillNo;

}
/**
 *  请求充值WEB页面
 *
 *  @param paramAmount 请求充值的金额
 */
-(void)rechargeWebShow:(NSString *)paramAmount;
/**
 *  请求充值并兑换WEB页面
 *
 *  @param paramBillNo      请求的订单号
 *  @param paramBillNoTitle 请求的订单标题
 *  @param paramPayMoney    请求订单的金额
 *  @param paramRoleId      请求订单购买的角色ID
 *  @param paramZoneId      请求订单购买的服务器ID
 */
-(void)rechargeAndExchangeWebShow:(NSString *)paramBillNo
                      BillNoTitle:(NSString *)paramBillNoTitle
                         PayMoney:(NSString *)paramPayMoney
                           RoleId:(NSString *)paramRoleId
                           ZoneId:(int)paramZoneId;

/**
 *  通过密保电话重置密码web页面 /通过密保问题重置密码web页面
 *
 *  @param paramResetPass 类型
 *  @param paramUserName  用户名
 */

-(void)resetPass:(ResetPass)paramResetPass
        UserName:(NSString *)paramUserName;


/**
 *  打开网页 (过期)
 *
 *  @param paramAddress 网址
 */

- (void)goToAddress:(NSString *)paramAddress;
/**
 *  请求论坛WEB页面 (过期)
 */
//-(void)goBBS;
@end

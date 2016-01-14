//
//  PPBoundToNextPhoneView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-23.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPBaseView.h"
#import "PPWebViewData.h"
#import "PPMBProgressHUD.h"

/**
 *  绑定手机号
 */
@interface PPBoundToNextPhoneView : PPBaseView
<
PPWebViewDataDelegate
>
{
    UIImageView *boundToPhoneImageView;
    UILabel *boundToPhoneLabel;
    UITextField *phoneNumberTextfield;
    UIButton *getVerificationCodeButton;
    UIImageView *verificationCodeImageView;
    UILabel *verificationCodeLabel;
    UITextField *verificationCodeTextfield;
    UIButton *boundToPhoneButton;
    
    PPMBProgressHUD *ppMBProgressHUD;
}

@property (nonatomic, retain) NSString *nextCode;



/// <summary>
/// 绑定手机页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showBoundToNextPhoneViewByRight;


///// <summary>
///// 绑定手机页面从左边展示
///// </summary>
///// <returns>无返回</returns>
//-(void)showBoundToPhoneViewByLeft;

@end

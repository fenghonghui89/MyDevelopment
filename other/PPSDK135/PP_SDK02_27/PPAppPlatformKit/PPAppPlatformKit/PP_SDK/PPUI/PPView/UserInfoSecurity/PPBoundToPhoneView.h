//
//  PPBoundToPhoneView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-11.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPBaseView.h"
#import "PPWebViewData.h"
#import "PPMBProgressHUD.h"
#import "PPPasswordProtectionView.h"

/**
 *  绑定，检查，验证，手机号
 */
@interface PPBoundToPhoneView : PPBaseView //PPBaseView <UIGestureRecognizerDelegate,UITextFieldDelegate>
<
PPWebViewDataDelegate
>
{
    UIImageView *boundToPhoneImageView;
    UILabel *boundToPhoneLabel;

    UIButton *getVerificationCodeButton;
    UIImageView *verificationCodeImageView;
    UILabel *verificationCodeLabel;
    UITextField *verificationCodeTextfield;
    UIButton *boundToPhoneButton;
    
    PPMBProgressHUD *ppMBProgressHUD;
}

@property (nonatomic, assign) BOOL isUpdate;
@property (nonatomic, retain) NSString *oldPhone;
@property (nonatomic, retain) UITextField *phoneNumberTextfield;

@property (nonatomic, assign) PPVerificationMode nextView;



/// <summary>
/// 绑定手机页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showBoundToPhoneViewByRight;


///// <summary>
///// 绑定手机页面从左边展示
///// </summary>
///// <returns>无返回</returns>
//-(void)showBoundToPhoneViewByLeft;

@end

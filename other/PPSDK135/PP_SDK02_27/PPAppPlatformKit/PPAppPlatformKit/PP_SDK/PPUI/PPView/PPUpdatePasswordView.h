//
//  PPUpdatePassWordView.H
//  PPUserUIKit
//
//  Created by seven  mr on 1/24/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMBProgressHUD.h"
#import "PPBaseView.h"

/**
 *  修改密码页面
 */
@interface PPUpdatePasswordView : PPBaseView //PPBaseView <UIGestureRecognizerDelegate,UITextFieldDelegate>
<
TRUserRequestDelegate,
TRKeyValueRequestDelegate,
UIAlertViewDelegate
>
{
    UIButton *confirmButton;
    
    UIImageView *userNameImageView;
    UIImageView *oldPassWordImageView;
    UIImageView *passWordImageView;
    UIImageView *affirmPassWordImageView;
    
    UILabel *userNameLabel;
    UILabel *oldPassWordLabel;
    UILabel *passWordLabel;
    UILabel *affirmPassWordLabel;
    
    UITextField *userNameField;
    UITextField *oldPassWordField;
    UITextField *passWordField;
    UITextField *affirmPassWordField;
    
    PPMBProgressHUD *mbProgressHUD;
}


//从右边展示
-(void)showUpdatePassWordViewByRight;
@end

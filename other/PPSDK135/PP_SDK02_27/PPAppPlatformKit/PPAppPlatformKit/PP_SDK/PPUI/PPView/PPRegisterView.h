//
//  PPRegisterView.h
//  PPUserUIKit
//
//  Created by seven  mr on 1/23/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMBProgressHUD.h"
#import "PPBaseView.h"

/**
 *  注册页面
 */
@interface PPRegisterView : PPBaseView //PPBaseView <UIGestureRecognizerDelegate,UITextFieldDelegate>
<
TRUserRequestDelegate,
TRKeyValueRequestDelegate
>
{

    UIButton *registerButton;
    
    UIImageView *userNameImageView;
    UIImageView *passWordImageView;
    UIImageView *affirmPassWordImageView;
    
    UILabel *userNameLabel;
    UILabel *passWordLabel;
    UILabel *affirmPassWordLabel;
    
    UITextField *userNameField;
    UITextField *passWordField;
    UITextField *affirmPassWordField;
    
    PPMBProgressHUD *mbProgressHUD;
    
    NSMutableArray *_userInfoList;
    NSMutableArray *_oldUserInfoList;
    
    
}


-(void)hiddenRegisterViewInRight;
-(void)showRegisterViewByRight;
-(void)hiddenRegisterViewInLeft;
-(void)showRegisterViewByLeft;
@end

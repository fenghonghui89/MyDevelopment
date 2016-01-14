//
//  PPLoginView.h
//  PPUserUIKit
//
//  Created by seven  mr on 1/21/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPHyperlinkLabel.h"
#import "PPBaseView.h"


/**
 *  登录中心 视图
 */
@interface PPLoginView : PPBaseView //PPBaseView <UIGestureRecognizerDelegate,UITextFieldDelegate>
<
UITableViewDataSource,
UITableViewDelegate,
PPHyperlinkLabelDelegate,
TRKeyValueRequestDelegate,
TRUserRequestDelegate
>
{
    BOOL _isLoadedDeviceLoginRecords;

    UIButton *loginButton;
    UIButton *oneKeyLoginButton;
    
    
    UIImageView *userNameImageView;
    UIImageView *passWordImageView;
    
    UILabel *userNameLabel;
    UILabel *passWordLabel;
    
    UITextField *userNameField;
    UITextField *passWordField;
    
    
    UIButton *recordUserNameButton;
    
    PPHyperlinkLabel *keepPassWordLabel;
    UIButton *keepPassWordButton;
    PPHyperlinkLabel *keepAutoLoginLabel;
    UIButton *keepAutoLoginButton;
    
    
    UIButton *forgetPassWordButton;
    UIButton *registerButton;
    
    BOOL isKeepPassWord;
    BOOL isKeepAutoLogin;
    
    
    UITableView *userNameTableView;
    
    PPMBProgressHUD *mbProgressHUD;
    int loginingTime;
    
    BOOL userNameTableViewIsShow;

    char tempStrUser[16];
    char tempStrPass[16];
    char isTmpUser[4];
    
    
    NSMutableArray *_userInfoList;
    NSMutableArray *_oldUserInfoList;
    
//    NSData *_lastLoginPassword_;
    
    BOOL _isUseOldGetUserList;
}

/**
 *  登陆从右边展示
 */
-(void)showLoginViewByRight;

/**
 *  登陆从左边展示
 */
-(void)showLoginViewByLeft;




@end

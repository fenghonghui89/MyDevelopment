//
//  PPLoginView.m
//  PPUserUIKit
//
//  Created by seven  mr on 1/21/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPLoginView.h"
#import <QuartzCore/QuartzCore.h>
#import "PPUserNameCell.h"
#import "PPUserInfo.h"
#import "PPUIKit.h"
#import "KeychainUtils.h"
#import "PPRegisterView.h"
#import "PPWebView.h"
#import "PPAppPlatformKitConfig.h"
#import "UIImageView+ForScrollView.h"
#import "PPCommon.h"
#import "PPAlertSecurityView.h"
#import "PPTextField.h"
#import "PPLoginView.h"
#import "PPTempUserRegClauseAlertView.h"
#import "PPAlertView.h"
#import <TeironSDK/util/TRUtil.h>
#import "PPTempUserRegClauseAlertView.h"
#import "PPForgetWhatView.h"





#define noDisableVerticalScrollTag 836913
#define noDisableHorizontalScrollTag 836914




@implementation PPLoginView

-(id)init{
    self = [super init];
    if (self) {
        [_bgImageView setClipsToBounds:YES];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleLogin"]];
        [_titleLabel setText:@"用户登录"];
        [self.verticalLineLeftView setHidden:YES];
        [_verticalLineRightView setHidden:NO];
        [_bgImageView setClipsToBounds:YES];
        
        _isUseOldGetUserList = NO;
        isKeepPassWord = NO;
        isKeepAutoLogin = NO;
        
        if (_userInfoList) {
            [_userInfoList release];
            _userInfoList = nil;
        }
        
        if (_oldUserInfoList) {
            [_oldUserInfoList release];
            _oldUserInfoList = nil;
        }
        _userInfoList  = [[NSMutableArray alloc] init];
        _oldUserInfoList  = [[NSMutableArray alloc] init];
        userNameTableViewIsShow = NO;
        
        
        
        
        loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setTitle:@"登\t\t录" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(loginButtonPressedown) forControlEvents:UIControlEventTouchUpInside];
        [[loginButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
        [_bgImageView addSubview:loginButton];
        
        oneKeyLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [oneKeyLoginButton setTitle:@"一键登录" forState:UIControlStateNormal];
        [oneKeyLoginButton addTarget:self action:@selector(oneKeyLoginButtonPressedown) forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:oneKeyLoginButton];
        [oneKeyLoginButton setHidden:YES];
        
        
        passWordImageView = [[UIImageView alloc] init];
        userNameImageView = [[UIImageView alloc] init];
        
        [userNameImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:userNameImageView];
        [userNameImageView release];
        
        [passWordImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:passWordImageView];
        [passWordImageView release];
        
        userNameLabel = [[UILabel alloc] init];
        [userNameLabel setText:@"用户名"];
//        [userNameLabel setTextColor:[UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:100.0/255]];
        [userNameLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [userNameLabel setBackgroundColor:[UIColor clearColor]];
        [userNameImageView addSubview:userNameLabel];
        [userNameLabel release];
        
        userNameField = [[PPTextField alloc] init];
        [userNameField setKeyboardType:UIKeyboardTypeDefault];
        [userNameField setAutocorrectionType:UITextAutocorrectionTypeNo];
        //        [userNameField setSpellCheckingType:UITextSpellCheckingTypeNo];
        [userNameField setDelegate:self];
        [userNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [userNameField setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [userNameField setTextAlignment:NSTextAlignmentLeft];
        [userNameField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [userNameField setReturnKeyType:UIReturnKeyNext];
        [userNameImageView addSubview:userNameField];
        [userNameField release];
        
        passWordLabel = [[UILabel alloc] init];
        [passWordLabel setText:@"密　码"];
//        [passWordLabel setTextColor:[UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:100.0/255]];
        [passWordLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [passWordLabel setBackgroundColor:[UIColor clearColor]];
        [passWordImageView addSubview:passWordLabel];
        [passWordLabel release];
        
        passWordField = [[PPTextField alloc] init];
        [passWordField setDelegate:self];
        [passWordField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [passWordField setTextAlignment:NSTextAlignmentLeft];
        //        [passWordField setSpellCheckingType:UITextSpellCheckingTypeNo];
        [passWordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [passWordField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
        [passWordField setSecureTextEntry:YES];
        //编辑时会出现个修改X
        [passWordField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [passWordField setClearsOnBeginEditing:NO];
        [passWordField setTextAlignment:NSTextAlignmentLeft];
        [passWordField setReturnKeyType:UIReturnKeySend];
        [passWordImageView addSubview:passWordField];
        [passWordField release];
        
        recordUserNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [recordUserNameButton addTarget:self action:@selector(recordUserNameButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [userNameImageView addSubview:recordUserNameButton];
        
        keepPassWordLabel = [[PPHyperlinkLabel alloc] init];
        [keepPassWordLabel setDelegate:self];
        [keepPassWordLabel setText:@"记住密码"];
        [keepPassWordLabel setFont:[UIFont systemFontOfSize:26 * (1 / 2.0)]];
        [keepPassWordLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
        [keepPassWordLabel setBackgroundColor:[UIColor clearColor]];
        [_bgImageView addSubview:keepPassWordLabel];
        [keepPassWordLabel release];
        
        keepPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [keepPassWordButton addTarget:self action:@selector(isKeepPassWordButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [keepPassWordButton setBackgroundColor:[UIColor clearColor]];
        [keepPassWordButton setImageEdgeInsets:UIEdgeInsetsMake(0, -9, 0, 0)];
        [_bgImageView addSubview:keepPassWordButton];
        
        
        keepAutoLoginLabel = [[PPHyperlinkLabel alloc] init];
        [keepAutoLoginLabel setDelegate:self];
        [keepAutoLoginLabel setText:@"自动登录"];
        [keepAutoLoginLabel setFont:[UIFont systemFontOfSize:26 * (1 / 2.0)]];
        [keepAutoLoginLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
        [keepAutoLoginLabel setBackgroundColor:[UIColor clearColor]];
        [_bgImageView addSubview:keepAutoLoginLabel];
        [keepAutoLoginLabel release];
        
        
        keepAutoLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [keepAutoLoginButton addTarget:self action:@selector(isAutoLoginWordButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [keepAutoLoginButton setBackgroundColor:[UIColor clearColor]];
        [keepAutoLoginButton setImageEdgeInsets:UIEdgeInsetsMake(0, -9, 0, 0)];
        [_bgImageView addSubview:keepAutoLoginButton];
        
        userNameTableView = [[UITableView alloc] init];
        [userNameTableView setShowsVerticalScrollIndicator:YES];
        [userNameTableView setShowsHorizontalScrollIndicator:YES];
        [userNameTableView setTag:noDisableVerticalScrollTag];
        [[userNameTableView layer] setBorderWidth:0.8];
        [[userNameTableView layer] setBorderColor:[[PPUserNameCell getColor:@"c7c7c7"] CGColor]];
        [userNameTableView setSeparatorColor:[PPUserNameCell getColor:@"e6e6e6"]];
        [userNameTableView setDelegate:self];
        [userNameTableView setDataSource:self];
//        [self setTableViewUserHidden:YES];
        [_bgImageView addSubview:userNameTableView];
        [userNameTableView release];
        
        forgetPassWordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [[forgetPassWordButton titleLabel] setTextAlignment:NSTextAlignmentLeft];
        [forgetPassWordButton setBackgroundColor:[UIColor clearColor]];
        [forgetPassWordButton setTitleColor:[UIColor colorWithRed:110 / 255.0 green:120 /255.0 blue:130 / 255.0 alpha:1] forState:UIControlStateNormal];
        [forgetPassWordButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [[forgetPassWordButton titleLabel] setFont:[UIFont systemFontOfSize:26 * (1 / 2.0)]];
        [forgetPassWordButton setTitle:@"忘记账号/密码？" forState:UIControlStateNormal];
        [forgetPassWordButton addTarget:self action:@selector(forgetPassWordButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:forgetPassWordButton];
        
        registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [[registerButton titleLabel] setTextAlignment:NSTextAlignmentLeft];
        [registerButton setBackgroundColor:[UIColor clearColor]];
        [registerButton setTitleColor:[UIColor colorWithRed:110 / 255.0 green:120 / 255.0 blue:130 / 255.0 alpha:1] forState:UIControlStateNormal];
        [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [[registerButton titleLabel] setFont:[UIFont systemFontOfSize:26 * (1 / 2.0)]];
        [registerButton setTitle:@"注册会员" forState:UIControlStateNormal];
        [registerButton addTarget:self action:@selector(registerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:registerButton];
        
        [keepAutoLoginButton setImage:[PPUIKit setLocaImage:@"PPCheckbox"]
                             forState:UIControlStateNormal];
        [keepPassWordButton setImage:[PPUIKit setLocaImage:@"PPCheckbox"]
                            forState:UIControlStateNormal];
        [recordUserNameButton setImage:[PPUIKit setLocaImage:@"PPArrowRight"]
                              forState:UIControlStateNormal];
        [passWordImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxBottom"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [userNameImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [loginButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPLoginButtonNormal"]
                                         stretchableImageWithLeftCapWidth:5
                                         topCapHeight:5]
                               forState:UIControlStateNormal];
        [loginButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPLoginButtonPressed"]
                                         stretchableImageWithLeftCapWidth:5
                                         topCapHeight:5]
                               forState:UIControlStateHighlighted];
        [oneKeyLoginButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPButton"]
                                               stretchableImageWithLeftCapWidth:5
                                               topCapHeight:5]
                                     forState:UIControlStateNormal];
    
        
        [self initVerticalFrame];
        [self addNotification];
    }
    return self;
}



-(void)initVerticalFrame{
    [super initVerticalFrame];

    [userNameImageView setFrame:CGRectMake(0, 85, _bgImageView.frame.size.width, 44)];
    CGSize usernameLabelSize = [userNameLabel.text sizeWithFont:[UIFont systemFontOfSize:32 * (1 / 2.0)]
                                              constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    
    [userNameLabel setFrame:CGRectMake(16, 0, usernameLabelSize.width, 44)];
    [passWordLabel setFrame:CGRectMake(16, 0, usernameLabelSize.width, 44)];
    
    [recordUserNameButton setFrame:CGRectMake(userNameImageView.frame.size.width - 44, 0, 44, 44)];

    [userNameField setFrame:CGRectMake(userNameLabel.frame.origin.x + userNameLabel.frame.size.width + 35,
                                       0,
                                       userNameImageView.frame.size.width - recordUserNameButton.frame.size.width - userNameLabel.frame.size.width - 51,
                                       44)];
    
//    [passWordField setFrame:CGRectMake(passWordLabel.frame.origin.x + passWordLabel.frame.size.width + 35, 0,
//                                       passWordImageView.frame.size.width - passWordLabel.frame.size.width, 44)];
    
    
    [passWordField setFrame:CGRectMake(passWordLabel.frame.origin.x + passWordLabel.frame.size.width + 35, 0,
                                       passWordImageView.frame.size.width -
                                       recordUserNameButton.frame.size.width -
                                       passWordLabel.frame.size.width - 51, 44)];
    
    
    [userNameTableView setFrame:CGRectMake(userNameImageView.frame.origin.x,
                                           userNameImageView.frame.origin.y + userNameImageView.frame.size.height,
                                           userNameImageView.frame.size.width,
                                           0)];
    
    if (userNameTableViewIsShow) {
        
        [self setTableViewUserHidden:NO];
        return;
    }

    [passWordImageView setFrame:CGRectMake(0, userNameTableView.frame.origin.y + userNameTableView.frame.size.height,
                                           _bgImageView.frame.size.width, 44)];
    

    
    CGSize keepLabelSize = [keepAutoLoginLabel.text sizeWithFont:[UIFont systemFontOfSize:32 * (1 / 2.0)]
                                               constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
//    [passWordImageView setFrame:CGRectMake(0, userNameTableView.frame.origin.y + userNameTableView.frame.size.height,
//                                           _bgImageView.frame.size.width, 44)];
    
    
    [loginButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                     passWordImageView.frame.origin.y +  passWordImageView.frame.size.height + 80, 300, 44)];

    
    [keepPassWordButton setFrame:CGRectMake(18,
                                            passWordImageView.frame.origin.y + 60, 30, 44)];
    
    
    [keepPassWordLabel setFrame:CGRectMake(keepPassWordButton.frame.size.width + keepPassWordButton.frame.origin.x,
                                           keepPassWordButton.frame.origin.y,
                                           keepLabelSize.width, 44)];
    
    
    [keepAutoLoginButton setFrame:CGRectMake(loginButton.frame.origin.x + loginButton.frame.size.width - keepLabelSize.width - 30,
                                             keepPassWordButton.frame.origin.y, 30, 44)];
    
    [keepAutoLoginLabel setFrame:CGRectMake(keepAutoLoginButton.frame.origin.x + keepAutoLoginButton.frame.size.width,
                                            keepAutoLoginButton.frame.origin.y,
                                            keepLabelSize.width,44)];
    
    [forgetPassWordButton setFrame:CGRectMake(0, _bgImageView.frame.size.height - 41, 150, 40)];
    [registerButton setFrame:CGRectMake(_bgImageView.frame.size.width - 100,
                                        _bgImageView.frame.size.height - 41, 100, 40)];
}

-(void)initHorizontalFrame{
    
    [super initHorizontalFrame];

//    UIFont *titleLabelFont = [UIFont fontWithName:@"Helvetica" size:20.0];
//    CGSize size = CGSizeMake(320,2000);
//    CGSize labelsize = [[_titleLabel text] sizeWithFont:titleLabelFont constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//    [_titleLabel setFrame:CGRectMake:(0,0, labelsize.width, labelsize.height)];
    
    [userNameImageView setFrame:CGRectMake(0, 85, _bgImageView.frame.size.width, 44)];

    
    [userNameLabel setFrame:CGRectMake(16, 0, 64, 44)];
    [passWordLabel setFrame:CGRectMake(16, 0, 64, 44)];
    
    
    [userNameTableView setFrame:CGRectMake(userNameImageView.frame.origin.x,
                                           userNameImageView.frame.origin.y + userNameImageView.frame.size.height ,
                                           userNameImageView.frame.size.width,
                                           0)];
    if (userNameTableViewIsShow) {
        [self setTableViewUserHidden:NO];
        return;
    }

    [passWordImageView setFrame:CGRectMake(0, userNameTableView.frame.origin.y + userNameTableView.frame.size.height,
                                           _bgImageView.frame.size.width, 44)];
    
    [recordUserNameButton setFrame:CGRectMake(userNameImageView.frame.size.width - 44, 0, 44, 44)];
    
    [userNameField setFrame:CGRectMake(userNameLabel.frame.origin.x + userNameLabel.frame.size.width,
                                       0,
                                       userNameImageView.frame.size.width - recordUserNameButton.frame.size.width - userNameLabel.frame.size.width - 10,
                                       44)];
    
    [passWordField setFrame:CGRectMake(passWordLabel.frame.origin.x + passWordLabel.frame.size.width, 0,
                                       passWordImageView.frame.size.width -
                                       recordUserNameButton.frame.size.width -
                                       passWordLabel.frame.size.width, 44)];
    
    CGSize keepLabelSize = [keepAutoLoginLabel.text sizeWithFont:[UIFont systemFontOfSize:32 * (1 / 2.0)]
                                               constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    [passWordImageView setFrame:CGRectMake(0, userNameTableView.frame.origin.y + userNameTableView.frame.size.height,
                                           _bgImageView.frame.size.width, 44)];
    
    
//    [loginButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
//                                     passWordImageView.frame.origin.y +  passWordImageView.frame.size.height + 80, 300, 44)];
    
    [loginButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, passWordImageView.frame.origin.y + passWordImageView.frame.size.height * 2 + 15,
                                     300, 44)];
    
    [keepPassWordButton setFrame:CGRectMake(loginButton.frame.origin.x + 2,
                                            passWordImageView.frame.origin.y + 50, 30, 44)];
    
    
    [keepPassWordLabel setFrame:CGRectMake(keepPassWordButton.frame.size.width + keepPassWordButton.frame.origin.x,
                                           keepPassWordButton.frame.origin.y,
                                           keepLabelSize.width, 44)];
    
    
    [keepAutoLoginButton setFrame:CGRectMake(loginButton.frame.origin.x + loginButton.frame.size.width -keepLabelSize.width - 30,
                                             passWordImageView.frame.origin.y + 50, 30, 44)];
    
    [keepAutoLoginLabel setFrame:CGRectMake(keepAutoLoginButton.frame.origin.x + keepAutoLoginButton.frame.size.width,
                                            keepAutoLoginButton.frame.origin.y,
                                            keepLabelSize.width,44)];
    
    [forgetPassWordButton setFrame:CGRectMake(0, _bgImageView.frame.size.height - 41, 150, 40)];
    [registerButton setFrame:CGRectMake(_bgImageView.frame.size.width - 100,
                                        _bgImageView.frame.size.height - 41, 100, 40)];

    
}

#pragma mark - 点击手势事件  -

-(void)singleRecognizerHandler
{
    [super singleRecognizerHandler];
    
    if (userNameTableViewIsShow) {
        [self setTableViewUserHidden:YES];
    }
}


#pragma mark  - 记住密码，自动登录，忘记密码/账号，注册  , 登录 ,关闭视图 点击事件 -
/**
 *  记住密码 点击事件
 */
-(void)isKeepPassWordButtonPressed
{
    if (isKeepPassWord) {
        isKeepPassWord = NO;
        isKeepAutoLogin = NO;
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox"];
        [keepPassWordButton setImage:iamgeTmp
                            forState:UIControlStateNormal];
        [keepAutoLoginButton setImage:iamgeTmp
                             forState:UIControlStateNormal];
        
        [keepPassWordLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
        [keepAutoLoginLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
    }else{
        isKeepPassWord = YES;
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox_checked"];
        [keepPassWordButton setImage:iamgeTmp
                            forState:UIControlStateNormal];
        
        [keepPassWordLabel setTextColor:[PPCommon getColor:@"0d7aff"]];
        
    }
    if (PP_ISNSLOG)
        NSLog(@"记住密码");
}
/**
 *  自动登录 点击事件
 */
-(void)isAutoLoginWordButtonPressed
{
    if (isKeepAutoLogin) {
        isKeepAutoLogin = NO;
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox"];
        [keepAutoLoginButton setImage:iamgeTmp
                             forState:UIControlStateNormal];
        [keepAutoLoginLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
    }else{
        isKeepAutoLogin = YES;
        isKeepPassWord = YES;
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox_checked"];
        [keepPassWordButton setImage:iamgeTmp
                            forState:UIControlStateNormal];
        [keepAutoLoginButton setImage:iamgeTmp
                             forState:UIControlStateNormal];
        
        [keepPassWordLabel setTextColor:[PPCommon getColor:@"0d7aff"]];
        [keepAutoLoginLabel setTextColor:[PPCommon getColor:@"0d7aff"]];
    }
    if (PP_ISNSLOG)
        NSLog(@"自动登录");
}

/**
 *  设置是否自动登录
 *
 *  @param param 关闭/开启
 */
-(void)setIsKeepAutoLoginImage:(BOOL)param{
    if (isKeepAutoLogin) {
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox_checked"];
        [keepPassWordButton setImage:iamgeTmp
                            forState:UIControlStateNormal];
        [keepAutoLoginButton setImage:iamgeTmp
                             forState:UIControlStateNormal];
        [keepAutoLoginLabel setTextColor:[PPCommon getColor:@"0d7aff"]];
        [keepPassWordLabel setTextColor:[PPCommon getColor:@"0d7aff"]];
        
    }else{
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox"];
        [keepAutoLoginButton setImage:iamgeTmp
                             forState:UIControlStateNormal];
        [keepAutoLoginLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
    }
}

/**
 *  设置是否记住密码
 *
 *  @param param 关闭/开启
 */
-(void)setIsKeepPassWordImage:(BOOL)paramIsKeepPassWord{
    
    if (paramIsKeepPassWord) {
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox_checked"];
        [keepPassWordButton setImage:iamgeTmp
                            forState:UIControlStateNormal];
        [keepPassWordLabel setTextColor:[PPCommon getColor:@"0d7aff"]];
    }else{
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox"];
        [keepPassWordButton setImage:iamgeTmp
                            forState:UIControlStateNormal];
        [keepAutoLoginButton setImage:iamgeTmp
                             forState:UIControlStateNormal];
        
        [keepAutoLoginLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
        [keepPassWordLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
    }
}


/**
 *  忘记密码/账号 点击事件
 */
-(void)forgetPassWordButtonPressed
{
    if (PP_ISNSLOG)
        NSLog(@"忘记密码");
    [self hiddenLoginViewInLeft];
    PPForgetWhatView *ppForgetWhatView = [[PPForgetWhatView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppForgetWhatView atIndex:1000];
    [ppForgetWhatView showPPPForgetWhatViewByRight];
    [ppForgetWhatView release];
}

/**
 *  注册 点击事件
 */
-(void)registerButtonPressed
{
    if (PP_ISNSLOG)
        NSLog(@"注册页面");
    PPRegisterView *ppRegisterView = [[PPRegisterView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppRegisterView atIndex:1000];
    [ppRegisterView showRegisterViewByRight];
    [ppRegisterView release];
    [self hiddenLoginViewInLeft];
}


/**
 *  登录 点击事件
 */
-(void)loginButtonPressedown{
    [[PPAppPlatformKit sharedInstance] setIsOneKeyLogin:NO];
    NSString *message = @"";
    NSString *title = @"温馨提示";
    const char *cString = [userNameField.text UTF8String];
    if(userNameField.text == nil || ![userNameField.text length]){
        message = @"用户名不能为空！";
    }else if(passWordField.text == nil || ![passWordField.text length]){
        if (PP_ISNSLOG) {
            NSLog(@"PP-密码不能为空！");            
        }

        message = @"密码不能为空！";
    }else if ([PPCommon isValidateUserName:[userNameField text]]) {
        message = @"用户名不符合规则！";
    }else if (strlen(cString) < 3){
        message = @"用户名长度不符合规则！";
    }
    else if ([PPCommon isValidateUserName:[passWordField text]] || [passWordField.text length] < 6) {
        message = @"密码长度不符合规则！";
    }
    else
    {
        [userNameField resignFirstResponder];
        [passWordField resignFirstResponder];
        [self revertView];
        if (PP_ISNSLOG)
            NSLog(@"登录");
//        if([[NSUserDefaults standardUserDefaults] boolForKey:@"PP_A"]){
//            mbProgressHUD = [PPMBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
//        }else{
//            mbProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
//        }
        
        
        mbProgressHUD.labelText = @"请求登录...";
        [mbProgressHUD show:YES];
        const char *password_ = [passWordField.text UTF8String];
        unsigned char passwordHash[32] = {0};
        sha256_memory((unsigned char*)password_, strlen(password_), passwordHash);
        NSData *passWord = [NSData dataWithBytes:passwordHash length:32];
        
        [[TRUserRequest defaultTRUserRequest] requestLogin:userNameField.text password:passWord
                                                  userType:SDKUserTypeGame userInfo:nil delegate:self];

        if (PP_ISNSLOG) {
            NSLog(@"请求登录");
        }
        return;
    }
    PPAlertView *alert = [[PPAlertView alloc] initWithTitle:title message:message];
    [alert setCancelButtonTitle:@"确定" block:^{
        
    }];
    [alert addButtonWithTitle:nil block:nil];
    
    [alert show];
    [alert release];
}

/**
 *  关闭视图 点击事件
 */
-(void) closeButtonPressed{
    [super closeButtonPressed];
    [[[PPAppPlatformKit sharedInstance] delegate] ppClosePageViewCallBack:PPLoginViewPageCode];
}

#pragma mark - loginViewWillShow -

//登录页面出现前得处理最后一次登录用户得信息
-(BOOL)loginViewWillShow{
    
    BOOL tempIsKeepAutoLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"PP_A"];
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"PP_A"]){
        mbProgressHUD = [PPMBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
        
    }else{
        mbProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
    }
    isKeepAutoLogin = tempIsKeepAutoLogin;
    [self setIsKeepAutoLoginImage:isKeepAutoLogin];
    
    
    //如果用户名为NSData类型
    NSData *u = [[NSUserDefaults standardUserDefaults] objectForKey:@"PP_U"];
    if ([u isKindOfClass:[NSData class]]) {
        NSData *p = [[NSUserDefaults standardUserDefaults] objectForKey:@"PP_P"];
        DecodeXor((unsigned char *)u.bytes, u.length, 0x7C);
        DecodeXor((unsigned char *)p.bytes, p.length, 0x8E);
        if (tempIsKeepAutoLogin) {
            NSString *isKeepAutoLoginUserName = [[NSString alloc] initWithData:u encoding:NSUTF8StringEncoding];
            NSString *isKeepAutoLoginPassword = [[NSString alloc] initWithData:p encoding:NSUTF8StringEncoding];
            EncodeXor((unsigned char *)u.bytes, u.length, 0x7C);
            EncodeXor((unsigned char *)p.bytes, p.length, 0x8E);
            if ([isKeepAutoLoginUserName length] >= 1 && [isKeepAutoLoginPassword length] >= 6) {
                [userNameField setText:isKeepAutoLoginUserName];
                [passWordField setText:isKeepAutoLoginPassword];
                
                [isKeepAutoLoginUserName release];
                [isKeepAutoLoginPassword release];
                
                
                [self loginButtonPressedown];
                return YES;
            }else {
                [isKeepAutoLoginUserName release];
                [isKeepAutoLoginPassword release];
                
                [[TRKeyValueRequest defaultTRKeyValueRequest] requestGetValue:[TRUserHelper getDeviceLoginRecordsKey]
                                                                         flag:0
                                                                      timeOut:10
                                                                     userInfo:nil
                                                                     delegate:self];
                
                mbProgressHUD.labelText = @"读取用户列表...";
                [mbProgressHUD show:YES];
                return NO;
                
            }
            
        }else{
            [[TRKeyValueRequest defaultTRKeyValueRequest] requestGetValue:[TRUserHelper getDeviceLoginRecordsKey]
                                                                     flag:0
                                                                  timeOut:10
                                                                 userInfo:nil
                                                                 delegate:self];
            
            mbProgressHUD.labelText = @"读取用户列表...";
            [mbProgressHUD show:YES];
            return NO;
        }
    }
    
    else
    {
        //则为新规则
        if (tempIsKeepAutoLogin)
        {
            if (PP_ISNSLOG)
                NSLog(@"登录");
            
            mbProgressHUD.labelText = @"请求登录...";
            [mbProgressHUD show:YES];
            NSData *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"PP_P"];
            NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"PP_U"];
            
            [[TRUserRequest defaultTRUserRequest] requestLogin:userName password:passWord
                                                      userType:SDKUserTypeGame userInfo:nil delegate:self];
            return YES;
        }
        else
        {
            [[TRKeyValueRequest defaultTRKeyValueRequest] requestGetValue:[TRUserHelper getDeviceLoginRecordsKey]
                                                                     flag:0
                                                                  timeOut:10
                                                                 userInfo:nil
                                                                 delegate:self];
            
            mbProgressHUD.labelText = @"读取用户列表...";
            [mbProgressHUD show:YES];
            return NO;
        }
    }
    
}



#pragma mark  - HyperlinkLabelDelegate  -

-(void)myLabel:(PPHyperlinkLabel *)myLabel{
    if (myLabel == keepPassWordLabel) {
        [self isKeepPassWordButtonPressed];
    }else if (myLabel == keepAutoLoginLabel){
        [self isAutoLoginWordButtonPressed];
    }
}


#pragma mark  - 视图显示，隐藏，消失 -
//消失到右边
-(void)hiddenLoginViewInRight
{
    [self setTableViewUserHidden:YES];
    [super hiddenViewInRight];
}

//从右边展示
-(void)showLoginViewByRight
{
    if (_isShowNow) {
        return;
    }
    
    if (![self loginViewWillShow]) {
        if (PP_ISNSLOG) {
            NSLog(@"不是自动登录，出现了");
        }

        [self setHidden:NO];
        [super showViewByRight];
    }else {
        //yes
        if (PP_ISNSLOG) {
            NSLog(@"是自动登录,隐藏了");
        }
        [self setHidden:YES];
        //        [self hiddenLoginViewInLeft];
    }
}
/**
 *  登陆从左边展示
 */
-(void)showLoginViewByLeft
{
    if (![self loginViewWillShow]) {
        [self setHidden:NO];
        [super showViewByLeft];
    }else {
        [self setHidden:YES];
        [self hiddenLoginViewInLeft];
    }
    
}

/**
 *  消失到左边
 */
-(void)hiddenLoginViewInLeft
{
    [self setTableViewUserHidden:YES];
    [super hiddenViewInLeft];
}

-(void)didHiddenView
{
    [super didHiddenView];
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"PP_A"]){
        [PPMBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
        
    }else{
        [PPMBProgressHUD hideAllHUDsForView:self animated:YES];
    }
    
}

#pragma mark  - UITableViewDataSource , UITableViewDelegate ,删除用户记录点击事件 -

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (PP_ISNSLOG) {
        NSLog(@"返回了%d条用户记录", [_userInfoList count]);
    }
    return [_userInfoList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableViewSystem cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"CELLd";
    PPUserNameCell *cell;
    cell = [tableViewSystem dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[PPUserNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
    }
    TRUserInfo *userInfo = [_userInfoList objectAtIndex:[indexPath row]];
    [[cell cellUserLabel] setText:[userInfo userName]];
    [[cell cellDelButton] setTag:[indexPath row]];
    [[cell cellDelButton] addTarget:self action:@selector(delUserInfoCell:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self setTableViewUserHidden:YES];
    userNameField.text = @"";
    passWordField.text = @"";
    
    TRUserInfo *selectUserInfo = [_userInfoList objectAtIndex:indexPath.row];
    [userNameField setText:selectUserInfo.userName];
    
    
    isKeepPassWord = [selectUserInfo isKeepPassWord];
    [self setIsKeepPassWordImage:selectUserInfo.isKeepPassWord];
    if ([selectUserInfo isKeepPassWord])
        [passWordField setText:selectUserInfo.password];
    
}

-(void)delUserInfoCell:(UIButton *)sender
{
    [userNameTableView beginUpdates];
    PPUserNameCell *cell;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        cell = (PPUserNameCell *)[[sender superview] superview];
    }
    else{
        cell = (PPUserNameCell *)[sender superview];
    }
//    PPUserNameCell *cell = (PPUserNameCell *)[[sender superview] superview];
    int i = [[userNameTableView indexPathForCell:cell] row];

    TRUserInfo *delUserInfo = [_userInfoList objectAtIndex:i];
    if ([[delUserInfo userName] isEqualToString:[userNameField text]]) {
        [userNameField setText:@""];
        [passWordField setText:@""];
    }
    if ([_userInfoList count] <= 3) {
        [UIView beginAnimations:@"tableViewHidenYNo" context:nil];
        [UIView setAnimationDuration:0.30];
        [UIView setAnimationDelegate:self];
        [userNameTableView setFrame:CGRectMake(userNameImageView.frame.origin.x,
                                               userNameImageView.frame.origin.y + userNameImageView.frame.size.height,
                                               userNameImageView.frame.size.width,
                                               44 * ([_userInfoList count] - 1))];

        CGSize keepLabelSize = [keepAutoLoginLabel.text sizeWithFont:[UIFont systemFontOfSize:32 * (1 / 2.0)]
                                                   constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        
        [passWordImageView setFrame:CGRectMake(0, userNameTableView.frame.origin.y + userNameTableView.frame.size.height,
                                               _bgImageView.frame.size.width, 44)];
        [recordUserNameButton setFrame:CGRectMake(userNameImageView.frame.size.width - 44, 0, 44, 44)];
        
        
        UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
        
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
        {
            [keepPassWordButton setFrame:CGRectMake(loginButton.frame.origin.x + 2,
                                                    passWordImageView.frame.origin.y + 50, 30, 44)];
            
            
            [keepPassWordLabel setFrame:CGRectMake(keepPassWordButton.frame.size.width + keepPassWordButton.frame.origin.x,
                                                   keepPassWordButton.frame.origin.y,
                                                   keepLabelSize.width, 44)];
            
            
            [keepAutoLoginButton setFrame:CGRectMake(loginButton.frame.origin.x + loginButton.frame.size.width -keepLabelSize.width - 30,
                                                     passWordImageView.frame.origin.y + 50, 30, 44)];
            
            [keepAutoLoginLabel setFrame:CGRectMake(keepAutoLoginButton.frame.origin.x + keepAutoLoginButton.frame.size.width,
                                                    keepAutoLoginButton.frame.origin.y,
                                                    keepLabelSize.width,44)];
            
            [loginButton setFrame:CGRectMake((_bgImageView.frame.size.width-300) / 2, passWordImageView.frame.origin.y + passWordImageView.frame.size.height * 2 + 15,
                                             300, 44)];
        }
        else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
        {
            [keepPassWordButton setFrame:CGRectMake(18,
                                                    passWordImageView.frame.origin.y + 60, 30, 44)];
            
            
            [keepPassWordLabel setFrame:CGRectMake(keepPassWordButton.frame.size.width + keepPassWordButton.frame.origin.x,
                                                   keepPassWordButton.frame.origin.y,
                                                   keepLabelSize.width, 44)];
            
            
            [keepAutoLoginButton setFrame:CGRectMake(loginButton.frame.origin.x + loginButton.frame.size.width - keepLabelSize.width - 30,
                                                     keepPassWordButton.frame.origin.y, 30, 44)];
            
            [keepAutoLoginLabel setFrame:CGRectMake(keepAutoLoginButton.frame.origin.x + keepAutoLoginButton.frame.size.width,
                                                    keepAutoLoginButton.frame.origin.y,
                                                    keepLabelSize.width,44)];
            
            [loginButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                             passWordImageView.frame.origin.y +  passWordImageView.frame.size.height + 80, 300, 44)];

        }
 
        
        
        
        
        [forgetPassWordButton setFrame:CGRectMake(0, _bgImageView.frame.size.height - 41 + 40 * [_userInfoList count], 150, 40)];
        [registerButton setFrame:CGRectMake(_bgImageView.frame.size.width - 100,
                                            _bgImageView.frame.size.height - 41 + 40 * [_userInfoList count], 100, 40)];
        [UIView commitAnimations];

    }
    [_userInfoList removeObject:delUserInfo];
    if ([_userInfoList count] <= 0) {
        [self setTableViewUserHidden:YES];
        [recordUserNameButton setHidden:YES];
    }
    NSArray *_tempIndexPathArr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]];
    [userNameTableView deleteRowsAtIndexPaths:_tempIndexPathArr withRowAnimation:UITableViewRowAnimationAutomatic];
    [userNameTableView endUpdates];
    
    
//    [userNameTableView reloadData];
    //调用一次刷新tableview上的滚动条【从而根据扩充UIImageView方法实现永久显示】
    [userNameTableView flashScrollIndicators];

}

#pragma mark - 展示/隐藏 用户记录 TableView
/**
 *  展示 用户记录 TableView
 */
-(void)recordUserNameButtonPressed{
    
    [passWordField resignFirstResponder];
    
    if (!userNameTableViewIsShow) {
        
        [self setTableViewUserHidden:NO];
        [userNameTableView reloadData];
        //调用一次显示tableview上的滚动条【从而根据扩充UIImageView方法实现永久显示】
        [userNameTableView flashScrollIndicators];
        
    }else{
        [self setTableViewUserHidden:YES];
    }
}


-(void) setTableViewUserHidden:(BOOL)hidden
{
    CGSize keepLabelSize = [keepAutoLoginLabel.text sizeWithFont:[UIFont systemFontOfSize:32 * (1 / 2.0)]
                                               constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    if (hidden) {
        [UIView beginAnimations:@"tableViewHidenYes" context:nil];
        [UIView setAnimationDuration:0.30];
        [UIView setAnimationDelegate:self];
        [recordUserNameButton setTransform:CGAffineTransformMakeRotation(0)];
        [userNameTableView setFrame:CGRectMake(userNameTableView.frame.origin.x,
                                               userNameTableView.frame.origin.y,
                                               userNameTableView.frame.size.width,
                                               0)];
        [passWordImageView setFrame:CGRectMake(0, userNameTableView.frame.origin.y + userNameTableView.frame.size.height,
                                               _bgImageView.frame.size.width, 44)];
        [recordUserNameButton setFrame:CGRectMake(userNameImageView.frame.size.width - 44, 0, 44, 44)];
        
        
        UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
        {
            [keepPassWordButton setFrame:CGRectMake(loginButton.frame.origin.x + 2,
                                                    passWordImageView.frame.origin.y + 50, 30, 44)];
            
            
            [keepPassWordLabel setFrame:CGRectMake(keepPassWordButton.frame.size.width + keepPassWordButton.frame.origin.x,
                                                   keepPassWordButton.frame.origin.y,
                                                   keepLabelSize.width, 44)];
            
            
            [keepAutoLoginButton setFrame:CGRectMake(loginButton.frame.origin.x + loginButton.frame.size.width -keepLabelSize.width - 30,
                                                     passWordImageView.frame.origin.y + 50, 30, 44)];
            
            [keepAutoLoginLabel setFrame:CGRectMake(keepAutoLoginButton.frame.origin.x + keepAutoLoginButton.frame.size.width,
                                                    keepAutoLoginButton.frame.origin.y,
                                                    keepLabelSize.width,44)];
            
            [loginButton setFrame:CGRectMake((_bgImageView.frame.size.width-300) / 2, passWordImageView.frame.origin.y + passWordImageView.frame.size.height * 2 + 15,
                                             300, 44)];
        }
        else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
        {
            [keepPassWordButton setFrame:CGRectMake(18,
                                                    passWordImageView.frame.origin.y + 60, 30, 44)];
            
            
            [keepPassWordLabel setFrame:CGRectMake(keepPassWordButton.frame.size.width + keepPassWordButton.frame.origin.x,
                                                   keepPassWordButton.frame.origin.y,
                                                   keepLabelSize.width, 44)];
            
            
            [keepAutoLoginButton setFrame:CGRectMake(loginButton.frame.origin.x + loginButton.frame.size.width - keepLabelSize.width - 30,
                                                     keepPassWordButton.frame.origin.y, 30, 44)];
            
            [keepAutoLoginLabel setFrame:CGRectMake(keepAutoLoginButton.frame.origin.x + keepAutoLoginButton.frame.size.width,
                                                    keepAutoLoginButton.frame.origin.y,
                                                    keepLabelSize.width,44)];
            
            [loginButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                             passWordImageView.frame.origin.y +  passWordImageView.frame.size.height + 80, 300, 44)];
            
        }
        
        [forgetPassWordButton setFrame:CGRectMake(0, _bgImageView.frame.size.height - 41, 150, 40)];
        [registerButton setFrame:CGRectMake(_bgImageView.frame.size.width - 100,
                                            _bgImageView.frame.size.height - 41, 100, 40)];
        
        [UIView commitAnimations];
        
        userNameTableViewIsShow = NO;
    }else{
        
        [UIView beginAnimations:@"tableViewHidenNO" context:nil];
        [UIView setAnimationDuration:0.30];
        [UIView setAnimationDelegate:self];
        [recordUserNameButton setTransform:CGAffineTransformMakeRotation(1.57)];
        if ([_userInfoList count] >= 3) {
            [userNameTableView setFrame:CGRectMake(userNameTableView.frame.origin.x,
                                                   userNameTableView.frame.origin.y,
                                                   userNameTableView.frame.size.width,
                                                   44 * 3)];
        }
        else{
            [userNameTableView setFrame:CGRectMake(userNameTableView.frame.origin.x,
                                                   userNameTableView.frame.origin.y,
                                                   userNameTableView.frame.size.width,
                                                   44 * [_userInfoList count])];
        }
        [passWordImageView setFrame:CGRectMake(0, userNameTableView.frame.origin.y + userNameTableView.frame.size.height,
                                               _bgImageView.frame.size.width, 44)];
        [recordUserNameButton setFrame:CGRectMake(userNameImageView.frame.size.width - 44, 0, 44, 44)];
        
        UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
        
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
        {
            [keepPassWordButton setFrame:CGRectMake(loginButton.frame.origin.x + 2,
                                                    passWordImageView.frame.origin.y + 50, 30, 44)];
            
            
            [keepPassWordLabel setFrame:CGRectMake(keepPassWordButton.frame.size.width + keepPassWordButton.frame.origin.x,
                                                   keepPassWordButton.frame.origin.y,
                                                   keepLabelSize.width, 44)];
            
            
            [keepAutoLoginButton setFrame:CGRectMake(loginButton.frame.origin.x + loginButton.frame.size.width -keepLabelSize.width - 30,
                                                     passWordImageView.frame.origin.y + 50, 30, 44)];
            
            [keepAutoLoginLabel setFrame:CGRectMake(keepAutoLoginButton.frame.origin.x + keepAutoLoginButton.frame.size.width,
                                                    keepAutoLoginButton.frame.origin.y,
                                                    keepLabelSize.width,44)];
            
            [loginButton setFrame:CGRectMake((_bgImageView.frame.size.width-300) / 2, passWordImageView.frame.origin.y + passWordImageView.frame.size.height * 2 + 15,
                                             300, 44)];
        }
        else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
        {
            [keepPassWordButton setFrame:CGRectMake(18,
                                                    passWordImageView.frame.origin.y + 60, 30, 44)];
            
            
            [keepPassWordLabel setFrame:CGRectMake(keepPassWordButton.frame.size.width + keepPassWordButton.frame.origin.x,
                                                   keepPassWordButton.frame.origin.y,
                                                   keepLabelSize.width, 44)];
            
            
            [keepAutoLoginButton setFrame:CGRectMake(loginButton.frame.origin.x + loginButton.frame.size.width - keepLabelSize.width - 30,
                                                     keepPassWordButton.frame.origin.y, 30, 44)];
            
            [keepAutoLoginLabel setFrame:CGRectMake(keepAutoLoginButton.frame.origin.x + keepAutoLoginButton.frame.size.width,
                                                    keepAutoLoginButton.frame.origin.y,
                                                    keepLabelSize.width,44)];
            
            [loginButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                             passWordImageView.frame.origin.y +  passWordImageView.frame.size.height + 80, 300, 44)];
            
        }
        
        [forgetPassWordButton setFrame:CGRectMake(0, _bgImageView.frame.size.height - 41 + 40 * [_userInfoList count], 150, 40)];
        [registerButton setFrame:CGRectMake(_bgImageView.frame.size.width - 100,
                                            _bgImageView.frame.size.height - 41 + 40 * [_userInfoList count], 100, 40)];
        
        [UIView commitAnimations];
        
        userNameTableViewIsShow = YES;
    }
}


#pragma mark -  第一次安装获取所有用户记录  及 回调  -

- (void)checkUserInfoList{
    if (PP_ISNSLOG)
    {
        NSLog(@"checkUserInfoList第一安装获取该设备注册过的帐号信息");
    }
    
    _isUseOldGetUserList = YES;
    PPUserInfo *ppUserInfo = [[PPUserInfo alloc] init];
    [mbProgressHUD setLabelText:@"读取用户列表..."];
    [ppUserInfo firstGetUserNameArrayByNet];
    [ppUserInfo release];
}


/**
 *  第一次安装获取所有用户记录 通知事情
 *
 *  @param noti 数据
 */
-(void)getUserInfoCallBack:(NSNotification *)noti{
    NSMutableArray *oldAPIUserNameList = [[NSMutableArray alloc] initWithArray:noti.object];
    if (PP_ISNSLOG) {
        NSLog(@"getUserInfoCallBack回调方法");
        NSLog(@"getUserInfoCallBack-数组\n%@",noti.object);
    }
    
    //判断该设备是否没有注册过任何帐号。如果是则获取不到任何列表信息。默认是开启自动保存和登录
    if ([oldAPIUserNameList count] <= 0){
        [recordUserNameButton setHidden:YES];
    }else{
        [recordUserNameButton setHidden:NO];
    }
    
    
    for (int i = 0; i < [oldAPIUserNameList count]; i++) {
        NSString *oldUserName = [oldAPIUserNameList objectAtIndex:i];
        //        ********************
        TRUserInfo *newUserInfo = [TRUserInfo defaultTRUserInfo];
        [newUserInfo setUserName:oldUserName];
        NSString *oldUserPassWord = [KeychainUtils getPasswordForUsername:oldUserName andServiceName:PPFORSERVICENAME error:nil];
        if (oldUserPassWord == nil)
        {
            oldUserPassWord = [KeychainUtils getPasswordForUsername:oldUserName
                                                     andServiceName:PPFORSERVICENAME1 error:nil];
            if (oldUserPassWord == nil) {
                [newUserInfo setIsKeepPassWord:NO];
            }else{
                [newUserInfo setPassword:oldUserPassWord];
                [newUserInfo setIsKeepPassWord:YES];
                
            }
        }else{
            [newUserInfo setPassword:oldUserPassWord];
            [newUserInfo setIsKeepPassWord:YES];
        }
        [_userInfoList insertObject:newUserInfo atIndex:0];
    }
    
    //默认选择列表第一条【列表是按登录时间倒序排列从服务端获取】
    if (![oldAPIUserNameList count] <= 0) {
        [self tableView:userNameTableView didSelectRowAtIndexPath:0];
    }
    [oldAPIUserNameList release];
    [userNameTableView reloadData];
    [mbProgressHUD hide:YES];
    [self checkAndUpdateUserInfo];
    
}

#pragma mark - 同步用户记录 ， 更新 用户记录 显示数据 -
/**
 *  同步 用户记录
 */
- (void)checkAndUpdateUserInfo
{
    if (_isLoadedDeviceLoginRecords) {
        //add
        for (TRUserInfo *userInfo1 in _userInfoList) {
            
            BOOL addTag = YES;
            for (TRUserInfo *userInfo2 in _oldUserInfoList) {
                if ([userInfo1.userName isEqualToString:userInfo2.userName]) {
                    addTag = NO;
                    break;
                }
            }
            
            if (addTag) {
                [[TRKeyValueRequest defaultTRKeyValueRequest] requestAddKey:[TRUserHelper getDeviceLoginRecordsKey]
                                                                      value:[TRUserHelper getDeviceLoginRecordsValueByUserInfo:userInfo1]
                                                                       flag:0
                                                                    timeOut:0
                                                                   userInfo:nil
                                                                   delegate:nil];
                if (_isUseOldGetUserList) {
                    continue;
                }else{
                    break;
                }
                
            }
        }
        
        //del
        for (TRUserInfo *userInfo1 in _oldUserInfoList) {
            BOOL delTag = YES;
            for (TRUserInfo *userInfo2 in _userInfoList) {
                if ([userInfo1.userName isEqualToString:userInfo2.userName]) {
                    delTag = NO;
                    break;
                }
            }
            
            if (delTag && userInfo1.valueId > 0) {
                [[TRKeyValueRequest defaultTRKeyValueRequest] requestDelKey:[TRUserHelper getDeviceLoginRecordsKey]
                                                                    valueId:userInfo1.valueId
                                                                       flag:0
                                                                    timeOut:0
                                                                   userInfo:nil
                                                                   delegate:nil];
            }
        }
        
        //upd
        for (int i = 0; i < _userInfoList.count; i++) {
            
            BOOL updTag = NO;
            TRUserInfo *userInfo1 = [_userInfoList objectAtIndex:i];
            for (int j=0; j<_oldUserInfoList.count; j++) {
                TRUserInfo *userInfo2 = [_oldUserInfoList objectAtIndex:j];
                
                if ([userInfo1.userName isEqualToString:userInfo2.userName]) {
                    if (![userInfo1.password isEqualToString:userInfo2.password] || userInfo1.isKeepPassWord != userInfo2.isKeepPassWord) {
                        updTag = YES;
                    }
                    
                    if (i == 0 && j != 0) {
                        updTag = YES;
                    }
                    
                    if (updTag) {
                        userInfo1.valueId = userInfo2.valueId;
                        break;
                    }
                }
            }
            
            if (updTag) {
                [[TRKeyValueRequest defaultTRKeyValueRequest] requestUpdValue:[TRUserHelper getDeviceLoginRecordsKey]
                                                                      valueId:userInfo1.valueId
                                                                        value:[TRUserHelper getDeviceLoginRecordsValueByUserInfo:userInfo1]
                                                                         flag:1
                                                                      timeOut:0
                                                                     userInfo:nil
                                                                     delegate:nil];
                break;
            }
        }
    }
    _isUseOldGetUserList = NO;
}


/**
 *  更新 用户记录 显示数据
 *
 *  @param valueDataList 新数据
 */
- (void)resetByDeviceLoginRecordsValue:(NSArray *)valueDataList
{
    [_userInfoList removeAllObjects];
    [_oldUserInfoList removeAllObjects];
    
    for (TRValueData *valueData in valueDataList) {
        TRUserInfo *userInfo = [TRUserHelper getUserInfoByDeviceLoginRecordsValueData:valueData];
        if (userInfo) {
            [_userInfoList addObject:userInfo];
            TRUserInfo *_userInfo = [userInfo copy];
            [_oldUserInfoList addObject:_userInfo];
            [_userInfo release];
        }
    }
    
    if (_userInfoList.count > 0) {
        TRUserInfo *userInfo = [_userInfoList objectAtIndex:0];
        userNameField.text = userInfo.userName;
        
        isKeepPassWord = userInfo.isKeepPassWord;
        [self setIsKeepPassWordImage:isKeepPassWord];
        if (userInfo.isKeepPassWord) {
            passWordField.text = userInfo.password;
        }
        
        [recordUserNameButton setHidden:NO];
    }else {
        [recordUserNameButton setHidden:YES];
    }
    [userNameTableView reloadData];
    _isLoadedDeviceLoginRecords = YES;
    
}

#pragma  mark -  TRKeyValueRequestDelegate 回调 - 


/**
 * @description 请求失败回调（通信层）
 * @param errorCode: TRHTTPConnectionError
 * @param userInfo: 请求时的用户自定义数据
 */

-(void)didFailRequestKeyValueConnection:(TRKeyValueRequest *)tRCountRequest
                              errorCode:(TRHTTPConnectionError)errorCode
                               userInfo:(NSMutableDictionary *)userInfo
{
    [mbProgressHUD hide:YES];
    if (errorCode == -1) {
        //        PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:PP_ADDRESS message:@"网络超时，是否重新获取列表,取消获取缓存记录"];
        PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:PP_ADDRESS message:@"网络超时，是否重新获取账号列表？"];
        
        [alertView setCancelButtonTitle:@"确定" block:^{
            [[TRKeyValueRequest defaultTRKeyValueRequest] requestGetValue:[TRUserHelper getDeviceLoginRecordsKey]
                                                                     flag:0
                                                                  timeOut:5
                                                                 userInfo:nil
                                                                 delegate:self];
            [mbProgressHUD show:YES];
            mbProgressHUD.labelText = @"读取用户列表...";
        }];
        [alertView addButtonWithTitle:@"取消" block:^{
            //            NSArray *valueDataList = [self getLocalValueDataList];
            //            if (valueDataList) {
            //                NSLog(@"DEBUG:读取缓存！");
            //                [self resetByDeviceLoginRecordsValue:valueDataList];
            //            }
            
        }];
        [alertView show];
        [alertView release];
        
        return;
    }
    [PPCommon showConnectionErrorMessage:errorCode];
    
}

/**
 * @description 请求业务异常回调（业务层）
 * @param errorCode: SDKCountErrorCode
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didFailRequestKeyValue:(TRKeyValueRequest *)tRCountRequest
                    errorCode:(SDKKeyValueRequestErrorCode)errorCode
                     commmand:(SDKKeyValueRequestCommmand)commmand
                     userInfo:(NSMutableDictionary *)userInfo
{
    if (commmand == KeyValueRequestGetStamp || commmand == KeyValueRequestGetValue) {
        if (errorCode == SDKKeyValueRequestErrorDataNotExsits) {
            if (commmand == KeyValueRequestGetValue) {
                [self checkUserInfoList];
            }
            _isLoadedDeviceLoginRecords = YES;
        }
    }else if(commmand == KeyValueRequestAddKey){
        if (PP_ISNSLOG) {
            NSLog(@"didFailRequestKeyValue失败添加key");
        }
        
    }
    
}

/**
 * @description 请求新增key成功回调
 * @param valueId: valueId
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didSuccessRequestAddKey:(TRKeyValueRequest *)tRKeyValueRequest
                       valueId:(unsigned long long)valueId
                      userInfo:(NSMutableDictionary *)userInfo
{
    if (PP_ISNSLOG) {
        NSLog(@"didSuccessRequestAddKey成功了添加");
    }
    
}

/**
 * @description 请求取回value成功回调
 * @param keyId: keyId
 * @param key: key
 * @param valueDataList: valueDataList
 * @param lastModify: 最后修改时间
 * @param userInfo: 请求时的用户自定义数据
 */

-(void)didSuccessRequestGetValue:(TRKeyValueRequest *)tRKeyValueRequest
                           keyId:(unsigned long long)keyId
                             key:(NSData *)key
                   valueDataList:(NSArray *)valueDataList
                      lastModify:(unsigned int)lastModify
                        userInfo:(NSMutableDictionary *)userInfo
{
    if (PP_ISNSLOG) {
        NSLog(@"didSuccessRequestGetValue-keyid-%lld",keyId);
    }
    [mbProgressHUD hide:YES];
    NSMutableArray *softList = [NSMutableArray arrayWithArray:valueDataList];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lastModify" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [softList sortUsingDescriptors:sortDescriptors];
    
    
    
    BOOL tag  = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PP_DLRLM"]) {
        unsigned int deviceLoginRecordsLastModify = ([[[NSUserDefaults standardUserDefaults] objectForKey:@"PP_DLRLM"] unsignedIntValue]);
        if (deviceLoginRecordsLastModify == lastModify) {
            tag = NO;
        }
    }
    
    if (tag) {
        if (PP_ISNSLOG) {
            NSLog(@"DEBUG:写入缓存！");
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithUnsignedInt:lastModify] forKey:@"PP_DLRLM"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:softList] forKey:@"PP_DLR"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self performSelector:@selector(resetByDeviceLoginRecordsValue:) withObject:softList];
}


#pragma mark -  TRUserRequestDelegate 回调 -
/**
 * @description 请求验证TokenKey成功回调
 * @param userName: 用户名
 * @param userId: 用户表ID
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didSuccessRequestVerificationTokenKey:(TRUserRequest *)tRUserRequest
                                     userName:(NSString *)userName
                                       userId:(unsigned long long)userId
                                     userInfo:(NSMutableDictionary *)userInfo
{
    if (PP_ISNSLOG) {
        NSLog(@"请求验证TokenKey成功回调 == userName:%@",userName);
    }
}

/**
 * @description 请求登录成功回调
 * @param tokenKey: token_key
 * @param userId: 用户表ID
 * @param userName: 用户名
 * @param tmpUserName: 临时用户名
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didSuccessRequestLogin:(TRUserRequest *)tRUserRequest
                     tokenKey:(NSString *)tokenKey
                       userId:(unsigned long long)userId
                     userName:(NSString *)userName
                  tmpUserName:(NSString *)tmpUserName
                     userInfo:(NSMutableDictionary *)userInfo
{
    if (PP_ISNSLOG) {
        NSLog(@"登录成功回调");
    }
    //如果请求登录返回用户类型为游戏用户.则需要再次请求20分钟时效性的token
    if ([[userInfo objectForKey:@"userType_"] intValue] != 0) {
        NSData *password = nil;
        //判断是否自动登录【NO则没界面需要读取PP_P】
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"PP_A"]) {
            password = [[NSUserDefaults standardUserDefaults] objectForKey:@"PP_P"];
        }else{
            const char *password_ = [passWordField.text UTF8String];
            unsigned char passwordHash[32] = {0};
            sha256_memory((unsigned char*)password_, strlen(password_), passwordHash);
            password = [NSData dataWithBytes:passwordHash length:32];
        }

        [[TRUserRequest defaultTRUserRequest] requestLogin:userName password:password
                                                  userType:SDKUserTypeNormal userInfo:nil delegate:self];
    }
    
    //处理20分钟token登录验证方式,保存token在本地做邮件接口验证参数.其他方式保持不变
    if ([[userInfo objectForKey:@"userType_"] intValue] == 0) {

        [[PPAppPlatformKit sharedInstance] setCurrent20MinToken:tokenKey];
        [[PPAppPlatformKit sharedInstance] setCurrentUserId:userId];
//        [mbProgressHUD hide:YES];
        if (![[PPAppPlatformKit sharedInstance] isOneKeyLogin])
        {
            
            [[PPAppPlatformKit sharedInstance] setIsNeedBind:NO];
            [[PPAppPlatformKit sharedInstance] setCurrentUserName:userName];
            [[PPAppPlatformKit sharedInstance] setCurrentShowUserName:userName];
            
            
            
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"PP_A"]) {
                BOOL addTag = YES;
                
                for (TRUserInfo *userInfo_ in _userInfoList) {
                    if ([[userInfo_.userName lowercaseString] isEqualToString:[userNameField.text lowercaseString]]) {
                        [userInfo_ retain];
                        [_userInfoList removeObject:userInfo_];
                        [_userInfoList insertObject:userInfo_ atIndex:0];
                        [userInfo_ release];
                        addTag = NO;
                        break;
                    }
                }
                
                if (addTag) {
                    TRUserInfo *newUserInfo = [TRUserInfo defaultTRUserInfo];
                    newUserInfo.userName = userNameField.text;
                    [_userInfoList insertObject:newUserInfo atIndex:0];
                }
                TRUserInfo *newUserInfo = [_userInfoList objectAtIndex:0];
                newUserInfo.isKeepPassWord = isKeepPassWord;
                newUserInfo.password = passWordField.text;
                
                
                //PP_K为是否保存密码
                [[NSUserDefaults standardUserDefaults] setBool:newUserInfo.isKeepPassWord forKey:@"PP_K"];
                
                //为了修改密码发标识用的
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lld",newUserInfo.valueId] forKey:@"PP_V"];
                [[NSUserDefaults standardUserDefaults] setObject:userNameField.text forKey:@"PP_U"];
                const char *password_ = [passWordField.text UTF8String];
                unsigned char passwordHash[32] = {0};
                sha256_memory((unsigned char*)password_, strlen(password_), passwordHash);
                NSData *passWord = [NSData dataWithBytes:passwordHash length:32];
                
                [[NSUserDefaults standardUserDefaults] setObject:passWord forKey:@"PP_P"];
                if (isKeepAutoLogin)
                {
                    [[NSUserDefaults standardUserDefaults] setBool:isKeepAutoLogin forKey:@"PP_A"];
                }
                else
                {
                    [[NSUserDefaults standardUserDefaults] setBool:isKeepAutoLogin forKey:@"PP_A"];
                }
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        else
        {
            
            [[PPAppPlatformKit sharedInstance] setIsNeedBind:NO];
            [[PPAppPlatformKit sharedInstance] setCurrentUserName:userName];
            [[PPAppPlatformKit sharedInstance] setCurrentShowUserName:userName];
            if(tmpUserName && strlen([tmpUserName UTF8String]) > 0){
                [[PPAppPlatformKit sharedInstance] setCurrentUserName:tmpUserName];
            }
            
        }
        PPOnlineNet *net = [[PPOnlineNet alloc] init];
        [net ppAppOnlineHrateRequest:PP_REQUEST_USERID];
        [net release];
        
        
        char hexToKen[16];
        str_to_hex((char *)[tokenKey UTF8String], 32, (unsigned char *)hexToKen);
        
        [self hiddenLoginViewInRight];
        if ([[PPAppPlatformKit sharedInstance] delegate]) {
            if ([[[PPAppPlatformKit sharedInstance] delegate] respondsToSelector:@selector(ppLoginHexCallBack:)]) {
                [[[PPAppPlatformKit sharedInstance] delegate] ppLoginHexCallBack:hexToKen];
            }else{
                [[[PPAppPlatformKit sharedInstance] delegate] ppLoginStrCallBack:tokenKey];
            }
        }
    }
    
}

/**
 * @description 请求检查用户名是否存在成功回调（注意：该请求不会有“请求业务异常回调”）
 * @param userId: 用户表ID (0-无此用户 其他-userid)
 * @param isAlias: 是否临时用户
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didSuccessRequestCheckUserExist:(TRUserRequest *)tRUserRequest
                                userId:(unsigned long long)userId
                               isAlias:(BOOL)isAlias
                              userInfo:(NSMutableDictionary *)userInfo
{
    if (PP_ISNSLOG) {
        NSLog(@"一键登录检查用户名是否存在回调方法。");
        
    }
    if (userId <= 0) {
//        PPTempUserRegClauseAlertView *tempAlertView = [[PPTempUserRegClauseAlertView alloc] init];
//        [tempAlertView setDelegate:self];
//        [tempAlertView showModel];
//        [tempAlertView release];
    }else{
        if (isAlias == 1) {
            //如果是临时账号，就直接登录
            TRUserRequest *trUser = [[TRUserRequest alloc] init];
            
            const char *password_ = [passWordField.text UTF8String];
            unsigned char passwordHash[32] = {0};
            sha256_memory((unsigned char*)password_, strlen(password_), passwordHash);
            NSData *passWord = [NSData dataWithBytes:passwordHash length:32];
            
            [trUser requestLogin:[NSString stringWithUTF8String:[[PPAppPlatformKit sharedInstance] getTempLoginUserName]]
                        password:passWord
                        userType:SDKUserTypeGameTmp userInfo:nil delegate:self];
            [trUser release];
            
        }else{
            //如果是正常账号，就提示出错
//            [mbProgressHUD hide:YES];
            
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ADDRESS message:@"用户名不符合规则"];
            [alert setCancelButtonTitle:@"确定" block:^{

            }];
            [alert addButtonWithTitle:nil block:nil];
            [alert show];
            [alert release];
        }
    }
    
}

/**
 * @description 请求业务异常回调（业务层）
 * @param errorCode: SDKUserErrorCode
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didFailRequestUser:(TRUserRequest *)tRUserRequest
                errorCode:(SDKUserErrorCode)errorCode
                 userInfo:(NSMutableDictionary *)userInfo{
    
    ///******
    if (PP_ISNSLOG)
    {
        NSLog(@"登录失败回调");
    }
    [mbProgressHUD hide:YES];
    [PPCommon showMessage:errorCode];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"PP_A"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"PP_A"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setHidden:NO];
        [self showLoginViewByRight];
    }
    
}

/**
 * @description 请求失败回调（通信层）
 * @param errorCode: TRHTTPConnectionError
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didFailRequestUserConnection:(TRUserRequest *)tRUserRequest
                          errorCode:(TRHTTPConnectionError)errorCode
                           userInfo:(NSMutableDictionary *)userInfo{
    //处理网络通信错误
    if (PP_ISNSLOG)
    {
        NSLog(@"处理网络通信错误");
    }
    
    [PPCommon showMessage:errorCode];
    [mbProgressHUD hide:YES];
}


#pragma mark -  TRHTTPConnectionDelegate 回调 -
/**
 *  网络请求 链接失败
 *
 *  @param conn      链接
 *  @param errorCode 错误Code
 *  @param userInfo  用户信息
 */
-(void)didFailConnection:(TRHTTPConnection *)conn
               errorCode:(TRHTTPConnectionError)errorCode
                userInfo:(NSMutableDictionary *)userInfo
{
    [PPCommon showMessage:errorCode];
    [mbProgressHUD hide:YES];
}
/**
 *  网络请求 请求成功
 *
 *  @param conn     链接
 *  @param data     数据
 *  @param userInfo 用户信息
 */
-(void)didFinishConnection:(TRHTTPConnection *)conn
                      data:(NSData *)data
                  userInfo:(NSMutableDictionary *)userInfo
{
    
}


#pragma mark -  添加 ，删除 通知 -

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfoCallBack:)
                                                 name:PP_PHP_RESPONSE_GETUSERNAMELIST_NOTIFICATION object:nil];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PP_PHP_RESPONSE_GETUSERNAMELIST_NOTIFICATION object:nil];
}

#pragma mark  - UITextFieldDelegate -

//清空用户名文本框时，连带密码信息也清空
- (void) textFieldDidChange{
    [passWordField setText:@""];
}

- (void)textChange:(UITextField *)paramTextField
{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        if (paramTextField == userNameField)
        {
            [self rollupView:60];
        }
        else if (paramTextField == passWordField)
        {
            [self rollupView:90];
        }
    }
    else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        if (_bgImageView.frame.size.height <= 480)
        {
            [self rollupView:60];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == userNameField) {
        [passWordField becomeFirstResponder];
    }else if (textField == passWordField){
        [self loginButtonPressedown];
        [passWordField resignFirstResponder];
    }
    return YES;
}

// 当输入框获得焦点时，执行该方法。
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (userNameTableViewIsShow) {
        [self setTableViewUserHidden:YES];
    }
    if(_keyBoardIsShow)
    {
        [self textChange:textField];
    }
    
}

#pragma mark - 键盘通知事件 -

- (void)keyboardWillHideCallBack:(NSNotification *)noti
{
    [super keyboardWillHideCallBack:noti];
}

- (void)keyboardWillShowCallBack:(NSNotification *)noti
{
    [super keyboardWillShowCallBack:noti];
    if ([userNameField isFirstResponder]) {
        [self textChange:userNameField];
    }
    else if ([passWordField isFirstResponder])
    {
        [self textChange:passWordField];
    }
}

- (void)keyboardDidShowCallBack:(NSNotification *)noti{
    [super keyboardDidShowCallBack:noti];
}


#pragma mark - Dealloc -

- (void)dealloc
{
    if (PP_ISNSLOG) {
        NSLog(@"login dealloc");
    }

    [self removeNotification];
    [self checkAndUpdateUserInfo];
    [_oldUserInfoList release];
    _oldUserInfoList = nil;
    [_userInfoList release];
    _userInfoList = nil;
    [super dealloc];
}


#pragma mark - (过期方法) -


- (NSArray*)getLocalValueDataList
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"PP_DLR"];
    if (data && [data isKindOfClass:[NSData class]]) {
        NSArray *valueDataList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (valueDataList && [valueDataList isKindOfClass:[NSArray class]]) {
            return valueDataList;
        }
    }
    
    return nil;
}


/**
 *  请求超时
 */
-(void)getUserListOverTime{
    [mbProgressHUD setLabelText:@"请求超时"];
    [mbProgressHUD hide:YES afterDelay:2];
    //    [mbProgressHUD show:YES];
}
/**
 *  一键登录
 */
-(void)oneKeyLoginButtonPressedown{
    [userNameField resignFirstResponder];
    [passWordField resignFirstResponder];
    [[PPAppPlatformKit sharedInstance] setIsOneKeyLogin:YES];
    
    if (PP_ISNSLOG) {
        //        NSLog(@"一键登录-username-%s-password-%s--uuid-%@",
        //        [[PPAppPlatformKit sharedInstance] getTempLoginUserName],[[PPAppPlatformKit sharedInstance] getTempLoginPassWord],PP_REQUEST_UUID);
    }
    //    mbProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
    //    [mbProgressHUD setLabelText:@"请求登录..."];
    
    [[TRUserRequest defaultTRUserRequest] requestCheckUserExist:[NSString stringWithUTF8String:[[PPAppPlatformKit sharedInstance] getTempLoginUserName]]
                                                       userInfo:nil delegate:self];
}


- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

/**
 *  成功 获取到Push信息
 *
 *  @param paramMessageCount 信息条数
 *  @param paramPageCount    页数
 *  @param paramItemArray    数据
 */
- (void)didSuccessGetMessageCallBack:(int)paramMessageCount
                               Pages:(int)paramPageCount
                           ItemArray:(NSMutableArray *)paramItemArray
{
    if (PP_ISNSLOG) {
        NSLog(@"成功 获取到Push信息");
    }
}


/**
 *  点击注册
 *
 *  @param sender UIButton
 */
-(void)didClickButton:(UIButton *)sender{
    if ([sender tag] == 1) {
        TRUserRequest *trUser = [[TRUserRequest alloc] init];
        [trUser requestRegister:[NSString stringWithUTF8String:[[PPAppPlatformKit sharedInstance] getTempLoginUserName]]
                       password:[NSString stringWithUTF8String:[[PPAppPlatformKit sharedInstance] getTempLoginPassWord]]
                      isTmpUser:YES
                         source:[[PPAppPlatformKit sharedInstance] appId] userInfo:nil delegate:self];
        [trUser release];
        [mbProgressHUD hide:YES afterDelay:2];
    }else if ([sender tag] == 2) {
        [mbProgressHUD hide:YES];
    }
    
}

@end

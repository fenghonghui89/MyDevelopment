//
//  PPUpdatePassWordView.M
//  PPUserUIKit
//
//  Created by seven  mr on 1/24/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPUpdatePasswordView.h"
#import "PPAppPlatformKitConfig.h"
#import "PPCenterView.h"
#import "PPUserInfo.h"
#import "KeychainUtils.h"
#import "PPCommon.h"
#import "PPTextField.h"
#import "PPCommon.h"
#import "PPAlertView.h"
#import "TRUtil.h"


@implementation PPUpdatePasswordView

-(id)init{
    self = [super init];
    if (self) {
        
        [self.backButton setHidden:NO];
        
        [_titleLabel setText:@"修改密码"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleModifyPassword"]];

        
        confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmButton setTitle:@"确\t\t定" forState:UIControlStateNormal];
        [confirmButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(confirmButtonPressedown) forControlEvents:UIControlEventTouchUpInside];
        [[confirmButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
        
        [_bgImageView addSubview:confirmButton];
        
        userNameImageView = [[UIImageView alloc] init];
        [userNameImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:userNameImageView];
        [userNameImageView release];
        
        oldPassWordImageView = [[UIImageView alloc] init];
        [oldPassWordImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:oldPassWordImageView];
        [oldPassWordImageView release];
        
        passWordImageView = [[UIImageView alloc] init];
        [passWordImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:passWordImageView];
        [passWordImageView release];
        
        affirmPassWordImageView = [[UIImageView alloc] init];
        [affirmPassWordImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:affirmPassWordImageView];
        [affirmPassWordImageView release];
        
        userNameLabel = [[UILabel alloc] init];
        [userNameLabel setText:@"修改用户:"];
//        [userNameLabel setTextColor:[UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:100.0/255]];
        [userNameLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [userNameLabel setBackgroundColor:[UIColor clearColor]];
        [userNameImageView addSubview:userNameLabel];
        [userNameLabel release];
        
        userNameField = [[PPTextField alloc] init];
        [userNameField setDelegate:self];
        [userNameField setUserInteractionEnabled:NO];
        [userNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [userNameField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
        [userNameField setTextAlignment:NSTextAlignmentLeft];
        userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        [userNameImageView addSubview:userNameField];
        
        
        if ([[PPAppPlatformKit sharedInstance] isOneKeyLogin]) {
            if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
                [userNameField setText:[[PPAppPlatformKit sharedInstance] currentShowUserName]];
            }else{
                [userNameField setText:[[PPAppPlatformKit sharedInstance] currentShowUserName]];
            }
        }else{
            [userNameField setText:[[PPAppPlatformKit sharedInstance] currentShowUserName]];
        }
        [userNameField release];
        
        
        oldPassWordLabel = [[UILabel alloc] init];
        [oldPassWordLabel setText:@"当前密码:"];
//        [oldPassWordLabel setTextColor:[UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:100.0/255]];
        [oldPassWordLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [oldPassWordLabel setBackgroundColor:[UIColor clearColor]];
        [oldPassWordImageView addSubview:oldPassWordLabel];
        [oldPassWordLabel release];
        
        
        oldPassWordField = [[PPTextField alloc] init];
        [oldPassWordField setPlaceholder:@"6~20个(字母,数字)"];
        [oldPassWordField setSecureTextEntry:YES];
        [oldPassWordField setDelegate:self];
        [oldPassWordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [oldPassWordField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
        [oldPassWordField setTextAlignment:NSTextAlignmentLeft];
        [oldPassWordField setReturnKeyType:UIReturnKeyNext];
        oldPassWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [oldPassWordImageView addSubview:oldPassWordField];
        [oldPassWordField release];
        
        passWordLabel = [[UILabel alloc] init];
        [passWordLabel setText:@"设置密码:"];
//        [passWordLabel setTextColor:[UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:100.0/255]];
        [passWordLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [passWordLabel setBackgroundColor:[UIColor clearColor]];
        [passWordImageView addSubview:passWordLabel];
        [passWordLabel release];
        
        passWordField = [[PPTextField alloc] init];
        [passWordField setSecureTextEntry:YES];
        [passWordField setDelegate:self];
        [passWordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [passWordField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
        [passWordField setPlaceholder:@"6~20个(字母,数字)"];
        [passWordField setReturnKeyType:UIReturnKeyNext];
        //编辑时会出现个修改X
        [passWordField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [passWordField setTextAlignment:NSTextAlignmentLeft];
        [passWordImageView addSubview:passWordField];
        [passWordField release];
        
        affirmPassWordLabel = [[UILabel alloc] init];
        [affirmPassWordLabel setText:@"确认密码:"];
//        [affirmPassWordLabel setTextColor:[UIColor colorWithRed:200/255 green:200/255 blue:200/255 alpha:100.0/255]];
        [affirmPassWordLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [affirmPassWordLabel setBackgroundColor:[UIColor clearColor]];
        [affirmPassWordImageView addSubview:affirmPassWordLabel];
        [affirmPassWordLabel release];
        
        
        affirmPassWordField = [[PPTextField alloc] init];
        [affirmPassWordField setSecureTextEntry:YES];
        [affirmPassWordField setDelegate:self];
        [affirmPassWordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [affirmPassWordField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
        [affirmPassWordField setPlaceholder:@"6~20个(字母,数字)"];
        [affirmPassWordField setReturnKeyType:UIReturnKeySend];
        //编辑时会出现个修改X
        [affirmPassWordField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [affirmPassWordField setTextAlignment:NSTextAlignmentLeft];
        [affirmPassWordImageView addSubview:affirmPassWordField];
        [affirmPassWordField release];
        
        [confirmButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"]
                                           stretchableImageWithLeftCapWidth:10 topCapHeight:10]
                                 forState:UIControlStateNormal];
        
        [userNameImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"]
                                     stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        [oldPassWordImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]
                                        stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [passWordImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]
                                     stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [affirmPassWordImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxBottom"]
                                           stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        mbProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [mbProgressHUD hide:YES];
        [mbProgressHUD setLabelText:PP_MBPROGRESSHUDTEXT];
        
        [self initVerticalFrame];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}




//竖
-(void)initVerticalFrame
{
    [super initVerticalFrame];
    
    
    [userNameImageView setFrame:CGRectMake(0,85, _bgImageView.frame.size.width, 44)];
    [oldPassWordImageView setFrame:CGRectMake(0, userNameImageView.frame.origin.y + userNameImageView.frame.size.height,
                                              _bgImageView.frame.size.width, 44)];
    
    [passWordImageView setFrame:CGRectMake(0, oldPassWordImageView.frame.origin.y + oldPassWordImageView.frame.size.height,
                                           _bgImageView.frame.size.width, 44)];
    
    [affirmPassWordImageView setFrame:CGRectMake(0, passWordImageView.frame.origin.y + passWordImageView.frame.size.height,
                                                 _bgImageView.frame.size.width, 44)];
    [confirmButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, affirmPassWordImageView.frame.origin.y + affirmPassWordImageView.frame.size.height + 25,
                                       300, 44)];
    
    [userNameLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [oldPassWordLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [passWordLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [affirmPassWordLabel setFrame:CGRectMake(16, 0, 80, 44)];
    
    
    
    
    [userNameField setFrame:CGRectMake(userNameLabel.frame.size.width+16, 0,
                                       userNameImageView.frame.size.width - userNameLabel.frame.size.width, 44)];
    
    [oldPassWordField setFrame:CGRectMake(oldPassWordLabel.frame.size.width+16, 0,
                                          oldPassWordImageView.frame.size.width - oldPassWordLabel.frame.size.width - 10, 44)];
    
    [passWordField setFrame:CGRectMake(passWordLabel.frame.size.width+16, 0,
                                       passWordImageView.frame.size.width -  passWordLabel.frame.size.width  - 10, 44)];
    [affirmPassWordField setFrame:CGRectMake(passWordLabel.frame.size.width+16, 0,
                                             passWordImageView.frame.size.width -  affirmPassWordLabel.frame.size.width  - 10, 44)];
    
}


//横
-(void)initHorizontalFrame
{
    [super initHorizontalFrame];
    
    
    [userNameImageView setFrame:CGRectMake(0, 50+(320-44*5-50)/2, _bgImageView.frame.size.width, 44)];
    
    [oldPassWordImageView setFrame:CGRectMake(0, userNameImageView.frame.origin.y+userNameImageView.frame.size.height, _bgImageView.frame.size.width, 44)];
    
    [passWordImageView setFrame:CGRectMake(0, oldPassWordImageView.frame.origin.y+oldPassWordImageView.frame.size.height, _bgImageView.frame.size.width, 44)];
    
    [affirmPassWordImageView setFrame:CGRectMake(0, passWordImageView.frame.origin.y+passWordImageView.frame.size.height, _bgImageView.frame.size.width, 44)];
    
    [confirmButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, affirmPassWordImageView.frame.origin.y + affirmPassWordImageView.frame.size.height + 20,
                                       300, 44)];


    
    
    [userNameLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [oldPassWordLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [passWordLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [affirmPassWordLabel setFrame:CGRectMake(16, 0, 80, 44)];
    
    [userNameField setFrame:CGRectMake(userNameLabel.frame.size.width+16, 0,
                                       userNameImageView.frame.size.width - userNameLabel.frame.size.width, 44)];
    
    [oldPassWordField setFrame:CGRectMake(oldPassWordLabel.frame.size.width+16, 0,
                                          oldPassWordImageView.frame.size.width -  oldPassWordLabel.frame.size.width  - 10, 44)];
    
    [passWordField setFrame:CGRectMake(passWordLabel.frame.size.width+16, 0,
                                       passWordImageView.frame.size.width -  passWordLabel.frame.size.width  - 10, 44)];
    [affirmPassWordField setFrame:CGRectMake(passWordLabel.frame.size.width+16, 0,
                                             passWordImageView.frame.size.width -  affirmPassWordLabel.frame.size.width  - 10, 44)];
    
}



#pragma mark  -------------------------UITextField Delegate methods ------------------------------------




- (BOOL)textField:(UITextField *)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    if (field == oldPassWordField) {
        if ([characters isEqualToString:@" "]) {
            return NO;
        }
        return YES;
    }else{
        NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
    }
}


#pragma mark  -------------------------SELF UIBUTTON Pressed methods ------------------------------------
/**
 *确定按钮
 */
- (void)confirmButtonPressedown{
    NSString *message = @"";
    if ([userNameField text] == nil || ![[userNameField text] length])
    {
        message = @"用户名不能为空！";
    }
    else if([oldPassWordField text] == nil || ![[oldPassWordField text] length])
    {
        message = @"旧密码不能为空！";
    }
    else if([passWordField text] == nil || ![[passWordField text] length])
    {
        message = @"新密码不能为空！";
    }
    else if([affirmPassWordField text] == nil || ![[passWordField text] isEqualToString:[affirmPassWordField text]])
    {
        message = @"两次密码不相同！";
    }
    else if([[PPAppPlatformKit sharedInstance] currentUserName] == nil)
    {
        message = @"无当前用户，请重新登录";
    }
    else if ([[oldPassWordField text] isEqualToString:[passWordField text]])
    {
        message = @"原密码不得与新密码相同！";
    }
    else if ([[passWordField text] length] < 6 || [[passWordField text] length] > 20)
    {
        message = @"请输入6-20位的数字、字母作为密码！";
    }
    else if ([PPCommon isValidateUserName:[passWordField text]])
    {
        message = @"请输入6-20位的数字、字母作为密码！";
    }
    else{
        [self revertView];
        [PPUIKit clostKeyBoard];
        TRUserRequest *trUser = [[TRUserRequest alloc] init];
        const char *oldPassword_ = [oldPassWordField.text UTF8String];
        unsigned char oldPasswordHash[32] = {0};
        sha256_memory((unsigned char*)oldPassword_, strlen(oldPassword_), oldPasswordHash);
        NSData *oldPassWord = [NSData dataWithBytes:oldPasswordHash length:32];

        
        
        const char *password_ = [passWordField.text UTF8String];
        unsigned char passwordHash[32] = {0};
        sha256_memory((unsigned char*)password_, strlen(password_), passwordHash);
        NSData *newPassWord = [NSData dataWithBytes:passwordHash length:32];
        
        
        
        [trUser requestModifyPassword:[userNameField text] oldPassword:oldPassWord newPassword:newPassWord userInfo:nil delegate:self];
        [trUser release];
        [mbProgressHUD setLabelText:@"正在修改..."];
        [mbProgressHUD show:YES];
        return;
    }
    
    NSString *title = @"温馨提示";
	PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:message];
	[alertView setCancelButtonTitle:@"确定" block:^{
        
	}];
	[alertView addButtonWithTitle:nil block:nil];
	[alertView show];
    [alertView release];
    
}

-(void)backButtonPressed
{
    [self hiddenUpdatePassWordViewInRight];
    PPCenterView *ppCenterView = [[PPCenterView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppCenterView atIndex:1002];
    [ppCenterView showCenterViewByLeft];
    [ppCenterView release];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == oldPassWordField) {
        [passWordField becomeFirstResponder];
    }else if (textField == passWordField){
        [affirmPassWordField becomeFirstResponder];
    }else if (textField == affirmPassWordField){
        [self confirmButtonPressedown];
    }
    return YES;
}





#pragma mark  -------------------------SELF VIEW HIDDEN AND SHOW BY Orientation methods ------------------------------------
-(void)hiddenUpdatePassWordViewInRight
{
    [super hiddenViewInRight];
}

-(void)showUpdatePassWordViewByRight
{
    [userNameField setText:[[PPAppPlatformKit sharedInstance] currentShowUserName]];
    if ([userNameField text] == nil || ![[userNameField text] length]) {
        [userNameField setText:@"尚未登录"];
    }
    
    [super showViewByRight];
}


-(void)hiddenUpdatePassWordViewInLeft
{
    [super hiddenViewInLeft];
}

-(void)showUpdatePassWordViewByLeft
{
    [userNameField setText:[[PPAppPlatformKit sharedInstance] currentShowUserName]];
    if ([userNameField text] == nil || ![[userNameField text] length]) {
        [userNameField setText:@"尚未登录"];
    }
    
    [super showViewByLeft];
}

-(void)didHiddenView
{
    
    [super didHiddenView];
    [PPMBProgressHUD hideAllHUDsForView:self animated:YES];
}

-(void)didShowView{
    
}


-(void)closeButtonPressed{
    [super closeButtonPressed];
}

#pragma mark  ------------------------- NSNotification CallBackMethods ------------------------------------
-(void)didSuccessRequestModifyPassword:(TRUserRequest *)tRUserRequest userInfo:(NSMutableDictionary *)paramUserInfo{
    [mbProgressHUD hide:YES];
    [oldPassWordField resignFirstResponder];
    [passWordField resignFirstResponder];
    [affirmPassWordField resignFirstResponder];
    
	PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:[[PPAppPlatformKit sharedInstance] currentAddress] message:@"修改成功"];
	[alertView setCancelButtonTitle:@"确定" block:^{
        
        [self hiddenUpdatePassWordViewInRight];
	}];
	[alertView addButtonWithTitle:nil block:nil];
	[alertView show];
    [alertView release];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"PP_A"])
    {
        const char *password_ = [passWordField.text UTF8String];
        unsigned char passwordHash[32] = {0};
        sha256_memory((unsigned char*)password_, strlen(password_), passwordHash);
        NSData *password = [NSData dataWithBytes:passwordHash length:32] ;
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"PP_P"];
    }
    
    unsigned long long valueId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"PP_V"] longLongValue];
    TRUserInfo *updateUserInfo = [[TRUserInfo alloc] init];
    [updateUserInfo setUserName:[userNameField text]];
    [updateUserInfo setPassword:[passWordField text]];
    [updateUserInfo setValueId:valueId];
    [updateUserInfo setIsKeepPassWord:[[NSUserDefaults standardUserDefaults] boolForKey:@"PP_K"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[TRKeyValueRequest defaultTRKeyValueRequest] requestUpdValue:[TRUserHelper getDeviceLoginRecordsKey]
                                                          valueId:updateUserInfo.valueId
                                                            value:[TRUserHelper getDeviceLoginRecordsValueByUserInfo:updateUserInfo]
                                                             flag:1
                                                          timeOut:0
                                                         userInfo:nil
                                                         delegate:self];
    [updateUserInfo release];
    
}


-(void)didSuccessRequestUpdValue:(TRKeyValueRequest *)tRKeyValueRequest userInfo:(NSMutableDictionary *)userInfo{
    if (PP_ISNSLOG) {
        NSLog(@"修改成功");
    }
    
}
-(void)didFailRequestKeyValue:(TRKeyValueRequest *)tRCountRequest errorCode:(SDKKeyValueRequestErrorCode)errorCode commmand:(SDKKeyValueRequestCommmand)commmand userInfo:(NSMutableDictionary *)userInfo{
    if (PP_ISNSLOG) {
        NSLog(@"修改失败");
    }
}





-(void)didFailRequestUser:(TRUserRequest *)tRUserRequest errorCode:(SDKUserErrorCode)errorCode userInfo:(NSMutableDictionary *)userInfo{
    
    //针对测试部要求
    if (errorCode == SDKUserErrorPasswordError) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"旧密码错误!"];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        
    }else{
        [PPCommon showMessage:errorCode];
    }
    [mbProgressHUD hide:YES];
}


-(void)didFailRequestUserConnection:(TRUserRequest *)tRUserRequest errorCode:(TRHTTPConnectionError)errorCode userInfo:(NSMutableDictionary *)userInfo{
    [PPCommon showMessage:errorCode];
    [mbProgressHUD hide:YES];
}


-(void)keyboardWillHideCallBack:(NSNotification *)noti
{
    [super keyboardWillHideCallBack:noti];
    
}

-(void)keyboardWillShowCallBack:(NSNotification *)noti
{
    [super keyboardWillShowCallBack:noti];
    if ([oldPassWordField isFirstResponder]) {
        [self textChange:oldPassWordField];
    }
    if ([passWordField isFirstResponder]) {
        [self textChange:passWordField];
    }
    else if ([affirmPassWordField isFirstResponder])
    {
        [self textChange:affirmPassWordField];
    }
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(_keyBoardIsShow)
    {
        [self textChange:textField];
    }
}

- (void)textChange:(UITextField *)paramTextField
{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        if (paramTextField == oldPassWordField)
        {
            [self rollupView:50];
        }
        else if (paramTextField == passWordField)
        {
            [self rollupView:90];
        }
        else if (paramTextField == affirmPassWordField)
        {
            [self rollupView:160];
        }
        
    }
    else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        if (_bgImageView.frame.size.height <= 480)
        {
            [self rollupView:70];
        }
    }
}


@end

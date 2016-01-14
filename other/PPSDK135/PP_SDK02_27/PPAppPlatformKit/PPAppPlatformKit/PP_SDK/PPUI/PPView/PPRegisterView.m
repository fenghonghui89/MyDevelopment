//
//  PPRegisterView.m
//  PPUserUIKit
//
//  Created by seven  mr on 1/23/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPRegisterView.h"
#import "PPAppPlatformKitConfig.h"
#import "PPLoginView.h"
#import "PPUserInfo.h"
#import "KeychainUtils.h"
#import "PPCommon.h"
#import "PPLoginView.h"
#import "PPTextField.h"
#import "PPAlertView.h"



@implementation PPRegisterView

-(id)init{
    self = [super init];
    if (self) {
        
        
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleRegister"]];
        [self.backButton setHidden:NO];
        registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [registerButton setTitle:@"注 册" forState:UIControlStateNormal];
        [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[registerButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
        [registerButton addTarget:self action:@selector(registerButtonPressedown) forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:registerButton];
        
        
        if ([[PPAppPlatformKit sharedInstance] isOneKeyLogin]) {
            if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
                [_titleLabel setText:@"绑定正式会员"];
                [registerButton setTitle:@"绑\t\t定" forState:UIControlStateNormal];
            }
        }else{
            [_titleLabel setText:@"注册新会员"];
            [registerButton setTitle:@"注 册" forState:UIControlStateNormal];
        }
        
        
        userNameImageView = [[UIImageView alloc] init];
        [userNameImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:userNameImageView];
        [userNameImageView release];
        
        
        passWordImageView = [[UIImageView alloc] init];
        [passWordImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:passWordImageView];
        [passWordImageView release];
        
        
        affirmPassWordImageView = [[UIImageView alloc] init];
        [affirmPassWordImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:affirmPassWordImageView];
        [affirmPassWordImageView release];
        
        
        userNameLabel = [[UILabel alloc] init];
        [userNameLabel setText:@" 用  户  名 :"];
        [userNameLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [userNameLabel setBackgroundColor:[UIColor clearColor]];
        [userNameImageView addSubview:userNameLabel];
        [userNameLabel release];
        
        
        userNameField = [[PPTextField alloc] init];
        [userNameField setReturnKeyType:UIReturnKeyNext];
        [userNameField setDelegate:self];
        [userNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [userNameField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
//        [userNameField setTextAlignment:UITextAlignmentLeft];
        [userNameField addTarget:self action:@selector(textFieldDidChange)
                forControlEvents:UIControlEventEditingChanged];
        userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [userNameImageView addSubview:userNameField];
        [userNameField setPlaceholder:@"3~15个(字母,数字,中文)"];
        [userNameField release];
        
        
        passWordLabel = [[UILabel alloc] init];
        [passWordLabel setText:@" 输入密码 :"];
        [passWordLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [passWordLabel setBackgroundColor:[UIColor clearColor]];
        [passWordImageView addSubview:passWordLabel];
        [passWordLabel release];
        
        passWordField = [[PPTextField alloc] init];
        [passWordField setReturnKeyType:UIReturnKeyNext];
        [passWordField setSecureTextEntry:YES];
        [passWordField setDelegate:self];
        [passWordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [passWordField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
        //编辑时会出现个修改X
        [passWordField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [passWordField setTextAlignment:NSTextAlignmentLeft];
        [passWordField setPlaceholder:@"6-20个(字母,数字)"];
        [passWordImageView addSubview:passWordField];
        [passWordField release];
        
        affirmPassWordLabel = [[UILabel alloc] init];
        [affirmPassWordLabel setText:@" 确认密码 :"];
        [affirmPassWordLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [affirmPassWordLabel setBackgroundColor:[UIColor clearColor]];
        [affirmPassWordImageView addSubview:affirmPassWordLabel];
        [affirmPassWordLabel release];
        
        
        affirmPassWordField = [[PPTextField alloc] init];
        [affirmPassWordField setReturnKeyType:UIReturnKeySend];
        [affirmPassWordField setSecureTextEntry:YES];
        [affirmPassWordField setDelegate:self];
        [affirmPassWordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [affirmPassWordField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
        //编辑时会出现个修改X
        [affirmPassWordField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [affirmPassWordField setTextAlignment:NSTextAlignmentLeft];
        [affirmPassWordField setPlaceholder:@"6-20个(字母,数字)"];
        [affirmPassWordImageView addSubview:affirmPassWordField];
        [affirmPassWordField release];
        
        
//        [affirmPassWordImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxBottom"]
//                                           stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
//        [passWordImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]
//                                     stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
//        [userNameImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"]
//                                     stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
//        [registerButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPButton"]
//                                            stretchableImageWithLeftCapWidth:10 topCapHeight:10]
//                                  forState:UIControlStateNormal];
        

        
        [registerButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPLoginButtonNormal"]
                                         stretchableImageWithLeftCapWidth:5
                                         topCapHeight:5]
                               forState:UIControlStateNormal];
        [registerButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPLoginButtonPressed"]
                                         stretchableImageWithLeftCapWidth:5
                                         topCapHeight:5]
                               forState:UIControlStateHighlighted];
        
        
        [userNameImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"]
                                     stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        [passWordImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]
                                     stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [affirmPassWordImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxBottom"]
                                           stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        
        mbProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [mbProgressHUD hide:YES];
        
        
        [self initVerticalFrame];
    }
    return self;
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

//竖
-(void)initVerticalFrame
{
    [super initVerticalFrame];

    
    [userNameImageView setFrame:CGRectMake(0,85, _bgImageView.frame.size.width, 44)];

    
    [passWordImageView setFrame:CGRectMake(0, userNameImageView.frame.origin.y + userNameImageView.frame.size.height,
                                           _bgImageView.frame.size.width, 44)];
    
    [affirmPassWordImageView setFrame:CGRectMake(0, passWordImageView.frame.origin.y + passWordImageView.frame.size.height,
                                                 _bgImageView.frame.size.width, 44)];
    
    [registerButton setFrame:CGRectMake((_bgImageView.frame.size.width-300)/2, affirmPassWordImageView.frame.origin.y + affirmPassWordImageView.frame.size.height + 35, 300, 44)];
    
//    [userNameImageView setFrame:CGRectMake(20, _bgImageView.frame.size.height / 4, _bgImageView.frame.size.width - 40, 44)];
//    [passWordImageView setFrame:CGRectMake(20, userNameImageView.frame.origin.y + userNameImageView.frame.size.height,
//                                           _bgImageView.frame.size.width - 40, 44)];
//    
//    [affirmPassWordImageView setFrame:CGRectMake(20, passWordImageView.frame.origin.y + passWordImageView.frame.size.height,
//                                                 _bgImageView.frame.size.width - 40, 44)];
//    
//    [registerButton setFrame:CGRectMake(affirmPassWordImageView.frame.origin.x, affirmPassWordImageView.frame.origin.y + affirmPassWordImageView.frame.size.height + 20, passWordImageView.frame.size.width, 44)];
    
    
    [userNameLabel setFrame:CGRectMake(0, 0, 80, 44)];
    [passWordLabel setFrame:CGRectMake(0, 0, 80, 44)];
    [affirmPassWordLabel setFrame:CGRectMake(0, 0, 80, 44)];
    [userNameField setFrame:CGRectMake(userNameLabel.frame.size.width, 0,
                                       userNameImageView.frame.size.width - userNameLabel.frame.size.width, 44)];
    
    [passWordField setFrame:CGRectMake(passWordLabel.frame.size.width, 0,
                                       passWordImageView.frame.size.width -  passWordLabel.frame.size.width, 44)];
    [affirmPassWordField setFrame:CGRectMake(passWordLabel.frame.size.width, 0,
                                             passWordImageView.frame.size.width -  affirmPassWordLabel.frame.size.width, 44)];
    
}


//横
-(void)initHorizontalFrame
{
    [super initHorizontalFrame];

    [userNameImageView setFrame:CGRectMake(0,85, _bgImageView.frame.size.width, 44)];
    
    
    [passWordImageView setFrame:CGRectMake(0, userNameImageView.frame.origin.y + userNameImageView.frame.size.height,
                                           _bgImageView.frame.size.width, 44)];
    
    [affirmPassWordImageView setFrame:CGRectMake(0, passWordImageView.frame.origin.y + passWordImageView.frame.size.height,
                                                 _bgImageView.frame.size.width, 44)];
    
    [registerButton setFrame:CGRectMake((_bgImageView.frame.size.width-300)/2, affirmPassWordImageView.frame.origin.y + affirmPassWordImageView.frame.size.height + 35, 300, 44)];
    
    
    
    
    
    [userNameLabel setFrame:CGRectMake(0, 0, 80, 44)];
    [passWordLabel setFrame:CGRectMake(0, 0, 80, 44)];
    [affirmPassWordLabel setFrame:CGRectMake(0, 0, 80, 44)];
    
    
    
    
    [userNameField setFrame:CGRectMake(userNameLabel.frame.size.width, 0,
                                       userNameImageView.frame.size.width - userNameLabel.frame.size.width, 44)];
    
    [passWordField setFrame:CGRectMake(passWordLabel.frame.size.width, 0,
                                       passWordImageView.frame.size.width -  passWordLabel.frame.size.width, 44)];
    [affirmPassWordField setFrame:CGRectMake(passWordLabel.frame.size.width, 0,
                                             passWordImageView.frame.size.width -  affirmPassWordLabel.frame.size.width, 44)];
    
}

#pragma mark  - 注册 ，关闭视图，返回上一层  -

- (void)registerButtonPressedown{
    NSString *message = @"";
    NSString *title = @"温馨提示";
    
    if ([userNameField text] == nil || ![[userNameField text] length]) {
        message = @"用户名不能为空";
    }else if([passWordField text] == nil || ![[passWordField text] length]){
        message = @"密码不能为空！";
    }else if ([[passWordField text] length] < 6 || [[passWordField text] length] > 20) {
        message = @"请输入6-20位的数字、字母作为密码！";
    }else if([affirmPassWordField text] == nil || ![[passWordField text] isEqualToString:[affirmPassWordField text]]){
        message = @"两次密码不相同！";
    }else if ([PPCommon isValidateUserName:[userNameField text]]) {
        message = @"用户名不符合规则！";
    }else if ([PPCommon isValidateUserName:[passWordField text]]) {
        message = @"请输入6-20位的数字、字母作为密码！";
                              
    }else{
        if ([[PPAppPlatformKit sharedInstance] isOneKeyLogin]) {
            if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
                TRUserRequest *trUser = [[TRUserRequest alloc] init];
                [trUser requestBindAccount:[NSString stringWithUTF8String:[[PPAppPlatformKit sharedInstance] getTempLoginUserName]]
                           tmpUserPassword:[NSString stringWithUTF8String:[[PPAppPlatformKit sharedInstance] getTempLoginPassWord]]
                                  userName:[userNameField text]
                              userPassword:[passWordField text] userInfo:nil delegate:self];
                [trUser release];
                [mbProgressHUD show:YES];
                mbProgressHUD.labelText = @"正在绑定...";
            }else{
                TRUserRequest *trUser = [[TRUserRequest alloc] init];
                [trUser requestRegister:[userNameField text] password:[passWordField text] isTmpUser:NO
                                 source:[[PPAppPlatformKit sharedInstance] appId] userInfo:nil delegate:self];
                [trUser release];
                [mbProgressHUD show:YES];
                mbProgressHUD.labelText = @"正在注册...";
            }
        }else{
            TRUserRequest *trUser = [[TRUserRequest alloc] init];
            [trUser requestRegister:[userNameField text] password:[passWordField text] isTmpUser:NO
                             source:[[PPAppPlatformKit sharedInstance] appId] userInfo:nil delegate:self];
            [trUser release];
            [mbProgressHUD show:YES];
            mbProgressHUD.labelText = @"正在注册...";
        }
        return;
    }
    PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:message];
    [alertView setCancelButtonTitle:@"确定" block:^{

    }];
    [alertView addButtonWithTitle:nil block:nil];
    [alertView show];
    [alertView release];
    
}


-(void)backButtonPressed{
    if (PP_ISNSLOG) NSLog(@"注册");
    
    [super backButtonPressed];
    [self hiddenRegisterViewInRight];
    if ([[PPAppPlatformKit sharedInstance] isOneKeyLogin]) {
        if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
            PPCenterView *ppCenterView = [[PPCenterView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppCenterView atIndex:1002];
            [ppCenterView showCenterViewByLeft];
            [ppCenterView release];
            
            
        }else{
            PPLoginView *ppLoginView = [[PPLoginView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppLoginView atIndex:1002];
            [ppLoginView showLoginViewByLeft];
            [ppLoginView release];
        }
    }else{
        PPLoginView *ppLoginView = [[PPLoginView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppLoginView atIndex:1002];
        [ppLoginView showLoginViewByLeft];
        [ppLoginView release];
        

    }
}


-(void)closeButtonPressed{
    [super closeButtonPressed];
    [[[PPAppPlatformKit sharedInstance] delegate] ppClosePageViewCallBack:PPRegisterViewPageCode];
}


#pragma mark  - 视图显示，隐藏，消失 -

-(void)hiddenRegisterViewInRight
{
    [super hiddenViewInRight];
}

-(void)showRegisterViewByRight
{
//    [self randomMakeUserInfo];
    
    [super showViewByRight];
}


-(void)hiddenRegisterViewInLeft
{
    [super hiddenViewInLeft];
}

-(void)showRegisterViewByLeft
{
//    [self randomMakeUserInfo];
    
    [super showViewByLeft];
}

-(void)didHiddenView
{
    [PPMBProgressHUD hideAllHUDsForView:self animated:YES];
    [super didHiddenView];
}

#pragma mark - TRUserRequestDelegate - 
/**
 * @description 请求注册成功回调
 * @param userId: 用户表ID
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didSuccessRequestRegister:(TRUserRequest *)tRUserRequest
                          userId:(unsigned long long)userId
                        userInfo:(NSMutableDictionary *)userInfo{
    //发送注册统计请求
    PPOnlineNet *net = [[PPOnlineNet alloc] init];
    [net ppAppOnlineRegistRequest:userId];
    [net release];
    
    [mbProgressHUD setLabelText:@"正在登录..."];
    TRUserRequest *trUser = [[TRUserRequest alloc] init];
    
    const char *password_ = [passWordField.text UTF8String];
    unsigned char passwordHash[32] = {0};
    sha256_memory((unsigned char*)password_, strlen(password_), passwordHash);
    NSData *password = [NSData dataWithBytes:passwordHash length:32] ;
    
    [trUser requestLogin:[userNameField text] password:password userType:SDKUserTypeGame userInfo:nil delegate:self];
    [trUser release];
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
                     userInfo:(NSMutableDictionary *)userInfo{
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
        //记录当前登录用户信息
        [[PPAppPlatformKit sharedInstance] setCurrentUserId:userId];
        
        if([[PPAppPlatformKit sharedInstance] isOneKeyLogin]){
            [[PPAppPlatformKit sharedInstance] setCurrentUserName:tmpUserName];
            [[PPAppPlatformKit sharedInstance] setCurrentShowUserName:userName];
        }else{
            [[PPAppPlatformKit sharedInstance] setCurrentUserName:userName];
            [[PPAppPlatformKit sharedInstance] setCurrentShowUserName:userName];
            
            
            
            TRUserInfo *trUserInfo = [TRUserInfo defaultTRUserInfo];
            [trUserInfo setUserName:userName];
            [trUserInfo setPassword:[passWordField text]];
            [trUserInfo setIsKeepPassWord:YES];
            
            
            [[TRKeyValueRequest defaultTRKeyValueRequest] requestAddKey:[TRUserHelper getDeviceLoginRecordsKey]
                                                                  value:[TRUserHelper getDeviceLoginRecordsValueByUserInfo:trUserInfo]
                                                                   flag:0
                                                                timeOut:15
                                                               userInfo:nil
                                                               delegate:self];
            
            //注册用户登录按默认自动登录处理
            
            const char *password_ = [passWordField.text UTF8String];
            unsigned char passwordHash[32] = {0};
            sha256_memory((unsigned char*)password_, strlen(password_), passwordHash);
            NSData *password = [NSData dataWithBytes:passwordHash length:32] ;
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PP_A"];
            [[NSUserDefaults standardUserDefaults] setObject:userNameField.text forKey:@"PP_U"];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"PP_P"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"PP_K"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        [self hiddenRegisterViewInRight];
        
        
        char hexToKen[16];
        str_to_hex((char *)[tokenKey UTF8String], 32, (unsigned char *)hexToKen);
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
 * @description 请求业务异常回调（业务层）
 * @param errorCode: SDKUserErrorCode
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didFailRequestUser:(TRUserRequest *)tRUserRequest
                errorCode:(SDKUserErrorCode)errorCode
                 userInfo:(NSMutableDictionary *)userInfo{
    [PPCommon showMessage:errorCode];
    [mbProgressHUD hide:YES];
}


/**
 * @description 请求失败回调（通信层）
 * @param errorCode: TRHTTPConnectionError
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didFailRequestUserConnection:(TRUserRequest *)tRUserRequest
                          errorCode:(TRHTTPConnectionError)errorCode
                           userInfo:(NSMutableDictionary *)userInfo{
    [PPCommon showMessage:errorCode];
    [mbProgressHUD hide:YES];
}


#pragma mark -  TRKeyValueRequestDelegate -

/**
 * @description 请求新增key成功回调
 * @param valueId: valueId
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didSuccessRequestAddKey:(TRKeyValueRequest *)tRKeyValueRequest
                       valueId:(unsigned long long)valueId
                      userInfo:(NSMutableDictionary *)userInfo
{
    if (PP_ISNSLOG)
    {
        NSLog(@"注册时保存的value--%lld",valueId);
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lld",valueId] forKey:@"PP_V"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
    if (PP_ISNSLOG)
        NSLog(@"注册失败的keyvalue");
    [mbProgressHUD hide:YES];
}


/**
 * @description 请求失败回调（通信层）
 * @param errorCode: TRHTTPConnectionError
 * @param userInfo: 请求时的用户自定义数据
 */
- (void)didFailRequestKeyValueConnection:(TRKeyValueRequest*)tRCountRequest
                               errorCode:(TRHTTPConnectionError)errorCode
                                userInfo:(NSMutableDictionary*)userInfo

{

    if (PP_ISNSLOG) {
        NSLog(@"didFailRequestKeyValueConnection == TRKeyValueRequestDelegate 回调");
    }

}



#pragma mark  - UITextFieldDelegate -
- (void) textFieldDidChange{
    if (PP_ISNSLOG) {
        NSLog(@"textFieldDidChange");
    }
}


- (BOOL)textField:(UITextField *)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == userNameField) {
        [passWordField becomeFirstResponder];
    }else if (textField == passWordField){
        [affirmPassWordField becomeFirstResponder];
    }else if (textField == affirmPassWordField){
        [self registerButtonPressedown];
    }
    return YES;
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
        if (paramTextField == userNameField)
        {
            [self rollupView:60];
        }
        else if (paramTextField == passWordField)
        {
            [self rollupView:90];
        }
        else if (paramTextField == affirmPassWordField)
        {
            [self rollupView:120];
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
    else if ([affirmPassWordField isFirstResponder])
    {
        [self textChange:affirmPassWordField];
    }
}

- (void)keyboardDidShowCallBack:(NSNotification *)noti{
    [super keyboardDidShowCallBack:noti];
}
#pragma  mark - Dealloc -

- (void)dealloc
{
    [super dealloc];
}


#pragma mark - (过期方法) -
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSCharacterSet *cs;
//    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
//
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//
//    BOOL canChange = [string isEqualToString:filtered];
//
//    return canChange;
//}


/**
 * @description 请求绑定正式用户成功回调
 * @param userInfo: 请求时的用户自定义数据
 */
-(void)didSuccessRequestBindAccount:(TRUserRequest *)tRUserRequest
                           userInfo:(NSMutableDictionary *)userInfo
{
    [[PPAppPlatformKit sharedInstance] setIsOneKeyLogin:NO];
    [[PPAppPlatformKit sharedInstance] setCurrentShowUserName:[userNameField text]];
    [[PPAppPlatformKit sharedInstance] setIsNeedBind:NO];
    [mbProgressHUD setLabelText:@"绑定成功"];
    [mbProgressHUD hide:YES afterDelay:1];
    
    [self hiddenRegisterViewInRight];
}

/**
 *  TRHTTPConnectionDelegate 回调
 */
-(void)didFailRequestConnection:(TRUserRequest *)tRUserRequest
                      errorCode:(TRHTTPConnectionError)errorCode
                       userInfo:(NSMutableDictionary *)userInfo{
    [mbProgressHUD hide:YES];
    
    PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE
                                                        message:[NSString stringWithFormat:@"网络异常，错误编码%d",errorCode]];
    [alertView setCancelButtonTitle:@"确定" block:^{
        
    }];
    [alertView addButtonWithTitle:nil block:nil];
    [alertView show];
    [alertView release];
}

@end

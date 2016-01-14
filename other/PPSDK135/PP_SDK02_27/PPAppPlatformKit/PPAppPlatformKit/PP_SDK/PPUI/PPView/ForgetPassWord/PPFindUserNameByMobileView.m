//
//  PPFindUserNameByMobile.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-11.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPFindUserNameByMobileView.h"
#import "PPUIKit.h"
#import "PPCommon.h"
#import "PPForgetWhatView.h"
#import "PPFindPassWordByTypeView.h"

@implementation PPFindUserNameByMobileView



-(id)init{
    self = [super init];
    if (self) {
        
        [self.backButton setHidden:NO];
        
        
        [_titleLabel setText:@"通过手机找回账号"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleModifyPassword"]];
        
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [[_confirmButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
        [_confirmButton setTitle:@"确 定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_confirmButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        
        [_confirmButton addTarget:self action:@selector(confirmButtonPressedown) forControlEvents:UIControlEventTouchUpInside];
        
        [_bgImageView addSubview:_confirmButton];
        
        _mobileImageView = [[UIImageView alloc] init];
        [_mobileImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:_mobileImageView];
        [_mobileImageView release];
        
        
        
        
        _mobileLabel = [[UILabel alloc] init];
        [_mobileLabel setText:@"密保手机:"];
        [_mobileLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [_mobileLabel setBackgroundColor:[UIColor clearColor]];
        [_mobileImageView addSubview:_mobileLabel];
        [_mobileLabel release];
        
        _mobileTextField = [[UITextField alloc] init];
        [_mobileTextField setDelegate:self];
        [_mobileTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [_mobileTextField setPlaceholder:@"请输入绑定手机找回账号"];
        
        [_mobileTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_mobileTextField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
        [_mobileTextField setReturnKeyType:UIReturnKeySend];
        [_mobileTextField setTextAlignment:NSTextAlignmentLeft];
        _mobileTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_mobileImageView addSubview:_mobileTextField];
        [_mobileTextField release];
        

        
        [_mobileImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"]
                                      stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        mbProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [mbProgressHUD hide:YES];
        [mbProgressHUD setLabelText:PP_MBPROGRESSHUDTEXT];
        [self initVerticalFrame];
    }
    return self;
}


#pragma mark - 设备旋转 调整视图的位置和尺寸 -

//竖
-(void)initVerticalFrame
{
    [super initVerticalFrame];
    [_mobileImageView setFrame:CGRectMake(0, 85, _bgImageView.frame.size.width, 44)];
    [_confirmButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _mobileImageView.frame.origin.y + _mobileImageView.frame.size.height + 25,
                                        300, 44)];
    [_mobileLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [_mobileTextField setFrame:CGRectMake(_mobileLabel.frame.size.width + 10, 0,
                                        _mobileImageView.frame.size.width - _mobileLabel.frame.size.width - 10, 44)];
}


//横
-(void)initHorizontalFrame
{
    [super initHorizontalFrame];
    [_mobileImageView setFrame:CGRectMake(0, 75, _bgImageView.frame.size.width, 44)];
    [_confirmButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _mobileImageView.frame.origin.y + _mobileImageView.frame.size.height + 20,
                                        300, 44)];
    [_mobileLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [_mobileTextField setFrame:CGRectMake(_mobileLabel.frame.size.width + 10, 0,
                                        _mobileImageView.frame.size.width - _mobileLabel.frame.size.width - 10, 44)];
}

#pragma mark  - 手机找帐号 -
/**
 *确定按钮
 */
- (void)confirmButtonPressedown{
    [PPUIKit clostKeyBoard];
    [super revertView];
    NSString *message = @"";
    NSString *title = @"温馨提示";
    if(_mobileTextField.text == nil || ![_mobileTextField.text length]){
        message = @"电话不能为空！";

        PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:message];
        [alertView setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alertView addButtonWithTitle:nil block:nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    //设定正则表达式为11位数字
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]{11}$" options:0 error:nil];
    //进行匹配

    NSTextCheckingResult *result2 = [regex2 firstMatchInString:_mobileTextField.text options:0 range:NSMakeRange(0, [_mobileTextField.text length])];

    [mbProgressHUD setLabelText:@"正在发送信息..."];
    [mbProgressHUD show:YES];
    
    if (result2)//匹配成功
    {
        PPWebViewData *pp = [[PPWebViewData alloc] init];
        [pp setDelegate:self];
        NSString *sign = [pp makeSignMD5:findUserNameByPhone Username:nil Phone:_mobileTextField.text Phone_code:nil NewPwd:nil nextCode:nil Email:nil Question_1:QuestionNil Question_2:QuestionNil
                                Answer_1:nil Answer_2:nil NSTimeInterval:nil];
        [pp getFindUserNameByPhone:_mobileTextField.text Sign:sign];
        [pp release];
    }
    else
    {
        //匹配失败，让用户检查输入的正确性
        [mbProgressHUD hide:YES];
        PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:@"请输入已绑定的11位手机号码"];
        [alertView setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alertView addButtonWithTitle:nil block:nil];
        [alertView show];
        [alertView release];
    }
}

#pragma mark  - 手机找帐号手机找帐号的回调 -

-(void)findUserNameByPhoneCallBack:(NSDictionary *)paramDic
{
    [mbProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] intValue] == 0)//error＝0为正常，3、4为错误
    {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"信息已发送密保手机,即将跳转到登录界面"];
        [alert setCancelButtonTitle:@"确定" block:^{
            [self hiddenPPFindUserNameByMobileViewInLeft];
            PPLoginView *ppLoginView = [[PPLoginView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppLoginView atIndex:1000];
            [ppLoginView showLoginViewByRight];
            [ppLoginView release];
        }];
        [alert addButtonWithTitle:nil block:^{
            [_mobileTextField resignFirstResponder];
            [_mobileTextField setText:@""];
            
        }];
        [alert show];
        [alert release];
    }
    else
    {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:[paramDic objectForKey:@"msg"]];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
}


- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError;
{
    [mbProgressHUD setLabelText:@"通信失败，请检查网络"];
    [mbProgressHUD show:YES];
    [mbProgressHUD hide:YES afterDelay:2];
}
- (void)responseDidFailWithErrorCallBack{
    [mbProgressHUD setLabelText:@"通信失败，请检查网络"];
    [mbProgressHUD show:YES];
    [mbProgressHUD hide:YES afterDelay:2];
}

#pragma mark  - 视图显示，隐藏，消失 -

-(void)hiddenPPFindUserNameByMobileViewInRight
{
    [super hiddenViewInRight];
}

-(void)showPPFindUserNameByMobileViewByRight
{
    
    [super showViewByRight];
}


-(void)hiddenPPFindUserNameByMobileViewInLeft
{
    [super hiddenViewInLeft];
}

-(void)showPPFindUserNameByMobileViewByLeft
{
    [super showViewByLeft];
}

-(void)didHiddenView
{
    [PPMBProgressHUD hideAllHUDsForView:self animated:YES];
    [super didHiddenView];
}

-(void)didShowView{
    
}

#pragma mark  - 关闭视图，返回上一层 -

-(void)closeButtonPressed{
    [super closeButtonPressed];
}

-(void)backButtonPressed
{
    [self hiddenPPFindUserNameByMobileViewInRight];
    PPFindPassWordByTypeView *ppFindPassWordByTypeView = [[PPFindPassWordByTypeView alloc] init];
    [ppFindPassWordByTypeView setCurrUserName:@""];
    [ppFindPassWordByTypeView setForgetUserNameOrPass:YES];
    [[[UIApplication sharedApplication] keyWindow] addSubview:ppFindPassWordByTypeView];
    [ppFindPassWordByTypeView showPPFindPassWordByTypeViewByLeft];
    [ppFindPassWordByTypeView release];
}

#pragma mark  - UITextFieldDelegate -

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _mobileTextField) {
        [self confirmButtonPressedown];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _mobileTextField) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if ([string isEqualToString:@" "] || textField.text.length > 10) {
            return NO;
        }
        BOOL validate = [PPCommon validateNumeric:string];
        return validate;
    }
    else
    {
        NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        return ([string rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
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
        if (paramTextField == _mobileTextField)
        {
            [self rollupView:50];
        }
        
    }
    else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        if (_bgImageView.frame.size.height <= 480)
        {
        }
    }
}

#pragma mark - 键盘通知事件 -

-(void)keyboardWillHideCallBack:(NSNotification *)noti
{
    [super keyboardWillHideCallBack:noti];
    
}

-(void)keyboardWillShowCallBack:(NSNotification *)noti
{
    [super keyboardWillShowCallBack:noti];
    if ([_mobileTextField isFirstResponder]) {
        [self textChange:_mobileTextField];
    }
    
}

#pragma mark - Dealloc -

- (void)dealloc
{
    [super dealloc];
}


@end
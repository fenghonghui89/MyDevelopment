//
//  PPBoundToPhoneView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-11.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBoundToPhoneView.h"
#import "PPUIKit.h"
#import "PPCommon.h"
#import "PPPasswordProtectionView.h"
#import "PPUIKit.h"
#import "PPBoundToNextPhoneView.h"
#import "PPBoundToNextMailBoxView.h"
#import "PPSecretQuestionsView.h"


@implementation PPBoundToPhoneView

-(id)init
{
    self = [super init];
    if (self) {
        [self.backButton setHidden:NO];
        [_titleLabel setText:@"绑定手机"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleSecretQuestionSetting"]];
        
        
        
        boundToPhoneImageView = [[UIImageView alloc] init];
        [boundToPhoneImageView setUserInteractionEnabled:YES];
        [boundToPhoneImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:boundToPhoneImageView];
        [boundToPhoneImageView release];
        
        boundToPhoneLabel = [[UILabel alloc] init];
        [boundToPhoneLabel setFrame:CGRectMake(16, 0,100, 44)];
        [boundToPhoneLabel setBackgroundColor:[UIColor clearColor]];
        [boundToPhoneLabel setText:@"手机号码"];
        [boundToPhoneLabel setFont:[UIFont systemFontOfSize:15]];
        [boundToPhoneImageView addSubview:boundToPhoneLabel];
        [boundToPhoneLabel release];
        
        _phoneNumberTextfield = [[UITextField alloc] init];
        [_phoneNumberTextfield setReturnKeyType:UIReturnKeyNext];
        [_phoneNumberTextfield setDelegate:self];
        [_phoneNumberTextfield setKeyboardType:UIKeyboardTypeNumberPad];
        [_phoneNumberTextfield setPlaceholder:@"填写手机号码"];
        [_phoneNumberTextfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_phoneNumberTextfield setFont:[UIFont systemFontOfSize:15]];
        [_phoneNumberTextfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        [boundToPhoneImageView addSubview:_phoneNumberTextfield];
        [_phoneNumberTextfield release];
        
        getVerificationCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [getVerificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [getVerificationCodeButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [getVerificationCodeButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]
                                             forState:UIControlStateNormal];
        getVerificationCodeButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [getVerificationCodeButton addTarget:self action:@selector(getVerificationCodeButtonTouchUpInside)
                            forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:getVerificationCodeButton];
        
        
        verificationCodeImageView = [[UIImageView alloc] init];
        [verificationCodeImageView setUserInteractionEnabled:YES];
        [verificationCodeImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:verificationCodeImageView];
        [verificationCodeImageView release];
        
        verificationCodeLabel = [[UILabel alloc] init];
        [verificationCodeLabel setFrame:CGRectMake(16, 0,70, 44)];
        [verificationCodeLabel setBackgroundColor:[UIColor clearColor]];
        [verificationCodeLabel setText:@"验证码"];
        [verificationCodeLabel setFont:[UIFont systemFontOfSize:15]];
        [verificationCodeImageView addSubview:verificationCodeLabel];
        [verificationCodeLabel release];
        
        verificationCodeTextfield = [[UITextField alloc] init];
        [verificationCodeTextfield setDelegate:self];
        [verificationCodeTextfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        [verificationCodeTextfield setKeyboardType:UIKeyboardTypeASCIICapable];
        [verificationCodeTextfield setReturnKeyType:UIReturnKeySend];

        [verificationCodeTextfield setPlaceholder:@"填写您收到的验证码"];
        [verificationCodeTextfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [verificationCodeTextfield setFont:[UIFont systemFontOfSize:15]];
        [verificationCodeImageView addSubview:verificationCodeTextfield];
        [verificationCodeTextfield release];
        
        boundToPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [boundToPhoneButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [boundToPhoneButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        boundToPhoneButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [_bgImageView addSubview:boundToPhoneButton];
        [boundToPhoneButton addTarget:self action:@selector(boundToPhoneButtonTouchUpInside)
                     forControlEvents:UIControlEventTouchUpInside];
        
        _oldPhone = [[NSString alloc] init];
        
        ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [ppMBProgressHUD hide:YES];
        
        [self initVerticalFrame];

    }
    return self;
}


#pragma mark - 设备旋转 调整视图的位置和尺寸 -

- (void)initHorizontalFrame
{
    [super initHorizontalFrame];
   
    [boundToPhoneImageView setFrame:CGRectMake(0, 20 + 44 + 10, _bgImageView.frame.size.width, 44)];
    [verificationCodeImageView setFrame:CGRectMake(0, boundToPhoneImageView.frame.origin.y + 44 + 10,
                                                   _bgImageView.frame.size.width, 44)];
    [getVerificationCodeButton setFrame:CGRectMake(20, verificationCodeImageView.frame.origin.y + 44 + 10, 200, 44)];
    
    [boundToPhoneButton setFrame:CGRectMake(_bgImageView.frame.size.width - 220,
                                            verificationCodeImageView.frame.origin.y + 44 + 10, 200, 44)];

    [_phoneNumberTextfield setFrame:CGRectMake(120, 0, _bgImageView.frame.size.width - 120, 44)];
    [verificationCodeTextfield setFrame:CGRectMake(120, 0, _bgImageView.frame.size.width - 120, 44)];
    
//    [getVerificationCodeButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
//                                                   verificationCodeImageView.frame.origin.y + 44 + 10, 300, 44)];
//
//    [boundToPhoneButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
//                                            getVerificationCodeButton.frame.origin.y + 44 + 10, 300, 44)];

    
    
    
//    [oldBoundToPhoneImageView setFrame:CGRectMake(0, 70, _bgImageView.frame.size.width, 44)];
//    [boundToPhoneImageView setFrame:CGRectMake(0, oldBoundToPhoneImageView.frame.origin.y + 44 + 10, _bgImageView.frame.size.width, 44)];
//    [getVerificationCodeButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
//                                                   boundToPhoneImageView.frame.origin.y + 44 + 10, 300, 44)];
//    [verificationCodeImageView setFrame:CGRectMake(0, getVerificationCodeButton.frame.origin.y + 44 + 10,
//                                                   _bgImageView.frame.size.width, 44)];
//    [boundToPhoneButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
//                                            verificationCodeImageView.frame.origin.y + 44 + 10, 300, 44)];
}


- (void)initVerticalFrame
{
    [super initVerticalFrame];
    
    [boundToPhoneImageView setFrame:CGRectMake(0, 30 + 44 + 10, _bgImageView.frame.size.width, 44)];
    [getVerificationCodeButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                                   boundToPhoneImageView.frame.origin.y + 44 + 20, 300, 44)];
    [verificationCodeImageView setFrame:CGRectMake(0, getVerificationCodeButton.frame.origin.y + 44 + 35,
                                                   _bgImageView.frame.size.width, 44)];
    [boundToPhoneButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                            verificationCodeImageView.frame.origin.y + 44 + 20, 300, 44)];
    
    [_phoneNumberTextfield setFrame:CGRectMake(120, 0, 200, 44)];
    [verificationCodeTextfield setFrame:CGRectMake(120, 0, 200, 44)];
}



#pragma mark - 绑定，检查，验证，手机号

/**
 *验证=验证码
 */
- (void)getVerificationCodeButtonTouchUpInside
{
    UITextField *textField = nil;
    BOOL isPass = YES;
    NSString *errorMgs = nil;

    if ([self.isUpdate ? self.oldPhone:[_phoneNumberTextfield text] isEqualToString:@""] || [_phoneNumberTextfield text] == nil)
    {
        errorMgs = @"手机号码不能为空";
        isPass = NO;
        textField = _phoneNumberTextfield;
    }
    else if ([[_phoneNumberTextfield text] length] < 11)
    {
        errorMgs = @"你输入的手机号码长度不正确";
        isPass = NO;
        textField = _phoneNumberTextfield;
    }
    
    if (!isPass) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE
                                                        message:errorMgs];
        [alert setCancelButtonTitle:@"确定" block:^{
            [textField becomeFirstResponder];
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    else{
        NSString *phone = self.isUpdate ? self.oldPhone:[_phoneNumberTextfield text];
        PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
        [ppMBProgressHUD setLabelText:@"正在发送信息..."];
        [ppMBProgressHUD show:YES];
        [ppWebViewData setDelegate:self];
        [ppWebViewData getVerificationCode:phone];
        [ppWebViewData release];
    }
}

- (void)boundToPhoneButtonTouchUpInside
{
    UITextField *textField = nil;
    BOOL isPass = YES;
    NSString *errorMgs = nil;
 
    if ([[_phoneNumberTextfield text] isEqualToString:@""] || [_phoneNumberTextfield text] == nil)
    {
        errorMgs = @"旧手机号码不能为空";
        isPass = NO;
        textField = _phoneNumberTextfield;
    }
    else if ([[_phoneNumberTextfield text] length] < 11)
    {
        errorMgs = @"你输入的旧号码长度不正确";
        isPass = NO;
        textField = _phoneNumberTextfield;
    }
    else if ([[verificationCodeTextfield text] isEqualToString:@""] || [verificationCodeTextfield text] == nil)
    {
        errorMgs = @"验证码不能为空";
        isPass = NO;
        textField = verificationCodeTextfield;
    }
    else if ([[_phoneNumberTextfield text] length] < 11)
    {
        errorMgs = @"你输入的验证码长度不正确";
        isPass = NO;
        textField = verificationCodeTextfield;
    }
    
    if (!isPass) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE
                                                        message:errorMgs];
        [alert setCancelButtonTitle:@"确定" block:^{
            [textField becomeFirstResponder];
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        return;
    }
    else
    {
        [ppMBProgressHUD show:YES];
        [ppMBProgressHUD setLabelText:@"正在绑定..."];
        
        PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
        [ppWebViewData setDelegate:self];
        if (self.isUpdate)
        {
            [ppWebViewData getChkUserPhone:self.oldPhone Code:[verificationCodeTextfield text]];
        }
        else
        {
            [ppWebViewData getBindPhone:[_phoneNumberTextfield text] Code:[verificationCodeTextfield text] Nextcode:@""];
        }
        [ppWebViewData release];
    }
    
    
}

#pragma mark  - 视图显示，隐藏，消失 -

/// <summary>
/// 密保设置页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showBoundToPhoneViewByRight
{
    if (self.isUpdate)
    {
        [boundToPhoneButton setTitle:@"下一步" forState:UIControlStateNormal];
//        [_phoneNumberTextfield setText:self.oldPhone];
        [_phoneNumberTextfield setEnabled:NO];
        [_titleLabel setText:@"验证手机"];
    }
    else
    {
        [boundToPhoneButton setTitle:@"验证绑定手机" forState:UIControlStateNormal];
//        [_phoneNumberTextfield setText:@""];
        [_phoneNumberTextfield setEnabled:YES];
    }
    [super showViewByRight];
}


-(void)hiddenBoundToPhoneViewInRight
{
    if (self.isUpdate)
    {
        [boundToPhoneButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    else
    {
        [boundToPhoneButton setTitle:@"验证绑定手机" forState:UIControlStateNormal];
    }
    [super hiddenViewInRight];
}

-(void)hiddenBoundToPhoneViewInLeft
{
    if (self.isUpdate)
    {
        [boundToPhoneButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    else
    {
        [boundToPhoneButton setTitle:@"验证绑定手机" forState:UIControlStateNormal];
    }
    [super hiddenViewInLeft];
}

-(void)didHiddenView
{
    
    [super didHiddenView];
}

-(void)didShowView{
    
}

#pragma mark  - 关闭视图，返回上一层 -

-(void)backButtonPressed
{
    [self hiddenBoundToPhoneViewInRight];
    PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
    [ppPasswordProtectionView showPasswordProtectionViewByLeft];
    [ppPasswordProtectionView release];
}
#pragma mark - UITextFieldDelegate -

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField == _phoneNumberTextfield)
    {
        if (range.location > 10) {
            return NO;
        }
        return [PPCommon validateNumeric:string];

    }
    else if (textField == verificationCodeTextfield)
    {
        if (range.location > 4) {
            return NO;
        }
    }
    
    return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _phoneNumberTextfield)
    {
        [verificationCodeTextfield becomeFirstResponder];
    }
    else if (textField == verificationCodeTextfield)
    {
        [self boundToPhoneButtonTouchUpInside];
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
        [self rollupView:75];
    }
    else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        if (_bgImageView.frame.size.height <= 480)
        {
            [self rollupView:80];
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
    if ([_phoneNumberTextfield isFirstResponder])
    {
        [self textChange:_phoneNumberTextfield];
    }
    else if ([verificationCodeTextfield isFirstResponder])
    {
        [self textChange:verificationCodeTextfield];
    }
}

#pragma mark -  绑定，检查，验证，手机号回调 -

-(void)verificationCodeCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] intValue] != 0) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:[paramDic objectForKey:@"msg"]];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        return;
    }

    NSString *phone = [NSString stringWithFormat:@"%@******%@",[[_phoneNumberTextfield text] substringToIndex:3],
                 [[_phoneNumberTextfield text] substringFromIndex:9]];

    PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE
                                                    message:[NSString stringWithFormat:@"验证码已经发往您的手机号%@,10分钟内有效!",phone]];
    [alert setCancelButtonTitle:@"确定" block:^{
        
    }];
    [alert addButtonWithTitle:nil block:nil];
    [alert show];
    [alert release];
}

- (void)bindPhoneCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] intValue] == 0) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:[paramDic objectForKey:@"msg"]];
        [alert setCancelButtonTitle:@"确定" block:^{
            [self hiddenBoundToPhoneViewInRight];
            PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
            [ppPasswordProtectionView showPasswordProtectionViewByLeft];
            [ppPasswordProtectionView release];
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        return;

    }
    PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:[paramDic objectForKey:@"msg"]];
    [alert setCancelButtonTitle:@"确定" block:^{  
        
    }];
    [alert addButtonWithTitle:nil block:nil];
    [alert show];
    [alert release];
}

- (void)checkPhoneCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] intValue] != 0) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:[paramDic objectForKey:@"msg"]];
        [alert setCancelButtonTitle:@"确定" block:^{

        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        return;
    }
    [self hiddenBoundToPhoneViewInLeft];
    PPSecretQuestionsView *ppSecretQuestionsView = [[PPSecretQuestionsView alloc] init];
    PPBoundToNextMailBoxView *ppBoundToNextMailBoxView = [[PPBoundToNextMailBoxView alloc] init];
    PPBoundToNextPhoneView *ppBoundToNextPhoneView = [[PPBoundToNextPhoneView alloc] init];
    
    switch (_nextView) {
        case PPVerificationModeQuestion:
            

            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSecretQuestionsView atIndex:1002];
            [ppSecretQuestionsView setNextCode:[[paramDic objectForKey:@"data"] objectForKey:@"nextCode"]];
            [ppSecretQuestionsView showSecretQuestionsViewByRight];

            break;
        case PPVerificationModeMailBox:
            //                [PPBoundToNextMailBoxView sharedInstance];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToNextMailBoxView atIndex:1002];
            [ppBoundToNextMailBoxView setNextCode:[[paramDic objectForKey:@"data"] objectForKey:@"nextCode"]];
            [ppBoundToNextMailBoxView showBoundToNextMailBoxViewByRight];
            break;
        case PPVerificationModePhone:
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToNextPhoneView atIndex:1002];
            [ppBoundToNextPhoneView setNextCode:[[paramDic objectForKey:@"data"] objectForKey:@"nextCode"]];
            [ppBoundToNextPhoneView showBoundToNextPhoneViewByRight];
            break;
    }
    [ppSecretQuestionsView release];
    [ppBoundToNextMailBoxView release];
    [ppBoundToNextPhoneView release];
}

- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError{
    [ppMBProgressHUD setLabelText:@"网络异常,请尝试刷新"];
    [ppMBProgressHUD show:YES];
    NSString *string = [paramError localizedDescription];
    if (PP_ISNSLOG) {
        NSLog(@"ppHttpResponseDidFailWithErrorCallBack-%@",string);
    }
    [ppMBProgressHUD hide:YES afterDelay:2];
}

#pragma mark - dealloc -

-(void)dealloc{
    if (PPDEALLOC_ISNSLOG) {
        NSLog(@"PPBoundToPhoneView dealloc");
    }

    [_oldPhone release];
    _oldPhone = nil;
    
    [super dealloc];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

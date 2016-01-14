//
//  PPBoundToMailBoxView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-11.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBoundToMailBoxView.h"
#import "PPUIKit.h"
#import "PPCommon.h"
#import "PPPasswordProtectionView.h"
#import "PPUIKit.h"
#import "PPBoundToNextMailBoxView.h"
#import "PPBoundToNextPhoneView.h"
#import "PPSecretQuestionsView.h"


@implementation PPBoundToMailBoxView

-(id)init
{
    self = [super init];
    if (self) {
        
        _tableViewArray = [[NSMutableArray alloc] initWithObjects:@"@163.com",@"@qq.com",@"@sina.com",@"@126.com", nil];
        _allArray = [[NSMutableArray alloc] initWithObjects:@"@163.com",@"@qq.com",@"@sina.com",@"@126.com", nil];
        
        _tableView = [[UITableView alloc] init];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setShowsVerticalScrollIndicator:YES];
        [_tableView setShowsHorizontalScrollIndicator:YES];
        [_tableView setTag:noDisableVerticalScrollTag];
        [[_tableView layer] setBorderWidth:0.8];
        [[_tableView layer] setBorderColor:[[PPCommon getColor:@"c7c7c7"] CGColor]];
        [_tableView setSeparatorColor:[PPCommon getColor:@"e6e6e6"]];
        [_tableView flashScrollIndicators];
        
        
        [self.backButton setHidden:NO];
        [_titleLabel setText:@"绑定邮箱"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleSecretQuestionSetting"]];
        
   
                
        boundToMailBoxImageView = [[UIImageView alloc] init];
        [boundToMailBoxImageView setUserInteractionEnabled:YES];
        [boundToMailBoxImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:boundToMailBoxImageView];
        [boundToMailBoxImageView release];

        UILabel *boundToMailBoxLabel = [[UILabel alloc] init];
        [boundToMailBoxLabel setFrame:CGRectMake(16, 0,100, 44)];
        [boundToMailBoxLabel setBackgroundColor:[UIColor clearColor]];
        [boundToMailBoxLabel setText:@"密保邮箱"];
        [boundToMailBoxLabel setFont:[UIFont systemFontOfSize:15]];
        [boundToMailBoxImageView addSubview:boundToMailBoxLabel];
        [boundToMailBoxLabel release];

        _boundToMailBoxTextfield = [[UITextField alloc] init];
        [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeyNext];
        [_boundToMailBoxTextfield setDelegate:self];
        [_boundToMailBoxTextfield addTarget:self action:@selector(textFieldDidChange:)
                           forControlEvents:UIControlEventEditingChanged];
        [_boundToMailBoxTextfield setKeyboardType:UIKeyboardTypeEmailAddress];
        [_boundToMailBoxTextfield setPlaceholder:@"填写密保邮箱"];
        [_boundToMailBoxTextfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_boundToMailBoxTextfield setFont:[UIFont systemFontOfSize:15]];
        [_boundToMailBoxTextfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        [boundToMailBoxImageView addSubview:_boundToMailBoxTextfield];
        [_boundToMailBoxTextfield release];

        _boundGetCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_boundGetCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_boundGetCodeButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_boundGetCodeButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]
                                       forState:UIControlStateNormal];
        _boundGetCodeButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [_boundGetCodeButton addTarget:self action:@selector(boundGetCodeButtonTouchUpInside)
                      forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:_boundGetCodeButton];


        _boundCodeImageView = [[UIImageView alloc] init];
        [_boundCodeImageView setUserInteractionEnabled:YES];
        [_boundCodeImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:_boundCodeImageView];
        [_boundCodeImageView release];

        UILabel *boundCodeLabel = [[UILabel alloc] init];
        [boundCodeLabel setFrame:CGRectMake(16, 0,70, 44)];
        [boundCodeLabel setBackgroundColor:[UIColor clearColor]];
        [boundCodeLabel setText:@"验证码"];
        [boundCodeLabel setFont:[UIFont systemFontOfSize:15]];
        [_boundCodeImageView addSubview:boundCodeLabel];
        [boundCodeLabel release];

        _boundCodeTextfield = [[UITextField alloc] init];
        [_boundCodeTextfield setDelegate:self];
        [_boundCodeTextfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_boundCodeTextfield setKeyboardType:UIKeyboardTypeASCIICapable];
        [_boundCodeTextfield setReturnKeyType:UIReturnKeySend];

        [_boundCodeTextfield setPlaceholder:@"填写您收到的验证码"];
        [_boundCodeTextfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_boundCodeTextfield setFont:[UIFont systemFontOfSize:15]];
        [_boundCodeImageView addSubview:_boundCodeTextfield];
        [_boundCodeTextfield release];

        boundToMailBoxButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [boundToMailBoxButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [boundToMailBoxButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]
                                        forState:UIControlStateNormal];
        boundToMailBoxButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [_bgImageView addSubview:boundToMailBoxButton];
        [boundToMailBoxButton addTarget:self action:@selector(boundToMailBoxButtonTouchUpInside)
                       forControlEvents:UIControlEventTouchUpInside];
        [self initVerticalFrame];
        
        [_bgImageView addSubview:_tableView];
        [_tableView setHidden:YES];
        [_tableView release];
        
        ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [ppMBProgressHUD hide:YES];
    }
    return self;
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

- (void)initHorizontalFrame
{
    [super initHorizontalFrame];
    if (!self.isUpdate) {
        [_boundCodeImageView setClipsToBounds:YES];

        [boundToMailBoxImageView setFrame:CGRectMake(0, 20 + 44 + 10, _bgImageView.frame.size.width, 44)];
        [_boundGetCodeButton setFrame:CGRectMake(20, _boundCodeImageView.frame.origin.y + 44 + 10, 200, 0)];
        

        
        [_boundToMailBoxTextfield setFrame:CGRectMake(120, 0, _bgImageView.frame.size.width - 120, 44)];
        [_boundCodeTextfield setFrame:CGRectMake(120, 0, _bgImageView.frame.size.width - 120, 0)];
        [boundToMailBoxButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, boundToMailBoxImageView.frame.origin.y + 60, 300, 44)];
    }else{
        [boundToMailBoxImageView setFrame:CGRectMake(0, 20 + 44 + 10, _bgImageView.frame.size.width, 44)];
        [_boundCodeImageView setFrame:CGRectMake(0, boundToMailBoxImageView.frame.origin.y + 44 + 10,
                                                 _bgImageView.frame.size.width, 44)];
        [_boundGetCodeButton setFrame:CGRectMake(20, _boundCodeImageView.frame.origin.y + 44 + 10, 200, 44)];
        
        [boundToMailBoxButton setFrame:CGRectMake(_bgImageView.frame.size.width - 220,
                                                  _boundCodeImageView.frame.origin.y + 44 + 10, 200, 44)];
        
        [_boundToMailBoxTextfield setFrame:CGRectMake(120, 0, _bgImageView.frame.size.width - 120, 44)];
        [_boundCodeTextfield setFrame:CGRectMake(120, 0, _bgImageView.frame.size.width - 120, 44)];
    }
    
    [_tableView setFrame:CGRectMake(0, boundToMailBoxImageView.frame.size.height + boundToMailBoxImageView.frame.origin.y - 3,
                                    _bgImageView.frame.size.width, 150)];
 
}


- (void)initVerticalFrame
{
    [super initVerticalFrame];
    if (!self.isUpdate) {
        [_boundCodeImageView setClipsToBounds:YES];
        [boundToMailBoxImageView setFrame:CGRectMake(0, 30 + 44 + 10, _bgImageView.frame.size.width, 44)];
        [_boundCodeImageView setFrame:CGRectMake(0, _boundGetCodeButton.frame.origin.y + 44 + 35,
                                                 _bgImageView.frame.size.width, 0)];
        [_boundToMailBoxTextfield setFrame:CGRectMake(120, 0, 200, 44)];
        [_boundCodeTextfield setFrame:CGRectMake(120, 0, 200, 0)];
        
        [boundToMailBoxButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, boundToMailBoxImageView.frame.origin.y + 60, 300, 44)];
    }
    else
    {
        [boundToMailBoxImageView setFrame:CGRectMake(0, 30 + 44 + 10, _bgImageView.frame.size.width, 44)];
        [_boundGetCodeButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                                 boundToMailBoxImageView.frame.origin.y + 44 + 20, 300, 44)];
        [_boundCodeImageView setFrame:CGRectMake(0, _boundGetCodeButton.frame.origin.y + 44 + 35,
                                                 _bgImageView.frame.size.width, 44)];
        [boundToMailBoxButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                                  _boundCodeImageView.frame.origin.y + 44 + 20, 300, 44)];
        [_boundToMailBoxTextfield setFrame:CGRectMake(120, 0, 200, 44)];
        [_boundCodeTextfield setFrame:CGRectMake(120, 0, 200, 44)];
    }
    [_tableView setFrame:CGRectMake(0, boundToMailBoxImageView.frame.size.height + boundToMailBoxImageView.frame.origin.y - 3,
                                    _bgImageView.frame.size.width, 150)];
}

#pragma mark - 发送邮件验证邮箱 ,绑定邮箱,检查邮箱 -

-(void)boundGetCodeButtonTouchUpInside{
    [ppMBProgressHUD show:YES];
    [ppMBProgressHUD setLabelText:@"正在发送邮件..."];
    PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
    [ppWebViewData setDelegate:self];
    [ppWebViewData getEmailCode:_oldEmail];
    [ppWebViewData release];
}

- (void)boundToMailBoxButtonTouchUpInside
{
    [super revertView];
    [PPUIKit clostKeyBoard];
    [_tableView setHidden:YES];
    UITextField *textField = nil;
    BOOL isPass = YES;
    NSString *errorMgs = nil;
    if ([self.isUpdate ? self.oldEmail:[_boundToMailBoxTextfield text] isEqualToString:@""] || [_boundToMailBoxTextfield text] == nil)
    {
        errorMgs = @"邮箱不能为空";
        isPass = NO;
        textField = _boundToMailBoxTextfield;
    }
    if (self.isUpdate) {
        if ([[_boundCodeTextfield text] isEqualToString:@""] || [_boundCodeTextfield text] == nil)
        {
            errorMgs = @"验证码不能为空";
            isPass = NO;
            textField = _boundToMailBoxTextfield;
        }
    }
    if (!isPass) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE
                                                        message:errorMgs];
        [alert setCancelButtonTitle:@"确定" block:^{
            [textField becomeFirstResponder];
            [ppMBProgressHUD hide:YES];
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        return;
    }
    PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
    [ppWebViewData setDelegate:self];
    [ppMBProgressHUD show:YES];
    if (self.isUpdate) {
        [ppMBProgressHUD setLabelText:@"正在验证信息..."];
        
        [ppWebViewData getChkUserEmail:_oldEmail Email_Code:[_boundCodeTextfield text]];
    }
    else{
        [ppMBProgressHUD setLabelText:@"正在绑定邮箱..."];
        [ppWebViewData getBindEmail:[_boundToMailBoxTextfield text] Nextcode:@""];

    }
    [ppWebViewData release];
}

#pragma mark  - 视图显示，隐藏，消失 -
/// <summary>
/// 密保设置页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showBoundToMailBoxViewByRight
{
    [boundToMailBoxButton setTitle:self.isUpdate ? @"下一步" : @"发送验证邮箱"
                          forState:UIControlStateNormal];
    _boundToMailBoxTextfield.enabled = !self.isUpdate;
    self.isUpdate ? [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeyNext] : [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeySend];
    if (self.isUpdate) {
        [_titleLabel setText:@"验证邮箱"];
    }
    
    [_boundGetCodeButton setHidden:self.isUpdate ? NO : YES];
    [super showViewByRight];
}

-(void)showBoundToMailBoxViewByLeft
{
    [boundToMailBoxButton setTitle:self.isUpdate ? @"下一步" : @"发送验证邮箱"
                          forState:UIControlStateNormal];
    _boundToMailBoxTextfield.enabled = !self.isUpdate;
    [_boundGetCodeButton setHidden:self.isUpdate ? NO : YES];
    if (self.isUpdate) {
        [_titleLabel setText:@"验证邮箱"];
    }
    self.isUpdate ? [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeyNext] : [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeySend];
    
    
    [super showViewByRight];
}


-(void)hiddenBoundToMailBoxViewInRight
{
    [boundToMailBoxButton setTitle:self.isUpdate ? @"下一步" : @"发送验证邮箱"
                          forState:UIControlStateNormal];
    self.isUpdate ? [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeyNext] : [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeySend];
    [super hiddenViewInRight];
}
- (void)hiddenBoundToMailBoxViewInLeft
{
    [boundToMailBoxButton setTitle:self.isUpdate ? @"下一步" : @"发送验证邮箱"
                          forState:UIControlStateNormal];
    self.isUpdate ? [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeyNext] : [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeySend];
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
    [self hiddenBoundToMailBoxViewInRight];
    PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
    [ppPasswordProtectionView showPasswordProtectionViewByLeft];
    [ppPasswordProtectionView release];
    
}

#pragma mark  - UITableViewDataSource ， UITableViewDelegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [NSString stringWithFormat:@"%@%@",[_boundToMailBoxTextfield text],[_tableViewArray objectAtIndex:[indexPath row]]];
    [_boundToMailBoxTextfield setText:str];
    [tableView setHidden:YES];
    [boundToMailBoxButton setHidden:NO];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"CELLd";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] autorelease];
    }
    [[cell textLabel] setFrame:CGRectMake(80, 0, 320, [cell textLabel].frame.size.height)];
    [[cell textLabel] setFont:[UIFont systemFontOfSize:13]];

    NSString *str = [NSString stringWithFormat:@"%@%@",[_boundToMailBoxTextfield text],[_tableViewArray objectAtIndex:[indexPath row]]];
    [[cell textLabel ] setText:str];
    return cell;
}



-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        [_tableView setFrame:CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, 30 * [_tableViewArray count])];
        
    }
    else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        [_tableView setFrame:CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, 30 * [_tableViewArray count])];
    }
    if ([_tableViewArray count] <= 0) {
        [boundToMailBoxButton setHidden:NO];
    }
    return [_tableViewArray count];
}

#pragma mark - 键盘通知事件 -

- (void)keyboardWillHideCallBack:(NSNotification *)noti
{
    [super keyboardWillHideCallBack:noti];
}

- (void)keyboardWillShowCallBack:(NSNotification *)noti
{
    [super keyboardWillShowCallBack:noti];
    if ([_boundToMailBoxTextfield isFirstResponder])
    {
        [self textChange:_boundToMailBoxTextfield];
    }
    else if ([_boundCodeTextfield isFirstResponder])
    {
        [self textChange:_boundCodeTextfield];
    }
}

#pragma mark -  UITextFieldDelegate -


- (void)textFieldDidChange:(UITextField *) textField
{
    [boundToMailBoxButton setHidden:YES];
    [_tableView setHidden:NO];
    if ([[textField text] length] <= 0) {
        [boundToMailBoxButton setHidden:NO];
        [_tableView setHidden:YES];
    }else{
        [_tableViewArray removeAllObjects];
        NSRange range = [[textField text] rangeOfString:@"@"];
        if (range.location != NSNotFound) {
            NSString *tempStr = [[textField text] substringFromIndex:range.location];
            for (int i = 0 ; i < [_allArray count]; i++) {
                BOOL result = [[_allArray objectAtIndex:i] hasPrefix:tempStr];
                if (result) {
                    [_tableViewArray addObject:[[_allArray objectAtIndex:i] substringFromIndex: tempStr.length]];
                }
            }
        }
        else
        {
            [_tableViewArray addObjectsFromArray:_allArray];
            
        }
        [_tableView reloadData];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [boundToMailBoxButton setHidden:NO];
    if (textField == _boundToMailBoxTextfield)
    {
        [self boundToMailBoxButtonTouchUpInside];
        
    }
    else if (textField == _boundCodeTextfield)
    {
        [textField becomeFirstResponder];
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
        if (paramTextField == _boundToMailBoxTextfield)
        {
            [self rollupView:50];
        }
        else if (paramTextField == _boundCodeTextfield)
        {
            [self rollupView:75];
        }
    }
    else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        if (_bgImageView.frame.size.height <= 480)
        {
            [self rollupView:80];
        }
    }
}


#pragma mark - 绑定邮箱,验证邮箱 的  回调 -

- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError
{
    [ppMBProgressHUD setLabelText:@"网络异常,请尝试刷新"];
    [ppMBProgressHUD show:YES];
    NSString *string = [paramError localizedDescription];
    if (PP_ISNSLOG) {
        NSLog(@"ppHttpResponseDidFailWithErrorCallBack-%@",string);
    }
    [ppMBProgressHUD hide:YES afterDelay:2];
}
//检查邮箱
- (void)verificationEmailCodeCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] intValue] == 0) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:[paramDic objectForKey:@"msg"]];
        
        if ([[paramDic objectForKey:@"data"] objectForKey:@"address"] == [NSNull null]) {
            [alert setCancelButtonTitle:@"确定" block:^{
                [self hiddenBoundToMailBoxViewInRight];
                PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
                [ppPasswordProtectionView showPasswordProtectionViewByLeft];
                [ppPasswordProtectionView release];
            }];
            
        }
        else
        {
            [alert setCancelButtonTitle:@"立即查看" block:^{
                
//                if ([[[paramDic objectForKey:@"data"] objectForKey:@"address"] isEqualToString:@"https://mail.qq.com"]) {
//                    PPWebView *ppWebView = [[PPWebView alloc] init];
//                    [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
//                    [ppWebView goToAddress:[[paramDic objectForKey:@"data"] objectForKey:@"address"]];
//                    [[ppWebView backButton] setHidden:YES];
//                    [[ppWebView verticalLineLeftView] setHidden:YES];
//                    [ppWebView release];
//                }
//                else
//                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[paramDic objectForKey:@"data"] objectForKey:@"address"]]];
//                }
            }];
        }
        [alert addButtonWithTitle:@"取消" block:^{
            
        }];
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
//绑定邮箱
- (void)bindEmailCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] intValue] == 0) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:[paramDic objectForKey:@"msg"]];
        
        if ([[paramDic objectForKey:@"data"] objectForKey:@"address"] == [NSNull null]) {
            [alert setCancelButtonTitle:@"确定" block:^{
                [self hiddenBoundToMailBoxViewInRight];
                PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
                [ppPasswordProtectionView showPasswordProtectionViewByLeft];
                [ppPasswordProtectionView release];
            }];
            
        }
        else
        {
            [alert setCancelButtonTitle:@"立即验证" block:^{
                
//                if ([[[paramDic objectForKey:@"data"] objectForKey:@"address"] isEqualToString:@"https://mail.qq.com"]) {
//                    PPWebView *ppWebView = [[PPWebView alloc] init];
//                    [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
//                    [ppWebView goToAddress:[[paramDic objectForKey:@"data"] objectForKey:@"address"]];
//                    [[ppWebView backButton] setHidden:YES];
//                    [[ppWebView verticalLineLeftView] setHidden:YES];
//                    [ppWebView release];
//                }
//                else
//                {
                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[paramDic objectForKey:@"data"] objectForKey:@"address"]]];
//                }
                
            }];
            
        }
        [alert addButtonWithTitle:@"取消" block:^{
            
        }];
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
//验证邮箱
- (void)chkUserEmailCodeCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] intValue] == 0) {
        [self hiddenBoundToMailBoxViewInLeft];
        PPSecretQuestionsView *ppSecretQuestionsView = [[PPSecretQuestionsView alloc] init];
        PPBoundToNextMailBoxView *ppBoundToNextMailBoxView = [[PPBoundToNextMailBoxView alloc] init];
        PPBoundToNextPhoneView *ppBoundToNextPhoneView = [[PPBoundToNextPhoneView alloc] init];
        switch (_nextView) {
            case PPVerificationModeQuestion:

                
                [ppSecretQuestionsView setNextCode:[[paramDic objectForKey:@"data"] objectForKey:@"nextCode"]];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSecretQuestionsView atIndex:1002];
                [ppSecretQuestionsView showSecretQuestionsViewByRight];
                break;
            case PPVerificationModeMailBox:
                [ppBoundToNextMailBoxView setNextCode:[[paramDic objectForKey:@"data"] objectForKey:@"nextCode"]];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToNextMailBoxView atIndex:1002];
                [ppBoundToNextMailBoxView showBoundToNextMailBoxViewByRight];
                break;
            case PPVerificationModePhone:
                [ppBoundToNextPhoneView setNextCode:[[paramDic objectForKey:@"data"] objectForKey:@"nextCode"]];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToNextPhoneView atIndex:1002];
                [ppBoundToNextPhoneView showBoundToNextPhoneViewByRight];
                break;
        }
        [ppSecretQuestionsView release];
        [ppBoundToNextMailBoxView release];
        [ppBoundToNextPhoneView release];
    }
    else
    {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:[paramDic objectForKey:@"msg"]];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    
}

#pragma mark - dealloc -

- (void)dealloc{
    if (PPDEALLOC_ISNSLOG) {
        NSLog(@"PPBoundToMailBoxView dealloc");
    }

    [_allArray release];
    [_tableViewArray release];
    [super dealloc];
}

@end

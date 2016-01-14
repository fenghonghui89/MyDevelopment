//
//  PPFindUserNameByEmailView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-8.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPFindUserNameByEmailView.h"
#import "PPCommon.h"
#import "PPFindPassWordByTypeView.h"

@implementation PPFindUserNameByEmailView



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
        [_titleLabel setText:@"通过邮箱找回"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleSecretQuestionSetting"]];
        
        
        
        
        _boundToMailBoxImageView = [[UIImageView alloc] init];
        [_boundToMailBoxImageView setUserInteractionEnabled:YES];
        [_boundToMailBoxImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:_boundToMailBoxImageView];
        [_boundToMailBoxImageView release];
        
        
        _boundToMailBoxLabel = [[UILabel alloc] init];
        [_boundToMailBoxLabel setFrame:CGRectMake(16, 0,70, 44)];
        [_boundToMailBoxLabel setBackgroundColor:[UIColor clearColor]];
        [_boundToMailBoxLabel setText:@"绑定邮箱"];
        [_boundToMailBoxLabel setFont:[UIFont systemFontOfSize:15]];
        [_boundToMailBoxImageView addSubview:_boundToMailBoxLabel];
        [_boundToMailBoxLabel release];
        
        _boundToMailBoxTextfield = [[UITextField alloc] init];
        [_boundToMailBoxTextfield addTarget:self action:@selector(textFieldDidChange:)
                          forControlEvents:UIControlEventEditingChanged];
        [_boundToMailBoxTextfield setPlaceholder:@"请输入绑定邮箱找回帐号"];
        [_boundToMailBoxTextfield setReturnKeyType:UIReturnKeySend];
        [_boundToMailBoxTextfield setDelegate:self];
        [_boundToMailBoxTextfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_boundToMailBoxTextfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_boundToMailBoxTextfield setFont:[UIFont systemFontOfSize:15]];
        [_boundToMailBoxImageView addSubview:_boundToMailBoxTextfield];
        [_boundToMailBoxTextfield release];
        
        
        
        
        _boundToMailBoxButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [[_boundToMailBoxButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
        [_boundToMailBoxButton setTitle:@"确 定" forState:UIControlStateNormal];
        [_boundToMailBoxButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_boundToMailBoxButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [_boundToMailBoxButton addTarget:self action:@selector(boundToMailBoxButtonTouchUpInside)
                        forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:_boundToMailBoxButton];
        
        
        
        
        [_bgImageView addSubview:_tableView];
        [_tableView release];
        [_tableView setHidden:YES];
        [_boundToMailBoxButton setHidden:NO];
        ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [ppMBProgressHUD hide:YES];
        [ppMBProgressHUD setLabelText:PP_MBPROGRESSHUDTEXT];
        
        
    }
    return self;
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

- (void)initVerticalFrame
{
    [super initVerticalFrame];
    
    
    [_boundToMailBoxImageView setFrame:CGRectMake(0,  44 + 30,
                                                 _bgImageView.frame.size.width, 44)];
    [_boundToMailBoxTextfield setFrame:CGRectMake(86, 0, _bgImageView.frame.size.width - _boundToMailBoxLabel.frame.size.width - 20, 44)];
    [_tableView setFrame:CGRectMake(0, _boundToMailBoxImageView.frame.size.height + _boundToMailBoxImageView.frame.origin.y - 3,
                                    _bgImageView.frame.size.width, 150)];
    
    
    [_boundToMailBoxButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _boundToMailBoxImageView.frame.origin.y + 44 + 20, 300, 44)];
    
    
    
    
}

-(void)initHorizontalFrame
{
    [super initHorizontalFrame];
    
    [_boundToMailBoxImageView setFrame:CGRectMake(0,  44 + 30,
                                                 _bgImageView.frame.size.width, 44)];
    [_boundToMailBoxTextfield setFrame:CGRectMake(86, 0, _bgImageView.frame.size.width - _boundToMailBoxLabel.frame.size.width - 20, 44)];
    [_tableView setFrame:CGRectMake(0, _boundToMailBoxImageView.frame.size.height + _boundToMailBoxImageView.frame.origin.y - 3,
                                    _bgImageView.frame.size.width, 120)];
    
    
    [_boundToMailBoxButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _boundToMailBoxImageView.frame.origin.y + 44 + 20, 300, 44)];
    
    
}

#pragma mark - 找回账号  -

- (void)boundToMailBoxButtonTouchUpInside
{
    [PPUIKit clostKeyBoard];
    [_tableView setHidden:YES];
    [_boundToMailBoxButton setHidden:NO];
    [super revertView];
    UITextField *textField = nil;
    BOOL isPass = YES;
    NSString *errorMgs = nil;
    
    
    if ([[_boundToMailBoxTextfield text] isEqualToString:@""] || [_boundToMailBoxTextfield text] == nil)
    {
        errorMgs = @"邮箱不能为空";
        isPass = NO;
        textField = _boundToMailBoxTextfield;
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
    //    //设定检测邮箱的正则表达式
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern: @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:0 error:nil];
    //进行匹配

    NSTextCheckingResult *result2 = [regex2 firstMatchInString:_boundToMailBoxTextfield.text options:0 range:NSMakeRange(0, [_boundToMailBoxTextfield.text length])];

    if (result2)//匹配成功
    {
        [ppMBProgressHUD show:YES];
        [ppMBProgressHUD setLabelText:@"正在发送邮件..."];
        PPWebViewData *pp = [[PPWebViewData alloc] init];
        [pp setDelegate:self];

        NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
        //转为字符型
        NSString *timeString = [NSString stringWithFormat:@"%f", a];
        
        NSLog(@"timeString-%@",timeString);
        
        
        NSString *sign = [pp makeSignMD5:findUserNameByEmail Username:nil Phone:nil Phone_code:nil NewPwd:nil nextCode:nil Email:_boundToMailBoxTextfield.text Question_1:QuestionNil Question_2:QuestionNil Answer_1:nil Answer_2:nil NSTimeInterval:timeString];
        [pp getFindUserNameByEmail:_boundToMailBoxTextfield.text Sign:sign Time:timeString];
        [pp release];
        
        
    }
    else
    {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE
                                                        message:@"邮箱格式不正确，请重新输入"];
        [alert setCancelButtonTitle:@"确定" block:^{
            [textField becomeFirstResponder];
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        return;
    }
}

#pragma mark  - 视图显示，隐藏，消失 -
/// <summary>
/// 密保设置页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showFindUserNameByEmailViewByRight
{
    
    [super showViewByRight];
}

-(void)showFindUserNameByEmailViewByLeft
{
    
    [super showViewByRight];
}

-(void)hiddenFindUserNameByEmailViewInRight
{
    [super hiddenViewInRight];
}
- (void)hiddenFindUserNameByEmailViewInLeft
{
    [super hiddenViewInRight];
}


-(void)didHiddenView
{
    [PPMBProgressHUD hideAllHUDsForView:self animated:YES];
    [super didHiddenView];
}

-(void)didShowView{
    
}


#pragma mark  - 关闭视图，返回上一层 -

-(void)backButtonPressed
{
    [self hiddenFindUserNameByEmailViewInRight];
    PPFindPassWordByTypeView *ppFindPassWordByTypeView = [[PPFindPassWordByTypeView alloc] init];
    [ppFindPassWordByTypeView setCurrUserName:@""];
    [ppFindPassWordByTypeView setForgetUserNameOrPass:YES];
    [[[UIApplication sharedApplication] keyWindow] addSubview:ppFindPassWordByTypeView];
    [ppFindPassWordByTypeView showPPFindPassWordByTypeViewByLeft];
    [ppFindPassWordByTypeView release];
}

#pragma mark  - UITableViewDataSource , UITableViewDelegate -

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
        [_boundToMailBoxButton setHidden:NO];
    }
    return [_tableViewArray count];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [NSString stringWithFormat:@"%@%@",[_boundToMailBoxTextfield text],[_tableViewArray objectAtIndex:[indexPath row]]];
    [_boundToMailBoxTextfield setText:str];
    [tableView setHidden:YES];
    [_boundToMailBoxButton setHidden:NO];
}

#pragma mark  - UITextFieldDelegate -


- (void)textFieldDidChange:(UITextField *) textField
{
    [_boundToMailBoxButton setHidden:YES];
    [_tableView setHidden:NO];
    if ([[textField text] length] <= 0) {
        [_boundToMailBoxButton setHidden:NO];
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
    if (textField == _boundToMailBoxTextfield)
    {
        [self boundToMailBoxButtonTouchUpInside];
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
            
            [self rollupView:70];
        }
        
    }
    else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        if (_bgImageView.frame.size.height <= 480)
        {
            [self rollupView:50];
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
    if ([_boundToMailBoxTextfield isFirstResponder])
    {
        [self textChange:_boundToMailBoxTextfield];
    }
}

#pragma mark - 找回账号 回调 -

- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError
{
    [ppMBProgressHUD setLabelText:@"网络异常,请尝试刷新"];
    NSString *string = [paramError localizedDescription];
    if (PP_ISNSLOG) {
        NSLog(@"ppHttpResponseDidFailWithErrorCallBack-%@",string);
    }
    [ppMBProgressHUD hide:YES afterDelay:1];
}


- (void)findUserNameByEmailCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] intValue] == 0) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:[paramDic objectForKey:@"msg"]];
        
        if ([[paramDic objectForKey:@"data"] objectForKey:@"address"] == [NSNull null]) {
            [alert setCancelButtonTitle:@"确定" block:^{

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
//        [super _keyBoardHiddenButtonTouchUpInside];
    }];
    
    [alert addButtonWithTitle:nil block:nil];
    [alert show];
    [alert release];
}

- (void)responseDidFailWithErrorCallBack
{
    [ppMBProgressHUD setLabelText:@"获取数据失败"];
    [ppMBProgressHUD hide:YES afterDelay:2];
}


#pragma mark - dealloc -

- (void)dealloc{
    [_allArray release];
    [_tableViewArray release];
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
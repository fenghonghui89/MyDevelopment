//
//  PPBoundToNextMailBoxView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-28.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBoundToNextMailBoxView.h"
#import "PPUIKit.h"
#import "PPCommon.h"
#import "PPBoundToMailBoxView.h"
#import "PPPasswordProtectionView.h"

@implementation PPBoundToNextMailBoxView

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
        [boundToMailBoxImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:boundToMailBoxImageView];
        [boundToMailBoxImageView release];
        
        
        boundToMailBoxLabel = [[UILabel alloc] init];
        [boundToMailBoxLabel setFrame:CGRectMake(16, 0,70, 44)];
        [boundToMailBoxLabel setBackgroundColor:[UIColor clearColor]];
        [boundToMailBoxLabel setText:@"绑定邮箱"];
        [boundToMailBoxLabel setFont:[UIFont systemFontOfSize:15]];
        [boundToMailBoxImageView addSubview:boundToMailBoxLabel];
        [boundToMailBoxLabel release];
        
        boundToMailBoxTextfield = [[UITextField alloc] init];
        [boundToMailBoxTextfield addTarget:self action:@selector(textFieldDidChange:)
                          forControlEvents:UIControlEventEditingChanged];
        [boundToMailBoxTextfield setPlaceholder:@"输入邮箱"];
        [boundToMailBoxTextfield setReturnKeyType:UIReturnKeyNext];
        [boundToMailBoxTextfield setDelegate:self];
        [boundToMailBoxTextfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        [boundToMailBoxTextfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        [boundToMailBoxTextfield setFont:[UIFont systemFontOfSize:15]];
        [boundToMailBoxImageView addSubview:boundToMailBoxTextfield];
        [boundToMailBoxTextfield release];
        
        
        
        
        boundToMailBoxButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [boundToMailBoxButton setTitle:@"发送验证邮件" forState:UIControlStateNormal];
        [boundToMailBoxButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [boundToMailBoxButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        boundToMailBoxButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        [boundToMailBoxButton addTarget:self action:@selector(boundToMailBoxButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [_bgImageView addSubview:boundToMailBoxButton];
        

        
        
        [_bgImageView addSubview:_tableView];
        [_tableView release];
        [_tableView setHidden:YES];
        ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [ppMBProgressHUD hide:YES];
        
    }
    return self;
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

- (void)initVerticalFrame
{
    [super initVerticalFrame];
    
    
    [boundToMailBoxImageView setFrame:CGRectMake(0,  44 + 30,
                                                 _bgImageView.frame.size.width, 44)];
    [boundToMailBoxTextfield setFrame:CGRectMake(86, 0, _bgImageView.frame.size.width - boundToMailBoxLabel.frame.size.width - 20, 44)];
    [_tableView setFrame:CGRectMake(0, boundToMailBoxImageView.frame.size.height + boundToMailBoxImageView.frame.origin.y - 3,
                                    _bgImageView.frame.size.width, 150)];

    
    [boundToMailBoxButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, boundToMailBoxImageView.frame.origin.y + 44 + 20, 300, 44)];
}

-(void)initHorizontalFrame
{
    [super initHorizontalFrame];
    
    [boundToMailBoxImageView setFrame:CGRectMake(0,  44 + 30,
                                                 _bgImageView.frame.size.width, 44)];
    [boundToMailBoxTextfield setFrame:CGRectMake(86, 0, _bgImageView.frame.size.width - boundToMailBoxLabel.frame.size.width - 20, 44)];
    [_tableView setFrame:CGRectMake(0, boundToMailBoxImageView.frame.size.height + boundToMailBoxImageView.frame.origin.y - 3,
                                    _bgImageView.frame.size.width, 120)];
    
    
    [boundToMailBoxButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, boundToMailBoxImageView.frame.origin.y + 44 + 20, 300, 44)];
   
    
}

#pragma mark - 绑定邮箱 -

- (void)boundToMailBoxButtonTouchUpInside
{
    [super revertView];
    [PPUIKit clostKeyBoard];
    [_tableView setHidden:YES];
    UITextField *textField = nil;

    BOOL isPass = YES;
    NSString *errorMgs = nil;

    
    if ([[boundToMailBoxTextfield text] isEqualToString:@""] || [boundToMailBoxTextfield text] == nil)
    {
        errorMgs = @"邮箱不能为空";
        isPass = NO;
        textField = boundToMailBoxTextfield;
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
        [ppMBProgressHUD setLabelText:@"正在发送邮件..."];
        [ppMBProgressHUD show:YES];
        
        
        PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
        [ppWebViewData setDelegate:self];
        
        [ppWebViewData getBindEmail:[boundToMailBoxTextfield text]  Nextcode:self.nextCode];
        [ppWebViewData release];
    }
}


#pragma mark  - 视图显示，隐藏，消失 -
/// <summary>
/// 密保设置页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showBoundToNextMailBoxViewByRight
{
    
    [super showViewByRight];
}

-(void)showBoundToNextMailBoxViewByLeft
{
    
    [super showViewByRight];
}

-(void)hiddenBoundToNextMailBoxViewInRight
{
    [super hiddenViewInRight];
}
- (void)hiddenBoundToNextMailBoxViewInLeft
{
    [super hiddenViewInRight];
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
    [self hiddenBoundToNextMailBoxViewInRight];
    PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
    [ppPasswordProtectionView showPasswordProtectionViewByLeft];
    [ppPasswordProtectionView release];
}

#pragma mark - UITableViewDataSource , UITableViewDelegate -

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
    
    NSString *str = [NSString stringWithFormat:@"%@%@",[boundToMailBoxTextfield text],[_tableViewArray objectAtIndex:[indexPath row]]];
    [[cell textLabel ] setText:str];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [NSString stringWithFormat:@"%@%@",[boundToMailBoxTextfield text],[_tableViewArray objectAtIndex:[indexPath row]]];
    [boundToMailBoxTextfield setText:str];
    [tableView setHidden:YES];
    [boundToMailBoxButton setHidden:NO];
}


#pragma mark -  UITextFieldDelegate -

- (void)textFieldDidChange:(UITextField *) textField
{

    [boundToMailBoxButton setHidden:YES];
    [_tableView setHidden:NO];
    if ((textField.text == nil) || ([[textField text] length] <= 0)) {
        [_tableView setHidden:YES];
        [boundToMailBoxButton setHidden:NO];
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
    if (textField == boundToMailBoxTextfield)
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
        if (paramTextField == boundToMailBoxTextfield)
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
    if ([boundToMailBoxTextfield isFirstResponder])
    {
        [self textChange:boundToMailBoxTextfield];
    }
}

#pragma mark - 绑定邮箱 回调 -

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


- (void)bindEmailCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] intValue] == 0) {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:[paramDic objectForKey:@"msg"]];
        
        if ([[paramDic objectForKey:@"data"] objectForKey:@"address"] == [NSNull null]) {
            [alert setCancelButtonTitle:@"确定" block:^{
                [self hiddenBoundToNextMailBoxViewInRight];
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

#pragma mark - dealloc -

- (void)dealloc{
    if (PPDEALLOC_ISNSLOG) {
        NSLog(@"PPBoundToNextMailBoxView dealloc");
    }
    [_allArray release];
    _allArray = nil;
    [_tableViewArray release];
    _tableViewArray = nil;
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

//
//  PPFindPassWordByType.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-5.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPFindPassWordByTypeView.h"
#import "PPCommon.h"
#import "PPUIKit.h"
#import "PPForgetWhatView.h"
#import "PPInputUserNameView.h"
#import "PPFindUserNameByEmailView.h"
#import "PPFindUserNameByMobileView.h"

@implementation PPFindPassWordByTypeView

//static PPFindPassWordByTypeView *ppFindPassWordByTypeView;

- (id)init
{
    self = [super init];
    if (self) {
       
        
        [_titleLabel setText:@"找回方式"];
        [self.verticalLineLeftView setHidden:NO];
        [self.backButton setHidden:NO];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleSecretQuestionSetting"]];
        
        
        _passwordProtectionSettingTableView= [[UITableView alloc] init];
        [_passwordProtectionSettingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_passwordProtectionSettingTableView setBounces:NO];
        [_passwordProtectionSettingTableView setShowsVerticalScrollIndicator:YES];
        _passwordProtectionSettingTableView.backgroundColor = [PPCommon getColor:@"f0eff3"];
        [_passwordProtectionSettingTableView setFrame:CGRectMake(0, 50, 320, 430)];
        [_passwordProtectionSettingTableView setContentSize:CGSizeMake(320, 600)];
        [_bgImageView addSubview:_passwordProtectionSettingTableView];
        [_passwordProtectionSettingTableView release];
        
        ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [ppMBProgressHUD setLabelText:PP_MBPROGRESSHUDTEXT];
        [ppMBProgressHUD hide:YES];
        
        
        [self initVerticalFrame];
    }
    return self;
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

-(void)initVerticalFrame
{
    [super initVerticalFrame];
    
    [_passwordProtectionSettingTableView setFrame:CGRectMake(0, 51, _bgImageView.frame.size.width, _bgImageView.frame.size.height - 51)];
    
}

-(void)initHorizontalFrame{
    [super initHorizontalFrame];
    [_passwordProtectionSettingTableView setFrame:CGRectMake(0, 51, _bgImageView.frame.size.width , _bgImageView.frame.size.height - 51)];
}

#pragma mark - UITableViewDelegate , UITableViewDataSource -

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_forgetUserNameOrPass)
    {
        return 3;
    }
    else
    {
        return 4;
    }
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置table view行高
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 44;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (indexPath.row == 0) {
        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
            return height - 9;
        }
        else if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
        {
            return height - 19;
        }
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowNumber = indexPath.row;
    PPCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ([indexPath row] > 0) {
        if (!cell) {
            cell = [[[PPCenterTableViewCell alloc] initWithDefaultType] autorelease];
            NSString *imageName = @"";
            NSString *titleString = @"";
            int tagOfcell = 2;
            switch (rowNumber) {
                case 0:
                    imageName = @"";
                    titleString = @"";
                    break;
                case 1:
                    imageName = @"PPBoundToPhone";
                    _forgetUserNameOrPass == YES ? (titleString = @"通过手机找回账号") : (titleString = @"通过手机找回密码");
                    if (!_forgetUserNameOrPass) {
                        UIColor *color4 = [[_tableViewDic objectForKey:@"phone_check"] integerValue] == 1 ?
                        [PPCommon getColor:@"cccccc"] : [PPCommon getColor:@"d5300f"];
                        [[cell tintLabel] setText:[[_tableViewDic objectForKey:@"phone_check"] integerValue] == 1 ? @"已绑定" : @"未绑定"];
                        [[cell tintLabel] setTextColor:color4];
                        [[cell actionImageView] setHidden:![[_tableViewDic objectForKey:@"phone_check"] integerValue]];
                        _isBoundToPhoneNumber = [[_tableViewDic objectForKey:@"phone_check"] integerValue];
                    }
                    break;
                case 2:
                    imageName = @"PPBoundToMail";
                    _forgetUserNameOrPass == YES ? (titleString = @"通过邮箱找回账号") : (titleString = @"通过邮箱找回密码");
                    if (!_forgetUserNameOrPass) {
                        UIColor *color5 = [[_tableViewDic objectForKey:@"email_check"] integerValue] == 1 ?
                        [PPCommon getColor:@"cccccc"] : [PPCommon getColor:@"d5300f"];
                        [[cell tintLabel] setText:[[_tableViewDic objectForKey:@"email_check"] integerValue] == 1 ? @"已绑定" : @"未绑定"];
                        [[cell tintLabel] setTextColor:color5];
                        [[cell actionImageView] setHidden:![[_tableViewDic objectForKey:@"email_check"] integerValue]];
                        _isBoundToMailBox = [[_tableViewDic objectForKey:@"email_check"] integerValue];
                    }

                    break;
                case 3:
                    tagOfcell = 0;
                    imageName = @"PPSecretQuestions";
                    _forgetUserNameOrPass == YES ? (titleString = @"通过密保找回账号") : (titleString = @"通过密保找回密码");
                    UIColor *color6 = [[_tableViewDic objectForKey:@"question_check"] integerValue] == 1 ?
                    [PPCommon getColor:@"cccccc"] : [PPCommon getColor:@"d5300f"];
                    [[cell tintLabel] setText:[[_tableViewDic objectForKey:@"question_check"] integerValue] == 1 ? @"已绑定" : @"未绑定"];
                    [[cell tintLabel] setTextColor:color6];
                    [[cell actionImageView] setHidden:![[_tableViewDic objectForKey:@"question_check"] integerValue]];
                    _isBoundToSecretQuestions = [[_tableViewDic objectForKey:@"question_check"] integerValue];
                    break;
                default:
                    imageName = @"ppcenter";
                    titleString = @"密保设置";
                    break;
            }
            
            cell.tag = tagOfcell;
            [[cell titleLabel] setText:titleString];
            [cell.titleIamgeView setImage:[PPUIKit setLocaImage:imageName] ];
            
        }
        return cell ;

    }
    else
    {
        cell = [[[PPCenterTableViewCell alloc] initWithDefaultType] autorelease];
        cell.tag = 3;
        [[cell titleLabel] setText:@""];
        [cell.titleIamgeView setImage:nil];
        [cell.actionImageView setHidden:YES];
        return cell ;
    }
    

}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int rowNumber = indexPath.row;
    switch (rowNumber) {
        case 1:
            //公用页面部分.先判断是否已经保存改方式.然后通过区分找回帐号还是密码,
            if (_isBoundToPhoneNumber)
            {
//                [self hiddenPPFindPassWordByTypeViewInLeft];
                PPWebView *ppWebView = [[PPWebView alloc] init];
                [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
                [ppWebView resetPass:ResetPassByPhonePage UserName:_currUserName];
                [[ppWebView backButton] setHidden:YES];
                [[ppWebView verticalLineLeftView] setHidden:YES];
                [ppWebView release];
            }
            else
            {
                if (_forgetUserNameOrPass)
                {
                    [self hiddenPPFindPassWordByTypeViewInLeft];
                    PPFindUserNameByMobileView *ppFindUserNameByMobileView = [[PPFindUserNameByMobileView alloc] init];
                    [[[UIApplication sharedApplication] keyWindow] addSubview:ppFindUserNameByMobileView];
                    [ppFindUserNameByMobileView showPPFindUserNameByMobileViewByRight];
                    [ppFindUserNameByMobileView release];
                }
                else
                {
                    NSString *title = @"温馨提示";
                    PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:@"未绑定,不能通过此种方式！"];
                    [alertView setCancelButtonTitle:@"确定" block:^{
                        [_passwordProtectionSettingTableView reloadData];
                    }];
                    [alertView addButtonWithTitle:nil block:nil];
                    [alertView show];
                    [alertView release];
                }

            }
            break;
        case 2:
            if (_isBoundToMailBox)
            {
                [ppMBProgressHUD setLabelText:@"正在发送邮件..."];
                [ppMBProgressHUD show:YES];
                PPWebViewData *pp = [[PPWebViewData alloc] init];
                [pp setDelegate:self];
                
                NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
                NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
                //转为字符型
                NSString *timeString = [NSString stringWithFormat:@"%f", a];
                NSString *sign = [pp makeSignMD5:findPwdByEmail Username:_currUserName Phone:nil Phone_code:nil NewPwd:nil nextCode:nil Email:nil Question_1:QuestionNil Question_2:QuestionNil Answer_1:nil Answer_2:nil NSTimeInterval:timeString];
                [pp getFindPassWordByUserName:_currUserName Sign:sign Time:timeString];
                [pp release];
                

            }
            else
            {
                if (_forgetUserNameOrPass)
                {
                    [self hiddenPPFindPassWordByTypeViewInLeft];
                    PPFindUserNameByEmailView *ppFindUserNameByEmailView = [[PPFindUserNameByEmailView alloc] init];
                    [[[UIApplication sharedApplication] keyWindow] addSubview:ppFindUserNameByEmailView];
                    [ppFindUserNameByEmailView showFindUserNameByEmailViewByRight];
                    [ppFindUserNameByEmailView release];
                }
                else
                {
                    NSString *title = @"温馨提示";
                    PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:@"未绑定,不能通过此种方式！"];
                    [alertView setCancelButtonTitle:@"确定" block:^{
                        [_passwordProtectionSettingTableView reloadData];
                    }];
                    [alertView addButtonWithTitle:nil block:nil];
                    [alertView show];
                    [alertView release];
                }
            }
            break;
        case 3:
            if (_isBoundToSecretQuestions)
            {
//                [self hiddenPPFindPassWordByTypeViewInLeft];
                
                PPWebView *ppWebView = [[PPWebView alloc] init];
                [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
                [ppWebView resetPass:ResetPassByQuestionPage UserName:_currUserName];
                [ppWebView release];
                
            }
            else
            {
                NSString *title = @"温馨提示";
                PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:@"未绑定,不能通过此种方式！"];
                [alertView setCancelButtonTitle:@"确定" block:^{
                    [_passwordProtectionSettingTableView reloadData];
                }];
                [alertView addButtonWithTitle:nil block:nil];
                [alertView show];
                [alertView release];
            }
            break;
        default:
            break;
    }
}

#pragma mark  - 视图显示，隐藏，消失 -
/// <summary>
/// 密保设置页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showPPFindPassWordByTypeViewByRight
{
    if (!_forgetUserNameOrPass)
    {
        [ppMBProgressHUD show:YES];
        PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
        [ppWebViewData setDelegate:self];
        [ppWebViewData getUserInfoSecuityToFindPassword:_currUserName];
        [ppWebViewData release];
    }
    else
    {
        [_passwordProtectionSettingTableView setDelegate:self];
        [_passwordProtectionSettingTableView setDataSource:self];
    }
    [super showViewByRight];
}

-(void)showPPFindPassWordByTypeViewByLeft
{
    if (!_forgetUserNameOrPass)
    {
        [ppMBProgressHUD show:YES];
        PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
        [ppWebViewData setDelegate:self];
        [ppWebViewData getUserInfoSecuityToFindPassword:_currUserName];
        [ppWebViewData release];
    }
    else
    {
        [_passwordProtectionSettingTableView setDelegate:self];
        [_passwordProtectionSettingTableView setDataSource:self];
    }
    [super showViewByLeft];
}

- (void)didHiddenView
{
    
    [PPMBProgressHUD hideAllHUDsForView:self animated:YES];
    [super didHiddenView];

}


-(void)hiddenPPFindPassWordByTypeViewInRight
{
    [super hiddenViewInRight];
}

- (void)hiddenPPFindPassWordByTypeViewInLeft
{
    [super hiddenViewInLeft];
}



- (void)didShowView{
    
}

#pragma mark  - 关闭视图，返回上一层 -

-(void)backButtonPressed
{
    [self hiddenPPFindPassWordByTypeViewInRight];
    if (_forgetUserNameOrPass)
    {
        PPForgetWhatView *ppForgetWhatView = [[PPForgetWhatView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppForgetWhatView atIndex:1002];
        [ppForgetWhatView showPPPForgetWhatViewByLeft];
        [ppForgetWhatView release];
    }
    else
    {
        PPInputUserNameView *ppInputUserNameView = [[PPInputUserNameView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] addSubview:ppInputUserNameView];
        [ppInputUserNameView showPPInputUserNameViewByLeft];
        [ppInputUserNameView release];
    }
    
    
}

#pragma mark - 用户信息安全级别 ，找回密码  回调 -

- (void)findPassWordByUserNameCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
        NSString *title = @"温馨提示";
    if ([[paramDic objectForKey:@"error"] intValue] != 0) {

        PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:[paramDic objectForKey:@"msg"]];
        [alertView setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alertView addButtonWithTitle:nil block:nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    //跳转去邮箱
    PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:[paramDic objectForKey:@"msg"]];
    
    if ([[_tableViewDic objectForKey:@"email_address"] objectForKey:@"href"] == [NSNull null]) {
        [alertView setCancelButtonTitle:@"确定" block:^{
            
        }];
    }
    else
    {
        [alertView setCancelButtonTitle:@"立即前往" block:^{
            
            NSString *address = [[_tableViewDic objectForKey:@"email_address"] objectForKey:@"href"];
            
            //        if ([address isEqualToString:@"https://mail.qq.com"]) {
            //            PPWebView *ppWebView = [[PPWebView alloc] init];
            //            [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
            //            [ppWebView goToAddress:address];
            //            [ppWebView release];
            //        }
            //        else
            //        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
            //        }
            
        }];
        
    }
    
    
    [alertView addButtonWithTitle:@"取消" block:nil];
    [alertView show];
    [alertView release];
    

}

- (void)userInfoSecuityCallBack:(NSDictionary *)paramDic
{

    if ([[paramDic objectForKey:@"error"] intValue] != 0) {
        [ppMBProgressHUD setLabelText:@"获取数据异常"];
        [ppMBProgressHUD hide:YES afterDelay:1];

        NSString *title = @"温馨提示";
        PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:[paramDic objectForKey:@"msg"]];
        [alertView setCancelButtonTitle:@"确定" block:^{
            [self hiddenPPFindPassWordByTypeViewInRight];

            PPInputUserNameView *ppInputUserNameView = [[PPInputUserNameView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] addSubview:ppInputUserNameView];
            [ppInputUserNameView showPPInputUserNameViewByLeft];
            [ppInputUserNameView release];
            
            
        }];
        [alertView addButtonWithTitle:nil block:nil];
        [alertView show];
        [alertView release];
        return;
    }
    [ppMBProgressHUD hide:YES];
    if (_tableViewDic) {
        [_tableViewDic release];
        _tableViewDic = nil;
    }
    
    _tableViewDic = [[paramDic objectForKey:@"data"] retain];
    [_passwordProtectionSettingTableView setDelegate:self];
    [_passwordProtectionSettingTableView setDataSource:self];
    [_passwordProtectionSettingTableView reloadData];
}

- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError
{
    
    PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:@"网络异常,请尝试刷新"];
    [alertView setCancelButtonTitle:@"确定" block:^{
        [self hiddenPPFindPassWordByTypeViewInRight];
        PPInputUserNameView *ppInputUserNameView = [[PPInputUserNameView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] addSubview:ppInputUserNameView];
        [ppInputUserNameView showPPInputUserNameViewByLeft];
        [ppInputUserNameView release];
        
        
    }];
    [alertView addButtonWithTitle:nil block:nil];
    [alertView show];
    [alertView release];
}

#pragma mark  - dealloc -

-(void)dealloc{
    [_tableViewDic release];
    _tableViewDic = nil;
    [_currUserName release];
    [super dealloc];
}
@end

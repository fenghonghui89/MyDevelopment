//
//  PPPasswordProtectionView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-10.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPPasswordProtectionView.h"
#import "PPCenterTableViewCell.h"
#import "PPCommon.h"
#import "PPBoundToMailBoxView.h"
#import "PPBoundToPhoneView.h"
#import "PPAppPlatformKitConfig.h"
#import "PPSecretQuestionAnswerView.h"
#import "PPBoundToWhatView.h"



@implementation PPPasswordProtectionView

- (id)init
{
    self = [super init];
    if (self) {

        
        [_titleLabel setText:@"密保设置"];
        [self.verticalLineLeftView setHidden:NO];
        [self.backButton setHidden:NO];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleSecretQuestionSetting"]];
        
        isBoundToMailBox=YES;
        isBoundToPhoneNumber=NO;
        isBoundToSecretQuestions=NO;
        
        _passwordProtectionSettingTableView= [[UITableView alloc] init];
        [_passwordProtectionSettingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_passwordProtectionSettingTableView setBounces:NO];
        [_passwordProtectionSettingTableView setShowsVerticalScrollIndicator:YES];
        _passwordProtectionSettingTableView.backgroundColor = [PPCommon getColor:@"f0eff3"];
        [_passwordProtectionSettingTableView setContentSize:CGSizeMake(320, 600)];
        [_bgImageView addSubview:_passwordProtectionSettingTableView];
        [_passwordProtectionSettingTableView release];
        
        PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
        [ppWebViewData setDelegate:self];
        [ppWebViewData getUserInfoSecuity:PP_REQUEST_USERNAME]; //获取用户安全级别
        [ppWebViewData release];
        
        ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [ppMBProgressHUD setLabelText:PP_MBPROGRESSHUDTEXT];
        [ppMBProgressHUD show:YES];
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

#pragma mark - UITableViewDelegate ,UITableViewDataSource -

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
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
    if (indexPath.row == 0 || indexPath.row == 3) {
        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
            return height - 9;
        }
        else if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
        {
            return height - 28;
        }
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowNumber = indexPath.row;
    PPCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        if (rowNumber > 3) {
            cell = [[[PPCenterTableViewCell alloc] initWithDefaultType] autorelease];
            NSString *imageName;
            NSString *titleString;

            int tagOfcell = 2;
            switch (rowNumber) {

                case 4:
                    imageName = @"PPBoundToPhone";
                    titleString = @"绑定手机";
                    UIColor *color4 = [[_tableViewDic objectForKey:@"phone_check"] integerValue] == 1 ?
                    [PPCommon getColor:@"cccccc"] : [PPCommon getColor:@"d5300f"];
                    [[cell tintLabel] setText:[[_tableViewDic objectForKey:@"phone_check"] integerValue] == 1 ? @"已绑定" : @"未绑定"];
                    [[cell tintLabel] setTextColor:color4];

                    break;
                case 5:
                    imageName = @"PPBoundToMail";
                    titleString = @"绑定邮箱";
                    UIColor *color5 = [[_tableViewDic objectForKey:@"email_check"] integerValue] == 1 ?
                    [PPCommon getColor:@"cccccc"] : [PPCommon getColor:@"d5300f"];
                    [[cell tintLabel] setText:[[_tableViewDic objectForKey:@"email_check"] integerValue] == 1 ? @"已绑定" : @"未绑定"];
                    [[cell tintLabel] setTextColor:color5];

                    break;
                case 6:
                    tagOfcell = 0;
                    imageName = @"PPSecretQuestions";
                    titleString = @"密保问题";
                    UIColor *color6 = [[_tableViewDic objectForKey:@"question_check"] integerValue] == 1 ?
                    [PPCommon getColor:@"cccccc"] : [PPCommon getColor:@"d5300f"];
                    [[cell tintLabel] setText:[[_tableViewDic objectForKey:@"question_check"] integerValue] == 1 ? @"已绑定" : @"未绑定"];
                    [[cell tintLabel] setTextColor:color6];
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
        else
        {

            cell = [[[PPCenterTableViewCell alloc] initWithLabelType] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.valueLabel setTextAlignment:NSTextAlignmentLeft];
            
            if (rowNumber == 1)
            {
                NSString *username = [[PPAppPlatformKit sharedInstance] currentUserName];
                [cell.titleLabel setText:@"用户名"];
                if(username == nil)
                {
                    username = @"尚未登录";
                }
                [cell.valueLabel setText:username];
                [cell.valueLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
                [cell.actionButton setHidden:YES];
                cell.tag = 1;                
            }
            else if (rowNumber == 2)
            {
                _userInfoSecurityLevel = 0;
                _userInfoSecurityLevel += [[_tableViewDic objectForKey:@"question_check"] integerValue];
                _userInfoSecurityLevel += [[_tableViewDic objectForKey:@"phone_check"] integerValue];
                _userInfoSecurityLevel += [[_tableViewDic objectForKey:@"email_check"] integerValue];
                [cell.titleLabel setText:@"安全级别"];
                switch (_userInfoSecurityLevel) {
                    case 1:
                        [cell.valueLabel setText:@"低"];
                        [cell.valueLabel setTextColor:[PPCommon getColor:@"d5300f"]];
                        break;
                    case 2:
                        [cell.valueLabel setText:@"中"];
                        [cell.valueLabel setTextColor:[PPCommon getColor:@"5db721"]];
                        break;
                    case 3:
                        [cell.valueLabel setText:@"高"];
                        [cell.valueLabel setTextColor:[PPCommon getColor:@"5db721"]];
                        break;
                    default:
                        [cell.valueLabel setText:@"低"];
                        [cell.valueLabel setTextColor:[PPCommon getColor:@"d5300f"]];
                        break;
                }


                [cell.actionButton setHidden:YES];
                cell.tag = 0;
            }
            else
            {
                [cell.titleLabel setText:@""];
                [cell.valueLabel setText:@""];
                [cell.actionButton setHidden:YES];
                cell.tag = 3;
            }
        }
    }
    
    return cell ;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowNumber=indexPath.row;

    switch (rowNumber) {
        case 4:
            [self hiddenPasswordProtectionViewInLeft];
            if ([[_tableViewDic objectForKey:@"phone_check"] integerValue] == 1 )
            {
                PPBoundToPhoneView *ppBoundToPhoneView = [[PPBoundToPhoneView alloc] init];
                [ppBoundToPhoneView setIsUpdate:YES];
                NSString *oldPhone = [_tableViewDic objectForKey:@"phone"];
                [ppBoundToPhoneView setOldPhone:oldPhone];
                if ([oldPhone length] >= 11) {
                    oldPhone = [NSString stringWithFormat:@"%@******%@",[oldPhone substringToIndex:3],[oldPhone substringFromIndex:9]];
                }
                [[ppBoundToPhoneView phoneNumberTextfield] setText:oldPhone];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToPhoneView atIndex:1002];
                [ppBoundToPhoneView showBoundToPhoneViewByRight];
                [ppBoundToPhoneView setNextView:PPVerificationModePhone];
                [ppBoundToPhoneView release];
            }
            else
            {
                NSMutableArray *boundViewArray= [[NSMutableArray alloc] init];
                
                if ([[_tableViewDic objectForKey:@"email_check"] integerValue] == 1) {
                    [boundViewArray addObject:@"email"];
                }
                if ([[_tableViewDic objectForKey:@"question_check"] integerValue] == 1) {
                    [boundViewArray addObject:@"question"];
                }

                if ([boundViewArray count] == 0) {
                    PPBoundToPhoneView *ppBoundToPhoneView = [[PPBoundToPhoneView alloc] init];
                    NSString *oldPhone = [_tableViewDic objectForKey:@"phone"];
                    [ppBoundToPhoneView setIsUpdate:NO];
                    [ppBoundToPhoneView setOldPhone:oldPhone];
                    if ([oldPhone length] >= 11) {
                        oldPhone = [NSString stringWithFormat:@"%@******%@",[oldPhone substringToIndex:3],[oldPhone substringFromIndex:9]];
                    }
                    [[ppBoundToPhoneView phoneNumberTextfield] setText:oldPhone];
                    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToPhoneView atIndex:1002];
                    [ppBoundToPhoneView showBoundToPhoneViewByRight];
                    [ppBoundToPhoneView release];
                }
                else if([boundViewArray count] == 1)
                {
                    if ([[boundViewArray objectAtIndex:0] isEqualToString:@"email"]) {
                        NSString *oldEmail = [_tableViewDic objectForKey:@"email"];
                        PPBoundToMailBoxView *ppBoundToMailBoxView = [[PPBoundToMailBoxView alloc] init];
                        [ppBoundToMailBoxView setOldEmail:oldEmail];
                        if ([oldEmail length] >= 9) {
                            oldEmail = [NSString stringWithFormat:@"%@******%@",[oldEmail substringToIndex:1],
                                        [oldEmail substringFromIndex:([oldEmail length] - 8)]];
                        }
                        [ppBoundToMailBoxView setIsUpdate:YES];
                        [[ppBoundToMailBoxView boundToMailBoxTextfield] setText:oldEmail];
                        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToMailBoxView atIndex:1002];
                        [ppBoundToMailBoxView showBoundToMailBoxViewByRight];
                        [ppBoundToMailBoxView setNextView:PPVerificationModePhone];
                        [ppBoundToMailBoxView release];
                    }
                    else
                    {
                        PPSecretQuestionAnswerView *ppSecretQuestionAnswerView = [[PPSecretQuestionAnswerView alloc] init];
                        [ppSecretQuestionAnswerView setIsUpdate:YES];
                        [ppSecretQuestionAnswerView setQuestion1:[[_tableViewDic objectForKey:@"question_1"] integerValue]];
                        [ppSecretQuestionAnswerView setQuestion2:[[_tableViewDic objectForKey:@"question_2"] integerValue]];
                        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSecretQuestionAnswerView atIndex:1002];
                        [ppSecretQuestionAnswerView showSecretQuestionsAnswerViewByRight];
                        [ppSecretQuestionAnswerView setNextView:PPVerificationModePhone];
                        [ppSecretQuestionAnswerView release];
                    }
                }
                else if([boundViewArray count] > 1)
                {
                    PPBoundToWhatView *ppBoundToWhatView = [[PPBoundToWhatView alloc] init];
                    [ppBoundToWhatView setNextView:PPVerificationModePhone];
                    [ppBoundToWhatView setTableViewDic:_tableViewDic];
                    [ppBoundToWhatView setNextViewArray:boundViewArray];
                    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToWhatView atIndex:1002];
                    [ppBoundToWhatView showPPBoundToWhatViewByRight];
                    [ppBoundToWhatView release];
                }
                [boundViewArray release];
                
            }
            
            break;
        case 5:
            [self hiddenPasswordProtectionViewInLeft];

            if ([[_tableViewDic objectForKey:@"email_check"] integerValue] == 1 ) {
                            PPBoundToMailBoxView *ppBoundToMailBoxView = [[PPBoundToMailBoxView alloc] init];
                [ppBoundToMailBoxView setIsUpdate:YES];
                NSString *oldEmail = [_tableViewDic objectForKey:@"email"];

                [ppBoundToMailBoxView setOldEmail:oldEmail];
                if ([oldEmail length] >= 9) {
                    oldEmail = [NSString stringWithFormat:@"%@******%@",[oldEmail substringToIndex:1],
                                [oldEmail substringFromIndex:([oldEmail length] - 8)]];
                }
                [[ppBoundToMailBoxView boundToMailBoxTextfield] setText:oldEmail];
                [ppBoundToMailBoxView showBoundToMailBoxViewByRight];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToMailBoxView atIndex:1002];
                [ppBoundToMailBoxView setNextView:PPVerificationModeMailBox];
                [ppBoundToMailBoxView release];
                
            }
            else
            {
                NSMutableArray *boundViewArray= [[NSMutableArray alloc] init];
                
                if ([[_tableViewDic objectForKey:@"phone_check"] integerValue] == 1) {
                    [boundViewArray addObject:@"phone"];
                }
                if ([[_tableViewDic objectForKey:@"question_check"] integerValue] == 1) {
                    [boundViewArray addObject:@"question"];
                }
                
                if ([boundViewArray count] == 0) {
                    PPBoundToMailBoxView *ppBoundToMailBoxView = [[PPBoundToMailBoxView alloc] init];
                    [ppBoundToMailBoxView setIsUpdate:NO];
                    NSString *oldEmail = [_tableViewDic objectForKey:@"email"];
                    [ppBoundToMailBoxView setOldEmail:oldEmail];
                    if ([oldEmail length] >= 9) {
                        oldEmail = [NSString stringWithFormat:@"%@******%@",[oldEmail substringToIndex:1],
                                    [oldEmail substringFromIndex:([oldEmail length] - 8)]];
                    }
                    [[ppBoundToMailBoxView boundToMailBoxTextfield] setText:oldEmail];
                    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToMailBoxView atIndex:1002];
                    [ppBoundToMailBoxView showBoundToMailBoxViewByRight];
                    [ppBoundToMailBoxView release];
                    
                }
                else if([boundViewArray count] == 1)
                {
                    if ([[boundViewArray objectAtIndex:0] isEqualToString:@"phone"]) {
                        NSString *oldPhone = [_tableViewDic objectForKey:@"phone"];
                        PPBoundToPhoneView *ppBoundToPhoneView = [[PPBoundToPhoneView alloc] init];
                        [ppBoundToPhoneView setIsUpdate:YES];
                        [ppBoundToPhoneView setOldPhone:oldPhone];
                        if ([oldPhone length] >= 11) {
                            oldPhone = [NSString stringWithFormat:@"%@******%@",[oldPhone substringToIndex:3],[oldPhone substringFromIndex:9]];
                        }
                        [[ppBoundToPhoneView phoneNumberTextfield] setText:oldPhone];
                        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToPhoneView atIndex:1002];
                        [ppBoundToPhoneView showBoundToPhoneViewByRight];
                        [ppBoundToPhoneView setNextView:PPVerificationModeMailBox];
                        [ppBoundToPhoneView release];

                    }
                    else
                    {
                        PPSecretQuestionAnswerView *ppSecretQuestionAnswerView = [[PPSecretQuestionAnswerView alloc] init];
                        [ppSecretQuestionAnswerView setIsUpdate:YES];
                        [ppSecretQuestionAnswerView setQuestion1:[[_tableViewDic objectForKey:@"question_1"] integerValue]];
                        [ppSecretQuestionAnswerView setQuestion2:[[_tableViewDic objectForKey:@"question_2"] integerValue]];
                        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSecretQuestionAnswerView atIndex:1002];
                        [ppSecretQuestionAnswerView showSecretQuestionsAnswerViewByRight];
                        [ppSecretQuestionAnswerView setNextView:PPVerificationModeMailBox];
                        [ppSecretQuestionAnswerView release];
                    }
                }
                else
                {
                    PPBoundToWhatView *ppBoundToWhatView = [[PPBoundToWhatView alloc] init];
                    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToWhatView atIndex:1002];
                    [ppBoundToWhatView setNextViewArray:boundViewArray];
                    [ppBoundToWhatView setTableViewDic:_tableViewDic];
                    [ppBoundToWhatView setNextView:PPVerificationModeMailBox];
                    [ppBoundToWhatView showPPBoundToWhatViewByRight];
                    [ppBoundToWhatView release];
                }
                [boundViewArray release];
            }
            break;
        case 6:
            [self hiddenPasswordProtectionViewInLeft];
            
            if ([[_tableViewDic objectForKey:@"question_check"] integerValue] == 1 ) {
                PPSecretQuestionAnswerView *ppSecretQuestionAnswerView = [[PPSecretQuestionAnswerView alloc] init];
                [ppSecretQuestionAnswerView setIsUpdate:YES];
                [ppSecretQuestionAnswerView setQuestion1:[[_tableViewDic objectForKey:@"question_1"] integerValue]];
                [ppSecretQuestionAnswerView setQuestion2:[[_tableViewDic objectForKey:@"question_2"] integerValue]];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSecretQuestionAnswerView atIndex:1002];
                [ppSecretQuestionAnswerView showSecretQuestionsAnswerViewByRight];
                [ppSecretQuestionAnswerView setNextView:PPVerificationModeQuestion];
                [ppSecretQuestionAnswerView release];
                
            }
            else
            {
                NSMutableArray *boundViewArray= [[NSMutableArray alloc] init];
                
                if ([[_tableViewDic objectForKey:@"phone_check"] integerValue] == 1) {
                    [boundViewArray addObject:@"phone"];
                }
                if ([[_tableViewDic objectForKey:@"email_check"] integerValue] == 1) {
                    [boundViewArray addObject:@"email"];
                }
                
                if ([boundViewArray count] == 0) {
                    PPSecretQuestionAnswerView *ppSecretQuestionAnswerView = [[PPSecretQuestionAnswerView alloc] init];
                    [ppSecretQuestionAnswerView setIsUpdate:NO];
                    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSecretQuestionAnswerView atIndex:1002];
                    [ppSecretQuestionAnswerView showSecretQuestionsAnswerViewByRight];
                    [ppSecretQuestionAnswerView release];
                }
                else if([boundViewArray count] == 1)
                {
                    if ([[boundViewArray objectAtIndex:0] isEqualToString:@"phone"]) {
                        NSString *oldPhone = [_tableViewDic objectForKey:@"phone"];
                        PPBoundToPhoneView *ppBoundToPhoneView = [[PPBoundToPhoneView alloc] init];
                        [ppBoundToPhoneView setIsUpdate:YES];
                        [ppBoundToPhoneView setOldPhone:oldPhone];
                        if ([oldPhone length] >= 11) {
                            oldPhone = [NSString stringWithFormat:@"%@******%@",[oldPhone substringToIndex:3],[oldPhone substringFromIndex:9]];
                        }
                        [[ppBoundToPhoneView phoneNumberTextfield] setText:oldPhone];
                        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToPhoneView atIndex:1002];
                        [ppBoundToPhoneView showBoundToPhoneViewByRight];
                        [ppBoundToPhoneView setNextView:PPVerificationModeQuestion];
                        [ppBoundToPhoneView release];
                        
                    }
                    else
                    {
                        NSString *oldEmail = [_tableViewDic objectForKey:@"email"];
                        PPBoundToMailBoxView *ppBoundToMailBoxView = [[PPBoundToMailBoxView alloc] init];
                        [ppBoundToMailBoxView setOldEmail:oldEmail];
                        [ppBoundToMailBoxView setIsUpdate:YES];
                        if ([oldEmail length] >= 9) {
                            oldEmail = [NSString stringWithFormat:@"%@******%@",[oldEmail substringToIndex:1],
                                        [oldEmail substringFromIndex:([oldEmail length] - 8)]];
                        }
                        [[ppBoundToMailBoxView boundToMailBoxTextfield] setText:oldEmail];
                        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToMailBoxView atIndex:1002];
                        [ppBoundToMailBoxView showBoundToMailBoxViewByRight];
                        [ppBoundToMailBoxView setNextView:PPVerificationModeQuestion];
                        [ppBoundToMailBoxView release];
                    }
                }
                else
                {
                    PPBoundToWhatView *ppBoundToWhatView = [[PPBoundToWhatView alloc] init];
                    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToWhatView atIndex:1002];
                    [ppBoundToWhatView showPPBoundToWhatViewByRight];
                    [ppBoundToWhatView setNextViewArray:boundViewArray];
                    [ppBoundToWhatView setTableViewDic:_tableViewDic];
                    [ppBoundToWhatView setNextView:PPVerificationModeQuestion];
                    [ppBoundToWhatView release];
                }
                [boundViewArray release];

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
-(void)showPasswordProtectionViewByRight
{
    [super showViewByRight];
}

-(void)showPasswordProtectionViewByLeft
{
    [super showViewByLeft];
}

- (void)didHiddenView{
    [PPMBProgressHUD hideAllHUDsForView:self animated:YES];
    [super didHiddenView];
}


-(void)backButtonPressed
{
    [self hiddenPasswordProtectionViewInRight];
    PPCenterView *ppCenterView = [[PPCenterView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppCenterView atIndex:1002];
    [ppCenterView showCenterViewByLeft];
    [ppCenterView release];
}

-(void)hiddenPasswordProtectionViewInRight
{
    [super hiddenViewInRight];
}

- (void)hiddenPasswordProtectionViewInLeft
{
    [super hiddenViewInLeft];
}



- (void)didShowView{
    
}

#pragma mark - 获取用户安全级别 回调 -

- (void)userInfoSecuityCallBack:(NSDictionary *)paramDic
{
    if ([[paramDic objectForKey:@"error"] intValue] != 0) {
        [ppMBProgressHUD setLabelText:@"获取数据异常"];
        [ppMBProgressHUD hide:YES afterDelay:2];
        return;
    }
    [ppMBProgressHUD hide:YES];
    _tableViewDic = [[paramDic objectForKey:@"data"] retain];
    [_passwordProtectionSettingTableView setDelegate:self];
    [_passwordProtectionSettingTableView setDataSource:self];
    [_passwordProtectionSettingTableView reloadData];
}

- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError
{
    [ppMBProgressHUD setLabelText:@"网络异常,请尝试刷新"];
    NSString *string = [paramError localizedDescription];
    if (PP_ISNSLOG) {
        NSLog(@"ppHttpResponseDidFailWithErrorCallBack-%@",string);
    }
    [ppMBProgressHUD hide:YES afterDelay:1];
}

#pragma mark - dealloc -

-(void)dealloc
{
    if (PPDEALLOC_ISNSLOG) {
        NSLog(@"PPPasswordProtectionView dealloc");
    }
    [_tableViewDic release];
    _tableViewDic = nil;
    [super dealloc];
}



#pragma mark -  过期方法 -

///**
// 根据自己的情况决定跳转到哪一个页面
// @param viewArray 总共有哪些验证方式
// @param viewMark 自己是哪一种验证方式
// @return
// */
//- (void)decideWhichViewToJump:(NSArray *)viewArray WhoIAm:(PPVerificationMode)viewMark
//{
//    if ([viewArray count] == 0) {
//
//    }
//    else if([viewArray count] == 1)
//    {
//
//
//    }
//    else if([viewArray count] > 1)
//    {
//
//    }
//
//
//}



@end

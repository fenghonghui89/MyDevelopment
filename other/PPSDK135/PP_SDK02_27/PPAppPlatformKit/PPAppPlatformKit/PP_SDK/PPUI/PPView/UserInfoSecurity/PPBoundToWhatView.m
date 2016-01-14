//
//  PPBoundToWhatView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-12-10.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBoundToWhatView.h"
#import "PPCommon.h"
#import "PPPasswordProtectionView.h"
#import "PPBoundToPhoneView.h"
#import "PPBoundToMailBoxView.h"
#import "PPSecretQuestionAnswerView.h"

@implementation PPBoundToWhatView


- (id)init
{
    self = [super init];
    if (self) {
        
        [_titleLabel setText:@"密保设置"];
        [self.verticalLineLeftView setHidden:NO];
        [self.backButton setHidden:NO];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleSecretQuestionSetting"]];
        
        
        _nextViewArray = [[NSMutableArray alloc] init];
        _tableViewDic = [[NSDictionary alloc]init];
        
        _tableView = [[UITableView alloc] init];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setBounces:NO];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setShowsVerticalScrollIndicator:YES];
        _tableView.backgroundColor = [PPCommon getColor:@"f0eff3"];
        [_tableView setFrame:CGRectMake(0, 50, 320, 430)];
        [_tableView setContentSize:CGSizeMake(320, 600)];
        [_bgImageView addSubview:_tableView];
        [_tableView release];
  
        [self initVerticalFrame];
    }
    return self;
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -


-(void)initVerticalFrame
{
    [super initVerticalFrame];
    
    [_tableView setFrame:CGRectMake(0, 51, _bgImageView.frame.size.width, _bgImageView.frame.size.height - 51)];
    
}

-(void)initHorizontalFrame{
    [super initHorizontalFrame];
    [_tableView setFrame:CGRectMake(0, 51, _bgImageView.frame.size.width , _bgImageView.frame.size.height-51)];
}

#pragma mark - UITableViewDataSource ,UITableViewDelegate -

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置table view行高
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 44;
    if (indexPath.row == 0) {
        height = 35;
    }
//    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
//    if (indexPath.row == 0) {
//        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
//            return height - 9;
//        }
//        else if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
//        {
//            return height - 19;
//        }
//    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowNumber = indexPath.row;
    PPCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        cell = [[[PPCenterTableViewCell alloc] initWithDefaultType] autorelease];
        if ([indexPath row] > 0) {
            
            NSString *imageName = @"";
            NSString *titleString = @"";
            NSString *mark = @"";
            
            int tagOfcell = 2;
            switch (rowNumber) {
                case 0:
                    imageName = @"";
                    titleString = @"";
                    break;
                case 1:
                    mark = [_nextViewArray objectAtIndex:0];
                    break;
                case 2:
                    mark = [_nextViewArray objectAtIndex:1];
                    tagOfcell = 0;
                    break;
            }
            
            if ([mark isEqualToString:@"email"])
            {
                imageName = @"PPBoundToMail";
                titleString = @"验证邮箱";
            }
            else if([mark isEqualToString:@"phone"])
            {
                imageName = @"PPBoundToPhone";
                titleString = @"验证手机";
            }
            else if([mark isEqualToString:@"question"])
            {
                imageName = @"PPSecretQuestions";
                titleString = @"验证密保问题";
            }
            
            cell.tag = tagOfcell;
            [[cell titleLabel] setText:titleString];
            [cell.titleIamgeView setImage:[PPUIKit setLocaImage:imageName] ];
            
        }
        else
        {
            [cell.titleLabel setText:@""];
            [cell.valueLabel setText:@""];
            [cell.actionButton setHidden:YES];
            [cell.actionImageView setHidden:YES];
            cell.tag = 3;
        }
    }
    
    return cell ;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowNumber=indexPath.row;
    switch (rowNumber) {
        case 1:
            [self goToNextViewByMark:[_nextViewArray objectAtIndex:0]];
            break;
        case 2:
            [self goToNextViewByMark:[_nextViewArray objectAtIndex:1]];
            break;
        default:
            break;
    }
}

#pragma mark - 邮箱验证，手机验证，密保验证 -

-(void)goToNextViewByMark:(NSString *)mark
{
    [self hiddenPPPForgetWhatViewInLeft];



    if ([mark isEqualToString:@"email"])
    {
        PPBoundToMailBoxView *ppBoundToMailBoxView = [[PPBoundToMailBoxView alloc] init];
        [ppBoundToMailBoxView setIsUpdate:YES];
        NSString *oldEmail = [_tableViewDic objectForKey:@"email"];
        [ppBoundToMailBoxView setOldEmail:oldEmail];
        if ([oldEmail length] >= 9) {
            oldEmail = [NSString stringWithFormat:@"%@******%@",[oldEmail substringToIndex:1],
                        [oldEmail substringFromIndex:([oldEmail length] - 8)]];
        }
        [[ppBoundToMailBoxView boundToMailBoxTextfield] setText:oldEmail];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToMailBoxView atIndex:1002];
        [ppBoundToMailBoxView showBoundToMailBoxViewByRight];
        [ppBoundToMailBoxView setNextView:_nextView];
        [ppBoundToMailBoxView release];
    }
    else if([mark isEqualToString:@"phone"])
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
        [ppBoundToPhoneView setNextView:_nextView];
        [ppBoundToPhoneView release];
    }
    else if([mark isEqualToString:@"question"])
    {
        PPSecretQuestionAnswerView *ppSecretQuestionAnswerView = [[PPSecretQuestionAnswerView alloc] init];
        [ppSecretQuestionAnswerView setIsUpdate:YES];
        [ppSecretQuestionAnswerView setQuestion1:[[_tableViewDic objectForKey:@"question_1"] integerValue]];
        [ppSecretQuestionAnswerView setQuestion2:[[_tableViewDic objectForKey:@"question_2"] integerValue]];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSecretQuestionAnswerView atIndex:1002];
        [ppSecretQuestionAnswerView showSecretQuestionsAnswerViewByRight];
        [ppSecretQuestionAnswerView setNextView:_nextView];
        [ppSecretQuestionAnswerView release];
    }



}


#pragma mark  - 视图显示，隐藏，消失 -

/// <summary>
/// 选择验证方式页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showPPBoundToWhatViewByRight
{
    [super showViewByRight];
}

- (void)showPPBoundToWhatViewByLeft
{
    [super showViewByLeft];
}

- (void)didHiddenView{
    
    [super didHiddenView];
}
-(void)hiddenPPBoundToWhatViewInRight
{
    [super hiddenViewInRight];
}

- (void)hiddenPPPForgetWhatViewInLeft
{
    [super hiddenViewInLeft];
}

#pragma mark  - 关闭视图，返回上一层 -

-(void)backButtonPressed
{
    [self hiddenPPBoundToWhatViewInRight];
    PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
    [ppPasswordProtectionView showPasswordProtectionViewByLeft];
    [ppPasswordProtectionView release];
}

#pragma mark - dealloc  -

-(void)dealloc
{
    if (PPDEALLOC_ISNSLOG) {
        NSLog(@"PPBoundToWhatView dealloc");
    }

    [_nextViewArray release];
    _nextViewArray = nil;
    [_tableViewDic release];
    _tableViewDic = nil;
    [super dealloc];
}


@end

//
//  PPForgetWhat.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-7.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPForgetWhatView.h"
#import "PPCommon.h"
#import "PPUIKit.h"
#import "PPInputUserNameView.h"
#import "PPFindPassWordByTypeView.h"

@implementation PPForgetWhatView



- (id)init
{
    self = [super init];
    if (self) {
        
        [_titleLabel setText:@"忘记帐号/密码"];
        [self.verticalLineLeftView setHidden:NO];
        [self.backButton setHidden:NO];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleSecretQuestionSetting"]];
        
        
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

#pragma mark  - 视图显示，隐藏，消失 -

-(void)initVerticalFrame
{
    [super initVerticalFrame];
    
    [_tableView setFrame:CGRectMake(0, 51, _bgImageView.frame.size.width, _bgImageView.frame.size.height - 51)];
    
}

-(void)initHorizontalFrame{
    [super initHorizontalFrame];
    [_tableView setFrame:CGRectMake(0, 51, _bgImageView.frame.size.width , _bgImageView.frame.size.height-51)];
}

#pragma mark  - UITableViewDataSource , UITableViewDelegate -

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


//设置table view行高
-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 44;
//    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (indexPath.row == 0) {
//        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
//            return height - 9;
//        }
//        else if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
//        {
//            return height - 19;
//        }
        height = 35;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleString;
    int rowNumber = indexPath.row;
    PPCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[[PPCenterTableViewCell alloc] initWithDefaultType] autorelease];
        NSString *imageName;
        
        int tagOfcell = 2;
        switch (rowNumber) {
            case 0:
                imageName = nil;
                titleString = @"";
                tagOfcell = 3;
                break;
            case 1:
                imageName = @"PPForgetAccount";
                titleString = @"忘记帐号";
                break;
            case 2:
                imageName = @"PPForgetPassword";
                titleString = @"忘记密码";
                tagOfcell = 0;
                break;
            default:
                imageName = nil;
                titleString = @"";
                break;
                
        }
        cell.tag = tagOfcell;
        [[cell titleLabel] setText:titleString];
        [cell.titleIamgeView setImage:[PPUIKit setLocaImage:imageName] ];
        if (rowNumber == 0) {
            [cell.actionImageView setHidden:YES];
        }
        
    }
    return cell ;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowNumber=indexPath.row;
    switch (rowNumber) {
        case 1: //忘记账号
            [self hiddenPPPForgetWhatViewInLeft];
            
            PPFindPassWordByTypeView *ppFindPassWordByTypeView = [[PPFindPassWordByTypeView alloc] init];
            [ppFindPassWordByTypeView setCurrUserName:@""];
            [ppFindPassWordByTypeView setForgetUserNameOrPass:YES];
            [[[UIApplication sharedApplication] keyWindow] addSubview:ppFindPassWordByTypeView];
            [ppFindPassWordByTypeView showPPFindPassWordByTypeViewByRight];
            [ppFindPassWordByTypeView release];
            
            
            
            break;
        case 2://忘记密码
            [self hiddenPPPForgetWhatViewInLeft];
            
            PPInputUserNameView *ppInputUserNameView = [[PPInputUserNameView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] addSubview:ppInputUserNameView];
            [ppInputUserNameView showPPInputUserNameViewByRight];
            [ppInputUserNameView release];
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
-(void)showPPPForgetWhatViewByRight
{
    [super showViewByRight];
}

- (void)showPPPForgetWhatViewByLeft
{
    [super showViewByLeft];
}

- (void)didHiddenView{

    [super didHiddenView];
}

-(void)hiddenPPPForgetWhatViewInRight
{
    [super hiddenViewInRight];
}

- (void)hiddenPPPForgetWhatViewInLeft
{
    [super hiddenViewInLeft];
}

- (void)didShowView{
    
}
#pragma mark  - 关闭视图，返回上一层 -
-(void)backButtonPressed
{
    [self hiddenPPPForgetWhatViewInRight];
    PPLoginView *ppLoginView = [[PPLoginView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppLoginView atIndex:1000];
    [ppLoginView showLoginViewByLeft];
    [ppLoginView release];
}

#pragma mark - Dealloc -

-(void)dealloc{
    [_tableViewDic release];
    _tableViewDic = nil;
    [super dealloc];
}







@end

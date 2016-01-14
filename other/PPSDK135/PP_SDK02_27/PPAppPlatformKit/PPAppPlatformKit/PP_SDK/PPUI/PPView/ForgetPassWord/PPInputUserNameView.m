//
//  PPInputUserName.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-5.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPInputUserNameView.h"
#import "PPCommon.h"
#import "PPUIKit.h"
#import "PPFindPassWordByTypeView.h"
#import "PPForgetWhatView.h"

@implementation PPInputUserNameView


-(id)init{
    self = [super init];
    if (self) {
        
        [self.backButton setHidden:NO];
        
        [_titleLabel setText:@"输入用户名"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleModifyPassword"]];
        
        
        

        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [[_confirmButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
        [_confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_confirmButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonPressedown) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [_bgImageView addSubview:_confirmButton];
        
        _userNameImageView = [[UIImageView alloc] init];
        [_userNameImageView setUserInteractionEnabled:YES];
        [_bgImageView addSubview:_userNameImageView];
        [_userNameImageView release];
        
        

        
        _userNameLabel = [[UILabel alloc] init];
        [_userNameLabel setText:@"用户名:"];
        [_userNameLabel setFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]];
        [_userNameLabel setBackgroundColor:[UIColor clearColor]];
        [_userNameImageView addSubview:_userNameLabel];
        [_userNameLabel release];
        
        _userNameField = [[UITextField alloc] init];
        [_userNameField setDelegate:self];
        [_userNameField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_userNameField setFont:[UIFont systemFontOfSize:30.0 * (1 / 2.0)]];
        [_userNameField setReturnKeyType:UIReturnKeySend];
        [_userNameField setPlaceholder:@"请输入您的PP账号"];
        [_userNameField setTextAlignment:NSTextAlignmentLeft];
        _userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_userNameImageView addSubview:_userNameField];
        [_userNameField release];
        
        [_confirmButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"]
                                           stretchableImageWithLeftCapWidth:10 topCapHeight:10]
                                 forState:UIControlStateNormal];
        
        [_userNameImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxTop"]
                                     stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        
        [self initVerticalFrame];
        
    }
    return self;
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

//竖
-(void)initVerticalFrame
{
    [super initVerticalFrame];
    [_userNameImageView setFrame:CGRectMake(0, 85, _bgImageView.frame.size.width, 44)];
    [_confirmButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _userNameImageView.frame.origin.y + _userNameImageView.frame.size.height + 25,
                                       300, 44)];
    [_userNameLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [_userNameField setFrame:CGRectMake(_userNameLabel.frame.size.width + 10, 0,
                                       _userNameImageView.frame.size.width - _userNameLabel.frame.size.width - 10, 44)];
}


//横
-(void)initHorizontalFrame
{
    [super initHorizontalFrame];
    [_userNameImageView setFrame:CGRectMake(0, 75, _bgImageView.frame.size.width, 44)];
    [_confirmButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _userNameImageView.frame.origin.y + _userNameImageView.frame.size.height + 20,
                                       300, 44)];
    [_userNameLabel setFrame:CGRectMake(16, 0, 80, 44)];
    [_userNameField setFrame:CGRectMake(_userNameLabel.frame.size.width + 10, 0,
                                       _userNameImageView.frame.size.width - _userNameLabel.frame.size.width - 10, 44)];
}


#pragma mark  - 获取用户名 -
/**
 *确定按钮
 */
- (void)confirmButtonPressedown{
    NSString *message = @"";
    if(_userNameField.text == nil || ![_userNameField.text length]){
        message = @"用户名不能为空！";
        NSString *title = @"温馨提示";
        PPAlertView *alertView = [[PPAlertView alloc] initWithTitle:title message:message];
        [alertView setCancelButtonTitle:@"确定" block:^{
            [_userNameField becomeFirstResponder];
        }];
        [alertView addButtonWithTitle:nil block:nil];
        [alertView show];
        [alertView release];
        return;
    }
    [self hiddenPPInputUserNameViewInLeft];
    NSString *paramUserName = [_userNameField text];
    
    
    PPFindPassWordByTypeView *ppFindPassWordByTypeView = [[PPFindPassWordByTypeView alloc] init];
    [ppFindPassWordByTypeView setCurrUserName:paramUserName];
    [ppFindPassWordByTypeView setForgetUserNameOrPass:NO];
    [[[UIApplication sharedApplication] keyWindow] addSubview:ppFindPassWordByTypeView];
    [ppFindPassWordByTypeView showPPFindPassWordByTypeViewByRight];
    [ppFindPassWordByTypeView release];
}


#pragma mark  - 视图显示，隐藏，消失 -
-(void)hiddenPPInputUserNameViewInRight
{
    [super hiddenViewInRight];
}

-(void)showPPInputUserNameViewByRight
{

    [super showViewByRight];
}


-(void)hiddenPPInputUserNameViewInLeft
{
    [super hiddenViewInLeft];
}

-(void)showPPInputUserNameViewByLeft
{
    [super showViewByLeft];
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
    [self hiddenPPInputUserNameViewInRight];
    PPForgetWhatView *ppForgetWhatView = [[PPForgetWhatView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppForgetWhatView atIndex:1002];
    [ppForgetWhatView showPPPForgetWhatViewByLeft];
    [ppForgetWhatView release];
}
-(void)closeButtonPressed{
    [super closeButtonPressed];
}

#pragma mark  - UITextFieldDelegate -
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userNameField) {
        [self confirmButtonPressedown];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    if (field == _userNameField) {
        if ([characters isEqualToString:@" "]) {
            return NO;
        }
        return YES;
    }else{
        NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        return ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
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
        if (paramTextField == _userNameField)
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
    if ([_userNameField isFirstResponder]) {
        [self textChange:_userNameField];
    }
    
}

#pragma mark - Dealloc -

- (void)dealloc
{
    [super dealloc];
}


@end

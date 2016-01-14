//
//  PPSecretQuestionAnswerView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-1.
//  Copyright (c) 2013年 Server. All rights reserved.
//
#define msgChooseQuestion @"请选择问题"
#import "PPSecretQuestionAnswerView.h"
#import "PPSecretQuestionsView.h"
#import "PPUIKit.h"
#import "PPCommon.h"
#import "PPPasswordProtectionView.h"
#import "PPBoundToNextMailBoxView.h"
#import "PPBoundToNextPhoneView.h"


@implementation PPSecretQuestionAnswerView

-(id)init{
    self = [super init];
    if (self) {
        [self.backButton setHidden:NO];
        [_titleLabel setText:@"绑定密保问题"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleSecretQuestionSetting"]];
        [_bgImageView setClipsToBounds:YES];
        
        
        if (_questionArray) {
            [_questionArray release];
            _questionArray = nil;
        }
        _questionArray = [[NSMutableArray alloc] init];
        _questionStr1 = msgChooseQuestion;
        _questionStr2 = msgChooseQuestion;
        
        _questionImageView1 = [[UIImageView alloc] init];
        [_questionImageView1 setUserInteractionEnabled:YES];
        [_questionImageView1 setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:_questionImageView1];
        [_questionImageView1 release];
        
        
        _questionLabel1 = [[UILabel alloc] init];
        [_questionLabel1 setBackgroundColor:[UIColor clearColor]];
        [_questionLabel1 setText:@"问题1"];
        [_questionLabel1 setFont:[UIFont systemFontOfSize:15]];
        [_questionImageView1 addSubview:_questionLabel1];
        [_questionLabel1 release];
        
        _questionTextField1 = [[UITextField alloc] init];
        [_questionTextField1 setText:msgChooseQuestion];
        [_questionTextField1 setEnabled:NO];
        [_questionTextField1 setReturnKeyType:UIReturnKeyNext];
        [_questionTextField1 setDelegate:self];
        [_questionTextField1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_questionTextField1 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_questionTextField1 setFont:[UIFont systemFontOfSize:15]];
        [_questionImageView1 addSubview:_questionTextField1];
        [_questionTextField1 release];
        
        _questionDropDownView1 = [[PPDropDownView alloc] init];
        _questionDropDownView1.selectedIndex = -1;
        [_questionDropDownView1 setDelegate:self];
        [_bgImageView addSubview:_questionDropDownView1];
        [_questionDropDownView1 setIsOpen:NO];
        [_questionDropDownView1 release];
        
        
        
        _answerImageView1 = [[UIImageView alloc] init];
        [_answerImageView1 setUserInteractionEnabled:YES];
        [_answerImageView1 setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:_answerImageView1];
        [_answerImageView1 release];
        
        
        _answerLabel1 = [[UILabel alloc] init];
        [_answerLabel1 setBackgroundColor:[UIColor clearColor]];
        [_answerLabel1 setText:@"答案1"];
        [_answerLabel1 setFont:[UIFont systemFontOfSize:15]];
        [_answerImageView1 addSubview:_answerLabel1];
        [_answerLabel1 release];
        
        _answerTextField1 = [[UITextField alloc] init];
        [_answerTextField1 setPlaceholder:@"请输入答案"];
        [_answerTextField1 setReturnKeyType:UIReturnKeyNext];
        [_answerTextField1 setDelegate:self];
        [_answerTextField1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_answerTextField1 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_answerTextField1 setFont:[UIFont systemFontOfSize:15]];
        [_answerImageView1 addSubview:_answerTextField1];
        [_answerTextField1 release];
        
        _questionImageView2 = [[UIImageView alloc] init];
        [_questionImageView2 setUserInteractionEnabled:YES];
        [_questionImageView2 setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:_questionImageView2];
        [_questionImageView2 release];
        
        
        _questionLabel2 = [[UILabel alloc] init];
        [_questionLabel2 setBackgroundColor:[UIColor clearColor]];
        [_questionLabel2 setText:@"问题2"];
        [_questionLabel2 setFont:[UIFont systemFontOfSize:15]];
        [_questionImageView2 addSubview:_questionLabel2];
        [_questionLabel2 release];
        
        _questionTextField2 = [[UITextField alloc] init];
        [_questionTextField2 setEnabled:NO];
        [_questionTextField2 setText:msgChooseQuestion];
        [_questionTextField2 setReturnKeyType:UIReturnKeyNext];
        [_questionTextField2 setDelegate:self];
        [_questionTextField2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_questionTextField2 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_questionTextField2 setFont:[UIFont systemFontOfSize:15]];
        [_questionImageView2 addSubview:_questionTextField2];
        [_questionTextField2 release];
        
        
        
        _answerImageView2 = [[UIImageView alloc] init];
        [_answerImageView2 setUserInteractionEnabled:YES];
        [_answerImageView2 setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:_answerImageView2];
        [_answerImageView2 release];
        
        
        _answerLabel2 = [[UILabel alloc] init];
        [_answerLabel2 setBackgroundColor:[UIColor clearColor]];
        [_answerLabel2 setText:@"答案2"];
        [_answerLabel2 setFont:[UIFont systemFontOfSize:15]];
        [_answerImageView2 addSubview:_answerLabel2];
        [_answerLabel2 release];
        
        _answerTextField2 = [[UITextField alloc] init];
        [_answerTextField2 setPlaceholder:@"请输入答案"];
        [_answerTextField2 setReturnKeyType:UIReturnKeySend];
        [_answerTextField2 setDelegate:self];
        [_answerTextField2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_answerTextField2 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_answerTextField2 setFont:[UIFont systemFontOfSize:15]];
        [_answerImageView2 addSubview:_answerTextField2];
        [_answerTextField2 release];
        
        
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commitButton setTitle:@"确 定" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_commitButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]
                                 forState:UIControlStateNormal];
        [[_commitButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
        [_bgImageView addSubview:_commitButton];
        [_commitButton addTarget:self action:@selector(commitButtonTouchUpInside)
                forControlEvents:UIControlEventTouchUpInside];
        
        _listQuestionBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listQuestionBtn1 addTarget:self action:@selector(listQuestionBtn1PressedDown) forControlEvents:UIControlEventTouchUpInside];
        [_questionImageView1 addSubview:_listQuestionBtn1];
        
        _listQuestionBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listQuestionBtn2 addTarget:self action:@selector(listQuestionBtn2PressedDown) forControlEvents:UIControlEventTouchUpInside];
        [_questionImageView2 addSubview:_listQuestionBtn2];
        
        _questionDropDownView2 = [[PPDropDownView alloc] init];
        _questionDropDownView2.selectedIndex = -1;
        [_questionDropDownView2 setDelegate:self];
        [_bgImageView addSubview:_questionDropDownView2];
        [_questionDropDownView2 setIsOpen:NO];
        [_questionDropDownView2 release];
        
        [_listQuestionBtn1 setImage:[PPUIKit setLocaImage:@"PPArrowRight"] forState:UIControlStateNormal];
        [_listQuestionBtn2 setImage:[PPUIKit setLocaImage:@"PPArrowRight"] forState:UIControlStateNormal];
        
        
        ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        ppMBProgressHUD.labelText = @"正在获取问题列表...";
        [ppMBProgressHUD show:YES];
        
        PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
        [ppWebViewData setDelegate:self];
        [ppWebViewData getQuestionList];
        [ppWebViewData release];
        
        [self initVerticalFrame];
        
    }
    return self;
    
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

- (void) initVerticalFrame
{
    [super initVerticalFrame];
    
    float height = 44;
    [_questionImageView1 setFrame:CGRectMake(0,  85,
                                             _bgImageView.frame.size.width, height)];
    
    //界面的下拉按钮
    [_listQuestionBtn1 setFrame:CGRectMake(16, 0, _questionImageView1.frame.size.width - 16, height)];
    [_listQuestionBtn1 setImageEdgeInsets:UIEdgeInsetsMake(0, _listQuestionBtn1.frame.size.width - 25, 0, 16)];
    
    if ([_questionDropDownView1 isOpen])
    {
        [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y+_questionImageView1.frame.size.height, _questionImageView1.frame.size.width, [[_questionDropDownView1 items] count] * height )];
        
        int i = 0;
        int height = 0;
        if ([_questionDropDownView1.items count] > 0) {
            height = _questionDropDownView1.frame.size.height / [_questionDropDownView1.items count];
        }
        for (PPListItemView *itemView in [_questionDropDownView1 items]) {
            CGRect rect = [itemView frame];
            rect.size.width = _questionDropDownView1.frame.size.width;
            rect.size.height = height;
            
            rect.origin.y = height * i;
            [itemView setFrame:rect];
            i++;
        }
    }
    else{
        [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y+_questionImageView1.frame.size.height, _questionImageView1.frame.size.width, 0)];
    }
    [_questionTextField1 setFrame:CGRectMake(86, 2, _bgImageView.frame.size.width - 70 - 20, height)];
    [_answerImageView1 setFrame:CGRectMake(0,  _questionDropDownView1.frame.origin.y + _questionDropDownView1.frame.size.height,
                                           _bgImageView.frame.size.width, height)];
    [_answerTextField1 setFrame:CGRectMake(86, 2, _bgImageView.frame.size.width - 70 - 20, height)];
    
    [_questionImageView2 setFrame:CGRectMake(0,  _answerImageView1.frame.origin.y + _answerImageView1.frame.size.height,
                                             _bgImageView.frame.size.width, height)];
    
    [_listQuestionBtn2 setFrame:CGRectMake(16, 0, _questionImageView2.frame.size.width - 16, height)];
    [_listQuestionBtn2 setImageEdgeInsets:UIEdgeInsetsMake(0, _listQuestionBtn2.frame.size.width - 25, 0, 16)];
    
    
    if ([_questionDropDownView2 isOpen])
    {
        [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y+_questionImageView2.frame.size.height, _questionImageView2.frame.size.width, [[_questionDropDownView2 items] count] * height )];
        
        int i = 0;
        int height = 0;
        if ([_questionDropDownView2.items count] > 0) {
            height = _questionDropDownView2.frame.size.height / [_questionDropDownView2.items count];
        }
        for (PPListItemView *itemView in [_questionDropDownView2 items]) {
            CGRect rect = [itemView frame];
            rect.size.width = _questionDropDownView2.frame.size.width;
            rect.size.height = height;
            
            rect.origin.y = height * i;
            [itemView setFrame:rect];
            i++;
        }
    }
    else
    {
        [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y+_questionImageView2.frame.size.height, _questionImageView2.frame.size.width, 0)];
    }
    
    [_questionTextField2 setFrame:CGRectMake(86, 0, _bgImageView.frame.size.width - 70 - 20, height)];
    [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                           _bgImageView.frame.size.width, height)];
    [_answerTextField2 setFrame:CGRectMake(86, 2, _bgImageView.frame.size.width - 70 - 20, height)];
    [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                       _answerImageView2.frame.origin.y + 60,
                                       300, height)];
    
    [_questionLabel1 setFrame:CGRectMake(16, 0,70, height)];
    [_answerLabel1 setFrame:CGRectMake(16, 0,70, height)];
    [_questionLabel2 setFrame:CGRectMake(16, 0,70, height)];
    [_answerLabel2 setFrame:CGRectMake(16, 0,70, height)];
    
}

-(void)initHorizontalFrame
{
    [super initHorizontalFrame];
    float height = 35;
    
    [_questionImageView1 setFrame:CGRectMake(0,  44 + 20,
                                             _bgImageView.frame.size.width, height)];
    [_listQuestionBtn1 setFrame:CGRectMake(16, 0, _questionImageView1.frame.size.width - 16, height)];
    [_listQuestionBtn1 setImageEdgeInsets:UIEdgeInsetsMake(0, _listQuestionBtn1.frame.size.width - 25, 0, 16)];
    
    if ([_questionDropDownView1 isOpen])
    {
        [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y+_questionImageView1.frame.size.height, _questionImageView1.frame.size.width, [[_questionDropDownView1 items] count] * height )];
        
        int i = 0;
        int height = 0;
        if ([_questionDropDownView1.items count] > 0) {
            height = _questionDropDownView1.frame.size.height / [_questionDropDownView1.items count];
        }
        for (PPListItemView *itemView in [_questionDropDownView1 items]) {
            CGRect rect = [itemView frame];
            rect.size.width = _questionDropDownView1.frame.size.width;
            rect.size.height = height;
            
            rect.origin.y = height * i;
            [itemView setFrame:rect];
            i++;
        }
    }
    else
    {
        [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y+_questionImageView1.frame.size.height, _questionImageView1.frame.size.width, 0)];
    }
    
    [_questionTextField1 setFrame:CGRectMake(86, 0, _bgImageView.frame.size.width - 70 - 20, height)];
    [_answerImageView1 setFrame:CGRectMake(0,  _questionDropDownView1.frame.origin.y + _questionDropDownView1.frame.size.height,
                                           _bgImageView.frame.size.width, height)];
    [_answerTextField1 setFrame:CGRectMake(86, 2, _bgImageView.frame.size.width - 70 - 20, height)];
    
    [_questionImageView2 setFrame:CGRectMake(0,  _answerImageView1.frame.origin.y + _answerImageView1.frame.size.height,
                                             _bgImageView.frame.size.width, height)];
    [_listQuestionBtn2 setFrame:CGRectMake(16, 0, _questionImageView2.frame.size.width - 16, height)];
    [_listQuestionBtn2 setImageEdgeInsets:UIEdgeInsetsMake(0, _listQuestionBtn2.frame.size.width - 25, 0, 16)];
    if ([_questionDropDownView2 isOpen])
    {
        [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y+_questionImageView2.frame.size.height, _questionImageView2.frame.size.width, [[_questionDropDownView2 items] count] * height )];
        
        int i = 0;
        int height = 0;
        if ([_questionDropDownView2.items count] > 0) {
            height = _questionDropDownView2.frame.size.height / [_questionDropDownView2.items count];
        }
        for (PPListItemView *itemView in [_questionDropDownView2 items]) {
            CGRect rect = [itemView frame];
            rect.size.width = _questionDropDownView2.frame.size.width;
            rect.size.height = height;
            
            rect.origin.y = height * i;
            [itemView setFrame:rect];
            i++;
        }
    }
    else
    {
        [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y+_questionImageView2.frame.size.height, _questionImageView2.frame.size.width, 0)];
    }
    [_questionTextField2 setFrame:CGRectMake(86, 0, _bgImageView.frame.size.width - 70 - 20, height)];
    [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                           _bgImageView.frame.size.width, height)];
    [_answerTextField2 setFrame:CGRectMake(86, 2, _bgImageView.frame.size.width - 70 - 20, height)];
    [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2,
                                       _answerImageView2.frame.origin.y + 60,
                                       300, height)];
    
    [_questionLabel1 setFrame:CGRectMake(16, 0,70, height)];
    [_answerLabel1 setFrame:CGRectMake(16, 0,70, height)];
    [_questionLabel2 setFrame:CGRectMake(16, 0,70, height)];
    [_answerLabel2 setFrame:CGRectMake(16, 0,70, height)];
}


#pragma mark - 获取问题列表，验证问题，绑定问题  回调 -

- (void)listQuestionBtn1PressedDown
{
    
    [super singleRecognizerHandler];
    
    float itemViewsHeight = _questionImageView1.frame.size.height;
    float itemViewWidth = _questionImageView1.frame.size.width;
    
    if ([_questionDropDownView1 isOpen]) {
        
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        
        [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y + _questionImageView1.frame.size.height, _bgImageView.frame.size.width, 0)];
        [_answerImageView1 setFrame:CGRectMake(0,  _questionDropDownView1.frame.origin.y + _questionDropDownView1.frame.size.height,
                                               _bgImageView.frame.size.width, itemViewsHeight)];
        [_questionImageView2 setFrame:CGRectMake(0,  _answerImageView1.frame.origin.y + _answerImageView1.frame.size.height,
                                                 _bgImageView.frame.size.width, itemViewsHeight)];
        [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y + _questionImageView2.frame.size.height, _bgImageView.frame.size.width, _questionDropDownView2.frame.size.height)];
        [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                               _bgImageView.frame.size.width, itemViewsHeight)];
        [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _answerImageView2.frame.origin.y + 60, 300, itemViewsHeight)];
        [[_listQuestionBtn1 imageView] setTransform:CGAffineTransformMakeRotation(0)];
        [_questionDropDownView1 closeView];
        
        [UIView commitAnimations];
    }
    else{
        //在添加item之前，移除DropDownView上所有的视图。
        for (PPListItemView *view in [_questionDropDownView1 subviews]) {
            [view removeFromSuperview];
        }
        
        //在添加item之前移除所有的item
        [[_questionDropDownView1 items] removeAllObjects];
        int i = 0;
        for (NSDictionary *questionDic in _questionArray) {
            
            NSString *questionStr = [questionDic objectForKey:@"question"];
            if ([questionStr isEqualToString:[_questionTextField2 text]]) {
                continue;
            }
            [_questionDropDownView1 addItemWithButtonTitle:questionStr itemFrame:CGRectMake(0, itemViewsHeight * i, itemViewWidth, itemViewsHeight)];
            if ([questionStr isEqualToString:[_questionTextField1 text]]) {
                [ _questionDropDownView1 selectItem:i];
            }
            i++;
        }
        if ([_questionDropDownView2 isOpen]) {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            
            [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y + _questionImageView1.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight * i)];
            [_answerImageView1 setFrame:CGRectMake(0,  _questionDropDownView1.frame.origin.y + _questionDropDownView1.frame.size.height,
                                                   _bgImageView.frame.size.width, itemViewsHeight)];
            [_questionImageView2 setFrame:CGRectMake(0,  _answerImageView1.frame.origin.y + _answerImageView1.frame.size.height,
                                                     _bgImageView.frame.size.width, itemViewsHeight)];
            [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y + _questionImageView2.frame.size.height, _bgImageView.frame.size.width, 0)];
            [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                                   _bgImageView.frame.size.width, itemViewsHeight)];
            [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _answerImageView2.frame.origin.y + 60, 300, itemViewsHeight)];
            
            
            [[_listQuestionBtn1 imageView] setTransform:CGAffineTransformMakeRotation(1.57)];
            [[_listQuestionBtn2 imageView] setTransform:CGAffineTransformMakeRotation(0)];
            [_questionDropDownView1 openView];
            [_questionDropDownView2 closeView];
            
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y + _questionImageView1.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight * i)];
            [_answerImageView1 setFrame:CGRectMake(0,  _questionDropDownView1.frame.origin.y + _questionDropDownView1.frame.size.height,
                                                   _bgImageView.frame.size.width, itemViewsHeight)];
            [_questionImageView2 setFrame:CGRectMake(0,  _answerImageView1.frame.origin.y + _answerImageView1.frame.size.height,
                                                     _bgImageView.frame.size.width, itemViewsHeight)];
            [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y + _questionImageView2.frame.size.height, _bgImageView.frame.size.width, _questionDropDownView2.frame.size.height)];
            [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                                   _bgImageView.frame.size.width, itemViewsHeight)];
            [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _answerImageView2.frame.origin.y + 60, 300, itemViewsHeight)];
            [[_listQuestionBtn1 imageView] setTransform:CGAffineTransformMakeRotation(1.57)];
            
            [_questionDropDownView1 openView];
            [UIView commitAnimations];
        }
        
    }
}

- (void)listQuestionBtn2PressedDown
{
    [super singleRecognizerHandler];
    
    float itemViewsHeight = _questionImageView1.frame.size.height;
    float itemViewWidth = _questionImageView1.frame.size.width;
    
    if ([_questionDropDownView2 isOpen]) {
        
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y + _questionImageView1.frame.size.height, _bgImageView.frame.size.width, _questionDropDownView1.frame.size.height)];
        [_answerImageView1 setFrame:CGRectMake(0,  _questionDropDownView1.frame.origin.y + _questionDropDownView1.frame.size.height,
                                               _bgImageView.frame.size.width, itemViewsHeight)];
        [_questionImageView2 setFrame:CGRectMake(0,  _answerImageView1.frame.origin.y + _answerImageView1.frame.size.height,
                                                 _bgImageView.frame.size.width, itemViewsHeight)];
        [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y + _questionImageView2.frame.size.height, _bgImageView.frame.size.width, 0)];
        [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                               _bgImageView.frame.size.width, itemViewsHeight)];
        [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _answerImageView2.frame.origin.y + 60, 300, itemViewsHeight)];
        [[_listQuestionBtn2 imageView] setTransform:CGAffineTransformMakeRotation(0)];
        
        [_questionDropDownView2 closeView];
        
        [UIView commitAnimations];
    }
    else
    {
        for (PPListItemView *view in [_questionDropDownView2 subviews]) {
            [view removeFromSuperview];
        }
        [[_questionDropDownView2 items] removeAllObjects];
        int i = 0;
        for (NSDictionary *questionDic in _questionArray) {
            
            NSString *questionStr = [questionDic objectForKey:@"question"];
            
            NSString *testStr = [_questionTextField1 text];
            if ([questionStr isEqualToString:testStr]) {
                continue;
            }
            [_questionDropDownView2 addItemWithButtonTitle:questionStr itemFrame:CGRectMake(0, itemViewsHeight * i, itemViewWidth, itemViewsHeight)];
            if ([questionStr isEqualToString:[_questionTextField2 text]]) {
                [ _questionDropDownView2 selectItem:i];
            }
            i++;
        }
        if ([_questionDropDownView1 isOpen]) {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            
            [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y + _questionImageView1.frame.size.height, _bgImageView.frame.size.width, 0)];
            [_answerImageView1 setFrame:CGRectMake(0,  _questionDropDownView1.frame.origin.y + _questionDropDownView1.frame.size.height,
                                                   _bgImageView.frame.size.width, itemViewsHeight)];
            [_questionImageView2 setFrame:CGRectMake(0,  _answerImageView1.frame.origin.y + _answerImageView1.frame.size.height,
                                                     _bgImageView.frame.size.width, itemViewsHeight)];
            [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y + _questionImageView2.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight * i)];
            [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                                   _bgImageView.frame.size.width, itemViewsHeight)];
            [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _answerImageView2.frame.origin.y + 60, 300, itemViewsHeight)];
            
            
            [[_listQuestionBtn1 imageView] setTransform:CGAffineTransformMakeRotation(0)];
            [[_listQuestionBtn2 imageView] setTransform:CGAffineTransformMakeRotation(1.57)];
            [_questionDropDownView2 openView];
            [_questionDropDownView1 closeView];
            
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y + _questionImageView2.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight * i)];
            [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                                   _bgImageView.frame.size.width, itemViewsHeight)];
            [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _answerImageView2.frame.origin.y + 60, 300 , itemViewsHeight)];
            [[_listQuestionBtn2 imageView] setTransform:CGAffineTransformMakeRotation(1.57)];
            
            [_questionDropDownView2 openView];
            [UIView commitAnimations];
        }
    }
}

/**
 *  展开问题列表
 */
- (void)dropDownView:(PPDropDownView *)view
       selectedIndex:(NSInteger)index
            withInfo:(NSDictionary *)info{
    
    [view.selectedItem cancelSelectedState];
    view.selectedIndex = index;
    view.selectedItem = [view.items objectAtIndex:index];
    
    float itemViewsHeight = _questionImageView1.frame.size.height;
    
    if (view == _questionDropDownView1) {
        [_answerTextField1 becomeFirstResponder];
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [view closeView];
        [_questionDropDownView1 setFrame:CGRectMake(0, _questionImageView1.frame.origin.y + _questionImageView1.frame.size.height, _bgImageView.frame.size.width, 0)];
        [_answerImageView1 setFrame:CGRectMake(0,  _questionDropDownView1.frame.origin.y + _questionDropDownView1.frame.size.height,
                                               _bgImageView.frame.size.width, itemViewsHeight)];
        [_questionImageView2 setFrame:CGRectMake(0,  _answerImageView1.frame.origin.y + _answerImageView1.frame.size.height,
                                                 _bgImageView.frame.size.width, itemViewsHeight)];
        [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y + _questionImageView2.frame.size.height, _bgImageView.frame.size.width, _questionDropDownView2.frame.size.height)];
        [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                               _bgImageView.frame.size.width, itemViewsHeight)];
        [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _answerImageView2.frame.origin.y + 60, 300, itemViewsHeight)];
        [[_listQuestionBtn1 imageView] setTransform:CGAffineTransformMakeRotation(0)];
        [UIView commitAnimations];
        [_questionTextField1 setText:[info objectForKey:@"itemText"]];
        self.questionStr1 = [info objectForKey:@"itemText"];
    }
    else
    {
        [_answerTextField2 becomeFirstResponder];
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [view closeView];
        
        [_questionImageView2 setFrame:CGRectMake(0,  _answerImageView1.frame.origin.y + _answerImageView1.frame.size.height,
                                                 _bgImageView.frame.size.width, itemViewsHeight)];
        [_questionDropDownView2 setFrame:CGRectMake(0, _questionImageView2.frame.origin.y + _questionImageView2.frame.size.height, _bgImageView.frame.size.width, 0)];
        [_answerImageView2 setFrame:CGRectMake(0,  _questionDropDownView2.frame.origin.y + _questionDropDownView2.frame.size.height,
                                               _bgImageView.frame.size.width, itemViewsHeight)];
        [_commitButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, _answerImageView2.frame.origin.y + 60, 300, itemViewsHeight)];
        [[_listQuestionBtn2 imageView] setTransform:CGAffineTransformMakeRotation(0)];
        [UIView commitAnimations];
        [_questionTextField2 setText:[info objectForKey:@"itemText"]];
        self.questionStr2 = [info objectForKey:@"itemText"];
    }
    
}

- (void)commitButtonTouchUpInside
{
    
    if ([_questionStr1 isEqualToString:msgChooseQuestion] || [_questionStr2 isEqualToString:msgChooseQuestion]) {
        
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:@"请选择问题！"];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        
        [alert show];
        
        [alert release];
        
        return;
        
    }
    if ([_answerTextField1.text isEqualToString:@""] || [_answerTextField2.text isEqualToString:@""] || (_answerTextField1.text == nil) || (_answerTextField2.text == nil))
    {
        
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:@"答案不能为空！"];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        
        [alert show];
        
        [alert release];
        
        return;
    }
    
    
    
    if (self.isUpdate)
    {
        PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
        [ppWebViewData setDelegate:self];
        NSDictionary *questionDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInt:_question1],@"question_1",
                                            [NSNumber numberWithInt:_question2],@"question_2",
                                            _answerTextField1.text,@"answer_1",
                                            _answerTextField2.text,@"answer_2", nil];
        
        
        
        
        [ppWebViewData getChkUserQuestion:questionDictionary];
        [ppWebViewData release];
        
        ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        ppMBProgressHUD.labelText = @"加载中...";
    }
    else
    {
        
        for (NSDictionary *questionDic in _questionArray)
        {
            NSString *questionStr = [questionDic objectForKey:@"question"];
            int questionId = [[questionDic objectForKey:@"id"] intValue];
            
            if ([_questionStr1 isEqualToString:questionStr])
            {
                _question1 = questionId;
            }
            else if ([_questionStr2 isEqualToString:questionStr])
            {
                _question2 = questionId;
            }
        }
        
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ADDRESS message:@"是否确定设置密保问题？"];
        [alert setCancelButtonTitle:@"确定" block:^{
            PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
            [ppWebViewData setDelegate:self];
            [ppWebViewData getBindQuestion:_question1 Question_2:_question2 Answer_1:_answerTextField1.text Answer_2:_answerTextField2.text NextCode:@""];
            [ppWebViewData release];
            
            ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
            ppMBProgressHUD.labelText = @"加载中...";
        }];
        [alert addButtonWithTitle:@"取消" block:nil];
        
        [alert show];
        
        [alert release];
        
    }
}


#pragma mark  - 视图显示，隐藏，消失 -
/// <summary>
/// 密保问题页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showSecretQuestionsAnswerViewByRight{
    if (self.isUpdate) {

        [_listQuestionBtn1 setHidden:YES];
        [_listQuestionBtn2 setHidden:YES];
        
        [_questionDropDownView1 setHidden:YES];
        [_questionDropDownView2 setHidden:YES];
        
        [_titleLabel setText:@"验证密保问题"];
        
        [_commitButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    [super showViewByRight];
}

- (void)showSecretQuestionsAnswerViewByLeft
{
    [super showViewByLeft];
}

-(void)hiddenSecretQuestionsAnswerViewInLeft
{
    [super hiddenViewInLeft];
}


-(void)hiddenSecretQuestionsAnswerViewInRight
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
    [self hiddenSecretQuestionsAnswerViewInRight];
    PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
    [ppPasswordProtectionView showPasswordProtectionViewByLeft];
    [ppPasswordProtectionView release];
    
}

#pragma mark - UITextFieldDelegate -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _answerTextField1)
    {
        [_answerTextField2 becomeFirstResponder];
    }
    else if (textField == _answerTextField2)
    {
        [self commitButtonTouchUpInside];
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
        if (paramTextField == _answerTextField1)
        {
            [self rollupView:70];
        }
        else if (paramTextField == _answerTextField2)
        {
            [self rollupView:120];
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
    if ([_answerTextField1 isFirstResponder])
    {
        [self textChange:_answerTextField1];
    }
    else if ([_answerTextField2 isFirstResponder])
    {
        [self textChange:_answerTextField2];
    }
}

#pragma mark - 获取问题列表，验证问题，绑定问题  回调 -

- (void)checkUserQuestionCallBack:(NSDictionary *)paramDic
{
    if (PP_ISNSLOG) {
        NSLog(@"paramDic----checkUserQuestionCallBack----%@",paramDic);
    }
    [ppMBProgressHUD hide:YES];
    if ([[paramDic objectForKey:@"error"] integerValue] == 0) {
        
        [self hiddenSecretQuestionsAnswerViewInLeft];
        PPSecretQuestionsView *ppSecretQuestionsView = [[PPSecretQuestionsView alloc] init];
        PPBoundToNextMailBoxView *ppBoundToNextMailBoxView = [[PPBoundToNextMailBoxView alloc] init];
        PPBoundToNextPhoneView *ppBoundToNextPhoneView = [[PPBoundToNextPhoneView alloc] init];
        switch (_nextView) {
            case PPVerificationModeQuestion:
                
                [ppSecretQuestionsView setNextCode:[[paramDic objectForKey:@"data"] objectForKey:@"nextCode"]];
                [ppSecretQuestionsView showSecretQuestionsViewByRight];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSecretQuestionsView atIndex:1002];
                break;
            case PPVerificationModeMailBox:
                //                [PPBoundToNextMailBoxView sharedInstance];
                [ppBoundToNextMailBoxView setNextCode:[[paramDic objectForKey:@"data"] objectForKey:@"nextCode"]];
                [ppBoundToNextMailBoxView showBoundToNextMailBoxViewByRight];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToNextMailBoxView atIndex:1002];
                
                break;
            case PPVerificationModePhone:
                [ppBoundToNextPhoneView setNextCode:[[paramDic objectForKey:@"data"] objectForKey:@"nextCode"]];
                [ppBoundToNextPhoneView showBoundToNextPhoneViewByRight];
                [[[UIApplication sharedApplication] keyWindow] insertSubview:ppBoundToNextPhoneView atIndex:1002];
                break;
        }
        [ppSecretQuestionsView release];
        [ppBoundToNextMailBoxView release];
        [ppBoundToNextPhoneView release];
        
    }
    else
    {
        NSString *message = [paramDic objectForKey:@"msg"];
        
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:message];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
}

- (void)bindQuestionCallBack:(NSDictionary *)paramDic
{
    NSLog(@"paramDic----bindQuestionCallBack----%@",paramDic);
    [ppMBProgressHUD hide:YES];
    NSString *message = [paramDic objectForKey:@"msg"];
    
    PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:message];
    [alert setCancelButtonTitle:@"确定" block:^{
        if ([[paramDic objectForKey:@"error"] intValue] == 0) {
            [self hiddenViewInRight];
            PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
            [ppPasswordProtectionView showPasswordProtectionViewByLeft];
            [ppPasswordProtectionView release];
        }
    }];
    [alert addButtonWithTitle:nil block:nil];
    [alert show];
    [alert release];
    
}

- (void)questionListCallBack:(NSDictionary *)paramDic
{
    [ppMBProgressHUD hide:YES];
    if (PP_ISNSLOG) {
        NSLog(@"paramDic------questionList---%@",paramDic);
    }
    if ([[paramDic objectForKey:@"error"] intValue] == 0)
    {
        [_questionArray removeAllObjects];
        
        //        NSArray *dataArray = [paramDic objectForKey:@"data"];
        _questionArray = [[NSMutableArray arrayWithArray:[paramDic objectForKey:@"data"]] retain];
        if (self.isUpdate)
        {
            int tag = 0;
            for (NSDictionary *questionDic in _questionArray)
            {
                NSString *questionStr = [questionDic objectForKey:@"question"];
                int questionId = [[questionDic objectForKey:@"id"] intValue];
                
                if ( _question1 == questionId)
                {
                    [_questionTextField1 setText:questionStr];
                    _questionStr1 = questionStr;
                    tag ++;
                }
                if ( _question2 == questionId)
                {
                    [_questionTextField2 setText:questionStr];
                    _questionStr2 = questionStr;
                    tag ++;
                }
                if (tag >= 2) {
                    break;
                }
            }
            
        }
    }
    else
    {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:[paramDic objectForKey:@"msg"]];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        
        [alert show];
        
        [alert release];
        
    }
    
}

- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError
{
    [ppMBProgressHUD setLabelText:@"网络异常,请尝试刷新"];
    NSString *string = [paramError localizedDescription];
    if (PP_ISNSLOG) {
        NSLog(@"ppHttpResponseDidFailWithErrorCallBack-%@",string);
    }
    [ppMBProgressHUD hide:YES afterDelay:2];
}

#pragma mark - dealloc -

-(void)dealloc
{
    if (PPDEALLOC_ISNSLOG) {
        NSLog(@"PPSecretQuestionAnswerView dealloc");
    }
    [_questionArray release];
    _questionArray = nil;
    [super dealloc];


}

#pragma mark - 过期方法 -

- (void)showSelfAgain{
    PPSecretQuestionsView *ppSecretQuestionsView = [[PPSecretQuestionsView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSecretQuestionsView atIndex:1002];
    [ppSecretQuestionsView showSecretQuestionsViewByRight];
    [ppSecretQuestionsView release];
}
///// <summary>
///// 密保问题页面从左边展示
///// </summary>
///// <returns>无返回</returns>
//-(void)showSecretQuestionsViewByLeft;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
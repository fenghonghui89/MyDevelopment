//
//  PPBaseView.h
//  PPAppPlatformKit
//
//  Created by seven  mr on 2/3/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <TeironSDK/keyvalue/TRKeyValue.h>
#import <TeironSDK/user/TRUserHelper.h>
#import <TeironSDK/user/TRUserInfo.h>
#import <TeironSDK/util/TRUtil.h>
#import <TeironSDK/user/TRUserRequest.h>
#import "PPAlertView.h"
#import "PPUIKit.h"

//#import "PPCommon.h"


#define noDisableVerticalScrollTag 836913
#define noDisableHorizontalScrollTag 836914

/**
 *  其他视图的父类视图
 */
@interface PPBaseView : UIView
<
UIGestureRecognizerDelegate,
UITextFieldDelegate
>
{
    UIView *_mainView;
    UIView *_topView;
    UIImageView *_bgImageView;
    UIButton *_closeButton;
    UIButton * _backButton;
    UIImageView *_horizontalLineView;

    UIImageView *_verticalLineRightView;
    UIView *_titleView;
    UILabel *_titleLabel;
    UIImageView *_titleImage;
    BOOL _keyBoardIsShow;
    int _rollupOffset;
    UIInterfaceOrientation _paramInterfaceOrientation;
    BOOL _isShowNow;
    float _keyBoardHeight;
    //记录自定义键盘Done按钮-去动态键盘高度的Y值
    float _keyBoardHiddenButtonY;
    UIButton *_keyBoardHiddenButton;
    
    
}

@property (nonatomic, retain) UIButton *backButton;
@property (nonatomic, retain) UIImageView *verticalLineLeftView;

/**
 *  添加，删除 通知
 */
-(void)addObserver;
-(void)removeObserver;

/**
 *  设备旋转 调整视图的位置和尺寸
 */

-(void)onDeviceOrientationChange:(BOOL)animated;

-(void)initVerticalFrame;

-(void)initHorizontalFrame;

/**
 *  视图显示，隐藏，消失
 */
-(void)hiddenViewInRight;
//从右边展示
-(void)showViewByRight;
//消失到左边
-(void)hiddenViewInLeft;
//从左边展示
-(void)showViewByLeft;
//已消失
-(void)didHiddenView;
//已显示
-(void)didShowView;

/**
 *   点击手势事件 ，重置视图，上卷下卷视图
 */

-(void)rollupView:(int)height;

-(void)revertView;

-(void)singleRecognizerHandler;

/**
 *  关闭视图，返回上一层
 */

-(void)closeButtonPressed;

-(void)backButtonPressed;

/**
 * 键盘通知事件
 */

- (void)keyboardWillHideCallBack:(NSNotification *)noti;

- (void)keyboardWillShowCallBack:(NSNotification *)noti;

- (void)keyboardDidShowCallBack:(NSNotification *)noti;

- (void)_keyBoardHiddenButtonTouchUpInside;
@end

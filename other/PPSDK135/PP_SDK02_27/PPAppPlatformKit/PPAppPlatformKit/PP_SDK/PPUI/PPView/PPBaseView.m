//
//  PPBaseView.m
//  PPAppPlatformKit
//
//  Created by seven  mr on 2/3/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPBaseView.h"
#import "PPUIKit.h"
#import "PPAppPlatformKitConfig.h"
#import "PPAppPlatformKit.h"
#import "PPCommon.h"

@interface PPBaseView ()

- (void)backButtonPressed;

@end

@implementation PPBaseView

-(id)init
{
    self = [super init];
    if (self) {
        /**
         *初始化父类公共部分并且添加旋屏通知
         */

    
         _mainView = [[UIView alloc] init];
        [_mainView setClipsToBounds:YES];
        [self addSubview:_mainView];
        [_mainView release];
     
        
        

        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = COLOR(248, 248, 248, 1.0);
        [_bgImageView setClipsToBounds:YES];
        
        
        [[_bgImageView layer] setBorderWidth:0.8];
        [[_bgImageView layer] setBorderColor:[[PPCommon getColor:@"c7c7c7"] CGColor]];
        
        [_bgImageView setUserInteractionEnabled:YES];
        [_bgImageView setBackgroundColor:[PPCommon getColor:@"F0EFF3"]];
        [_mainView addSubview:_bgImageView];
        [_bgImageView release];

        
        
        UIView *viewHiddenKeyBoard = [[UIView alloc] init];
        [viewHiddenKeyBoard setFrame:CGRectMake(0, 0, 1000, 1000)];
        [_bgImageView addSubview:viewHiddenKeyBoard];
        [viewHiddenKeyBoard release];

        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(singleRecognizerHandler)];
        singleRecognizer.numberOfTapsRequired = 1;
        [viewHiddenKeyBoard addGestureRecognizer:singleRecognizer];
        [singleRecognizer release];

        
        
        
        _topView = [[UIView alloc] init];
        [_topView setBackgroundColor:[UIColor whiteColor]];
        [_bgImageView addSubview:_topView];
        [_topView release];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [_closeButton setHighlighted:YES];
        [_closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:_closeButton];
        [_closeButton setImage:[PPUIKit setLocaImage:@"PPViewClose"]
                         forState:UIControlStateNormal];
        
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setHighlighted:YES];
        [_backButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [_backButton setImage:[PPUIKit setLocaImage:@"PPBackButton"]
                    forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:_backButton];
        [_backButton setHidden:YES];
        
        _verticalLineLeftView = [[UIImageView alloc] init];
        [_verticalLineLeftView setImage:[PPUIKit setLocaImage:@"PPVerticalLine"]];
        _verticalLineLeftView.frame = CGRectMake(50, 5, 1.0, 45);
        [_topView addSubview:_verticalLineLeftView];
        [_verticalLineLeftView release];
        
        _verticalLineRightView = [[UIImageView alloc] init];
        [_verticalLineRightView setImage:[PPUIKit setLocaImage:@"PPVerticalLine"]];
        _verticalLineRightView.frame = CGRectMake(_bgImageView.frame.size.width - 50, 5, 1.0, 45);
        _verticalLineRightView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_topView addSubview:_verticalLineRightView];
        [_verticalLineRightView release];
        
        _horizontalLineView = [[UIImageView alloc] init];
        [_horizontalLineView setImage:[PPUIKit setLocaImage:@"PPHorizontalLine"]];
        _horizontalLineView.frame = CGRectMake(0, 49, _bgImageView.frame.size.width, 1.0);
        _horizontalLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_topView addSubview:_horizontalLineView];
        [_horizontalLineView release];
        
        
        _titleView = [[UIView alloc] init];
        [_topView addSubview:_titleView];
        [_titleView release];
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleView addSubview:_titleLabel];
        [_titleLabel release];
        
        _titleImage = [[UIImageView alloc] init];
        _titleImage.backgroundColor = [UIColor clearColor];
        _titleImage.contentMode = UIViewContentModeRight;
        [_titleView addSubview:_titleImage];
        [_titleImage release];
        
        _keyBoardHiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_keyBoardHiddenButton addTarget:self action:@selector(_keyBoardHiddenButtonTouchUpInside)
                        forControlEvents:UIControlEventTouchUpInside];
        [_keyBoardHiddenButton setImage:[PPUIKit setLocaImage:@"KeyBoardHiddenButton_pressed"] forState:UIControlStateNormal];
        [_keyBoardHiddenButton setImage:[PPUIKit setLocaImage:@"KeyBoardHiddenButton_normal"] forState:UIControlStateHighlighted];

        [self addSubview:_keyBoardHiddenButton];
        if (ISIPAD) {
            [_keyBoardHiddenButton setHidden:YES];
        }
        [self initVerticalFrame];
        


    }
    return self;
}

#pragma mark - 添加 ，删除 通知 -

-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideCallBack:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowCallBack:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowCallBack:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
}

-(void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
}


#pragma mark - 设备旋转 调整视图的位置和尺寸 -

-(void)initVerticalFrame{
    
    /**
     *父类竖屏加载
     *首先区分设备是iPad还是iPhone
     *判断键盘是否当前展示。并做键盘弹出旋屏后页面处理
     */
    _paramInterfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        [_mainView setFrame:CGRectMake(UI_IPAD_SCREEN_X, UI_IPAD_SCREEN_Y, UI_IPHONE_SCREEN_WIDTH, UI_IPHONE_SCREEN_HEIGHT)];
//        [_bgImageView setFrame:CGRectMake(0, 0, UI_IPHONE_SCREEN_WIDTH, UI_IPHONE_SCREEN_HEIGHT)];
//    }else{
//        [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
//        [_bgImageView setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
//    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [_bgImageView setFrame:CGRectMake(UI_IPAD_SCREEN_X, UI_IPAD_SCREEN_Y, UI_IPHONE_SCREEN_WIDTH, UI_IPHONE_SCREEN_HEIGHT)];
        [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        [[_mainView viewWithTag:10] setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT + 200, UI_SCREEN_WIDTH)];
    }else{
        [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        [_bgImageView setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }
    [_closeButton setFrame:CGRectMake(_bgImageView.frame.size.width - 50, 0, 50, 50)];
    [_backButton setFrame:CGRectMake(0, 0, 50, 50)];
    [_topView setFrame:CGRectMake(0, 0, _bgImageView.frame.size.width, 50)];
    _horizontalLineView.frame = CGRectMake(0, 50, _bgImageView.frame.size.width, 1.0);
    [_titleView setFrame:CGRectMake(50, 0, _bgImageView.frame.size.width - 50 * 2, 50)];
    [_titleLabel sizeToFit];
    [_titleImage sizeToFit];
    [_titleLabel setFrame:CGRectMake(_titleView.frame.size.width / 2 - _titleLabel.frame.size.width / 2 + 15,
                                     0, _titleLabel.frame.size.width + 18, 50)];
    [_titleImage setFrame:CGRectMake(_titleLabel.frame.origin.x - 55, 0, 50, 50)];
    [_keyBoardHiddenButton setFrame:CGRectMake(_bgImageView.frame.size.width - 70, _bgImageView.bounds.size.height,
                                               70, 40)];
    if (_keyBoardIsShow) {

        UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                [self setFrame:CGRectMake(_rollupOffset, 0,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
                [self setFrame:CGRectMake(- _rollupOffset, 0,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else{
                [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
            }
        }else{
            if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                [self setFrame:CGRectMake(_rollupOffset, 0,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
                [self setFrame:CGRectMake(- _rollupOffset, 0,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else if (interfaceOrientation == UIInterfaceOrientationPortrait) {
                [self setFrame:CGRectMake(0, - _rollupOffset,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
                [self setFrame:CGRectMake(0,  _rollupOffset,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }
        }
    }else{
        [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }
}

-(void)initHorizontalFrame{
    /**
     *父类横屏屏加载
     *首先区分设备是iPad还是iPhone
     *判断键盘是否当前展示。并做键盘弹出旋屏后页面处理
     */
    
    _paramInterfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        //iPad处理部分
//        [_mainView setFrame:CGRectMake(UI_IPAD_SCREEN_Y, UI_IPAD_SCREEN_X,UI_IPHONE_SCREEN_HEIGHT, UI_IPHONE_SCREEN_WIDTH)];
//        [_bgImageView setFrame:CGRectMake(0, 0, UI_IPHONE_SCREEN_HEIGHT, UI_IPHONE_SCREEN_WIDTH)];
//        
//    }else{
//        //iPhone处理部分
//        [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)];
//        [_bgImageView setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)];
//    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //iPad处理部分
        [_bgImageView setFrame:CGRectMake(UI_IPAD_SCREEN_Y, UI_IPAD_SCREEN_X,UI_IPHONE_SCREEN_HEIGHT, UI_IPHONE_SCREEN_WIDTH)];
        [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)];
        [[_mainView viewWithTag:10] setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT + 200, UI_SCREEN_WIDTH)];
        
    }else{
        //iPhone处理部分
        [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)];
        [_bgImageView setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)];
    }
    [_topView setFrame:CGRectMake(0, 0, _bgImageView.frame.size.width, 50)];
    [_titleView setFrame:CGRectMake(50, 0, _bgImageView.frame.size.width - 50 * 2, 50)];
    [_titleLabel sizeToFit];
    [_titleImage sizeToFit];
    [_titleLabel setFrame:CGRectMake(_titleView.frame.size.width / 2 - _titleLabel.frame.size.width / 2 + 15,
                                     0, _titleLabel.frame.size.width + 18, 50)];
    [_titleImage setFrame:CGRectMake(_titleLabel.frame.origin.x - 55, 0, 50, 50)];
    _horizontalLineView.frame = CGRectMake(0, 50, _bgImageView.frame.size.width, 1.0);
    [_closeButton setFrame:CGRectMake(_bgImageView.frame.size.width - 50, 0, 50, 50)];
    [_backButton setFrame:CGRectMake(0, 0, 50, 50)];
    [_keyBoardHiddenButton setFrame:CGRectMake(_bgImageView.frame.size.width - 70, _bgImageView.bounds.size.height,
                                               70, 40)];
    if (_keyBoardIsShow) {
        UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                [self setFrame:CGRectMake(0  + _rollupOffset, 0,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
                [self setFrame:CGRectMake(0  - _rollupOffset, 0,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else{
                [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
            }
        }else{
            if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                [self setFrame:CGRectMake(0 + _rollupOffset, 0,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
                [self setFrame:CGRectMake(0  - _rollupOffset, 0,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else if (interfaceOrientation == UIInterfaceOrientationPortrait) {
                [self setFrame:CGRectMake(0, - _rollupOffset,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
                [self setFrame:CGRectMake(0, + _rollupOffset,
                                          UI_SCREEN_WIDTH,
                                          UI_SCREEN_HEIGHT)];
            }
        }
        
    }else{
        [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }
}
/**
 *  设备旋转通知事件
 *
 *  @param paramAnimated 支持/关闭 动画
 */
-(void)onDeviceOrientationChange:(BOOL)paramAnimated {

    /**
     *页面旋屏通知回调
     *首先判断是否开启允许旋屏
     *判断旋转后当前状态栏方向。根据方向旋转View，并加载坐标
     */
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    NSString *animationsStr = [NSString stringWithFormat:@"%@OnDeviceOrientationChange",
                               NSStringFromClass([self class])];
    if (paramAnimated)
    {
        [UIView beginAnimations:animationsStr context:nil];
        NSTimeInterval duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
        [UIView setAnimationDuration:duration];
        if (PP_ISNSLOG) {
            NSLog(@"旋转了%d - -%f",paramAnimated ? 100 : 99,duration);
        }

        switch (_paramInterfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                    [UIView setAnimationDuration:duration * 2];
                }
                break;
            case UIInterfaceOrientationLandscapeRight:
                if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
                    [UIView setAnimationDuration:duration * 2];
                }
                break;
            case UIInterfaceOrientationPortrait:
                if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
                    [UIView setAnimationDuration:duration * 2];
                }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                if (interfaceOrientation == UIInterfaceOrientationPortrait) {
                    [UIView setAnimationDuration:duration * 2];
                }
                break;
                
            default:
                [UIView setAnimationDuration:duration];
                break;
        }

    }
        

    
    if(interfaceOrientation == UIDeviceOrientationPortrait)
    {
        if ([PPUIKit getIsDeviceOrientationPortrait]) {
            [self setTransform:CGAffineTransformMakeRotation(0)];
            [self initVerticalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        if ([PPUIKit getIsDeviceOrientationPortraitUpsideDown]) {
            [self setTransform:CGAffineTransformMakeRotation(M_PI)];
            [self initVerticalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeLeft)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeLeft]) {
            [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
            [self initHorizontalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeRight)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeRight]) {
            [self setTransform:CGAffineTransformMakeRotation(- M_PI_2)];
            [self initHorizontalFrame];
        }
    }
    
    if (paramAnimated) {
        [UIView commitAnimations];
    }
}

#pragma mark  - 视图显示，隐藏，消失 -
//消失到右边
-(void)hiddenViewInRight
{
    [_backButton setEnabled:NO];
    [_closeButton setEnabled:NO];
    [self removeObserver];
    [PPUIKit clostKeyBoard];
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    [UIView beginAnimations:@"hiddenView" context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationFinished: finished: context:)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView setAnimationDuration:0.8];
    }else{
        [UIView setAnimationDuration:0.4];
    }
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self setFrame:CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(-UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self setFrame:CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self setFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

//从右边展示
-(void)showViewByRight
{
    [_backButton setEnabled:NO];
    [_closeButton setEnabled:NO];
    if (_isShowNow) {
        
        return;
    }
    [self addObserver];
    _isShowNow = YES;
    [self onDeviceOrientationChange:NO];
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    [UIView beginAnimations:@"showView" context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationFinished: finished: context:)];
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self setFrame:CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(-UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self setFrame:CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self setFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView setAnimationDuration:0.8];
    }else{ 
        [UIView setAnimationDuration:0.4];
    }
    [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

//消失到左边
-(void)hiddenViewInLeft
{
    [self removeObserver];
    [PPUIKit clostKeyBoard];
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    [UIView beginAnimations:@"hiddenView" context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationFinished: finished: context:)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView setAnimationDuration:0.8];
    }else{
        [UIView setAnimationDuration:0.4];
    }
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self setFrame:CGRectMake(-UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self setFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self setFrame:CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

//从左边展示
-(void)showViewByLeft
{

    if (_isShowNow) {
        return;
    }
    [self addObserver];
    _isShowNow = YES;
    [self onDeviceOrientationChange:NO];
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    [UIView beginAnimations:@"showView" context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationFinished: finished: context:)];
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self setFrame:CGRectMake(-UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(UI_SCREEN_WIDTH, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self setFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self setFrame:CGRectMake(0, -UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    }
    

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [UIView setAnimationDuration:0.8];
    }else{
        [UIView setAnimationDuration:0.4];
    }
    [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}




-(void)didHiddenView
{
    _isShowNow = NO;
    [self removeObserver];
    [self removeFromSuperview];

}

-(void)didShowView
{
    _isShowNow = YES;
}


#pragma mark - 点击手势事件 ，重置视图，上卷下卷视图 -

-(void)singleRecognizerHandler
{
    [PPUIKit clostKeyBoard];
    [self revertView];
}

-(void)rollupView:(int)height
{

    _rollupOffset = height;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [_keyBoardHiddenButton setFrame:CGRectMake(self.bounds.size.width - 70,
                                                   _keyBoardHiddenButtonY - 40 + _rollupOffset ,
                                                   70, 40)];
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.25f];
        UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
        if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            [self setFrame:CGRectMake(0  + _rollupOffset, 0,
                                      UI_SCREEN_WIDTH,
                                      UI_SCREEN_HEIGHT)];
        }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
            [self setFrame:CGRectMake(0  - _rollupOffset, 0,
                                      UI_SCREEN_WIDTH,
                                      UI_SCREEN_HEIGHT)];
        }
        else if (interfaceOrientation == UIInterfaceOrientationPortrait) {
            [self setFrame:CGRectMake(0,  - _rollupOffset,
                                      UI_SCREEN_WIDTH,
                                      UI_SCREEN_HEIGHT)];
        }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
            [self setFrame:CGRectMake(0,  _rollupOffset,
                                      UI_SCREEN_WIDTH,
                                      UI_SCREEN_HEIGHT)];
        }
        [UIView commitAnimations];
        
    }
    else
    {
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.25f];
        UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
        _rollupOffset = 30;
        if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            [self setFrame:CGRectMake(0 + 100 + _rollupOffset, 0,
                                      UI_SCREEN_WIDTH,
                                      UI_SCREEN_HEIGHT)];
        }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
            [self setFrame:CGRectMake(0 - 100 - _rollupOffset, 0,
                                      UI_SCREEN_WIDTH,
                                      UI_SCREEN_HEIGHT)];
        }
        [UIView commitAnimations];
    }
    
}

-(void)revertView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.25f];
    if (ISIPHONE) {
        [self setFrame:CGRectMake(0, 0 ,
                                  UI_SCREEN_WIDTH,
                                  UI_SCREEN_HEIGHT)];
    }else{
        [self setFrame:CGRectMake(0, 0 ,
                                  UI_SCREEN_WIDTH,
                                  UI_SCREEN_HEIGHT)];
    }

    [UIView commitAnimations];
}

#pragma mark  - 关闭视图，返回上一层 -

-(void)closeButtonPressed
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if (_keyBoardIsShow) {
            [self revertView];
            [PPUIKit clostKeyBoard];
            [self performSelector:@selector(hiddenViewInRight) withObject:nil afterDelay:0.0];
        }else{
            [self hiddenViewInRight];
        }
    }else{
        [self hiddenViewInRight];
    }
}

-(void)backButtonPressed
{
    if (PP_ISNSLOG) {
        NSLog(@"backButtonPressed");
    }
}


#pragma mark - 键盘通知事件 -

-(void)keyboardWillHideCallBack:(NSNotification *)noti
{
    _keyBoardIsShow = NO;
    NSDictionary *userInfo = [noti userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (ISIPHONE) {
        //UI移动 键盘上方的各个控件
        [_keyBoardHiddenButton setFrame:CGRectMake(self.bounds.size.width - 70, self.bounds.size.height, 70, 40)];
    }
    else
    {
        [self revertView];
    }

    [UIView commitAnimations];
}

- (void)keyboardDidShowCallBack:(NSNotification *)noti{
    _keyBoardIsShow = YES;
}

-(void)keyboardWillShowCallBack:(NSNotification *)noti
{

    
    NSDictionary *userInfo = [noti userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect keyboardFrame = [self convertRect:keyboardRect fromView:[[UIApplication sharedApplication] keyWindow]];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    //UI移动 键盘上方的各个控件
    _keyBoardHeight = keyboardHeight;
    _keyBoardHiddenButtonY = self.bounds.size.height - keyboardHeight;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    
    if (ISIPHONE) {
        //UI移动 键盘上方的各个控件
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            [_keyBoardHiddenButton setFrame:CGRectMake(_bgImageView.frame.size.width - 70,
                                                       _bgImageView.frame.size.height - keyboardHeight - 40 + _rollupOffset,
                                                       70, 40)];
        }
        else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
        {

            [_keyBoardHiddenButton setFrame:CGRectMake(_bgImageView.frame.size.width - 70,
                                                       _bgImageView.frame.size.height - keyboardHeight - 40 + _rollupOffset,
                                                       70, 40)];
        }
    }
    else
    {
        
    }


    [UIView commitAnimations];
}

- (void)_keyBoardHiddenButtonTouchUpInside{
    [PPUIKit clostKeyBoard];
    [self revertView];
}



#pragma mark  - 隐藏视图，显示视图 动画完成 回电函数 -

- (void)animationFinished:(NSString *)paramAnimationID finished:(BOOL)paramFinished context:(void*)paramContext
{
    [_backButton setEnabled:YES];
    [_closeButton setEnabled:YES];
    if (paramFinished) {
        if ([paramAnimationID isEqualToString:@"hiddenView"]) {
            
            [self didHiddenView];
        }else if ([paramAnimationID isEqualToString:@"showView"]) {
            [self didShowView];
            
        }
    }
}


#pragma mark - Dealloc -

- (void)dealloc
{
    
    [super dealloc];
}


@end

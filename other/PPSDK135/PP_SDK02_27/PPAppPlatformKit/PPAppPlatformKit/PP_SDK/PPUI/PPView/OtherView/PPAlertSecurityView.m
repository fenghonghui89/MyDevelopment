////
////  PPAlertSecurityView.m
////  PPAppPlatformKit
////
////  Created by Seven on 13-4-3.
////  Copyright (c) 2013年 张熙文. All rights reserved.
////
//
//#import "PPAlertSecurityView.h"
//#import "PPAppPlatformKitConfig.h"
//#import "PPWebView.h"
//#import "PPUIKit.h"
//#import "PPAlertView.h"
//#import "PPAppPlatformKit.h"
//
//static PPAlertSecurityView *ppAlertSecurityView = nil;
//
//@implementation PPAlertSecurityView
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        
//        userInfoSecurityImageView = [[UIImageView alloc] init];
//        [userInfoSecurityImageView setImage:[PPUIKit setLocaImage:@"PPWarning"]];
//        [_bgImageView addSubview:userInfoSecurityImageView];
//        [userInfoSecurityImageView release];
// 
//        immediatelyBinding = [UIButton buttonWithType:UIButtonTypeCustom];
//        [immediatelyBinding setTitle:@"立即绑定" forState:UIControlStateNormal];
//        [immediatelyBinding addTarget:self action:@selector(immediatelyBindingPressedown) forControlEvents:UIControlEventTouchUpInside];
//        [_bgImageView addSubview:immediatelyBinding];
//        
//        
//        afterBinding = [UIButton buttonWithType:UIButtonTypeCustom];
//        [afterBinding setTitle:@"以后再说" forState:UIControlStateNormal];
//        [afterBinding addTarget:self action:@selector(afterBindingPressedown) forControlEvents:UIControlEventTouchUpInside];
//        [_bgImageView addSubview:afterBinding];
//        
//        
//        UIImage *imagePPButton = [PPUIKit setLocaImage:@"PPButton"];
//        [immediatelyBinding setBackgroundImage:[imagePPButton
//                                                stretchableImageWithLeftCapWidth:5 topCapHeight:5]
//                                      forState:UIControlStateNormal];
//        
//        [afterBinding setBackgroundImage:[imagePPButton
//                                                stretchableImageWithLeftCapWidth:5 topCapHeight:5]
//                                      forState:UIControlStateNormal];
//
//        [self initVerticalFrame];
//    }
//    return self;
//}
//
//
//
//
//
///// <summary>
///// 获取提示密保页面
///// </summary>
///// <returns>返回PPAlertSecurityView单例</returns>
//+ (PPAlertSecurityView *)sharedInstance
//{
//    if(!ppAlertSecurityView){
//        ppAlertSecurityView = [[[PPAlertSecurityView alloc] init] autorelease];
//        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//        [keyWindow addSubview:ppAlertSecurityView];
////        NSArray *array = [keyWindow subviews];
////        for (int i = 0; i < [array count]; i++) {
////            if ([[array objectAtIndex:i] isKindOfClass:[UIImageView class]]) {
////                [keyWindow insertSubview:ppAlertSecurityView belowSubview:[array objectAtIndex:i]];
////                break;
////            }
////
////        }        
//    }
//    return ppAlertSecurityView;
//}
//
//
//
//-(void)initVerticalFrame{
//    [super initVerticalFrame];
//    [userInfoSecurityImageView setFrame:CGRectMake(0, 80, 320, 120)];
//    [immediatelyBinding setFrame:CGRectMake(20, _bgImageView.frame.size.height / 2 ,
//                                            _bgImageView.frame.size.width - 20 * 2, 50)];
//    [afterBinding setFrame:CGRectMake(20, _bgImageView.frame.size.height / 2 + 90,
//                                            _bgImageView.frame.size.width - 20 * 2, 50)];
//}
//
//-(void)initHorizontalFrame{
//    [super initHorizontalFrame];
//    [userInfoSecurityImageView setCenter:CGPointMake(_bgImageView.frame.size.width / 2 , _bgImageView.frame.size.height / 2 - 60)];
//    [immediatelyBinding setCenter:CGPointMake(_bgImageView.frame.size.width / 2, _bgImageView.frame.size.height / 2 + 30)];
//    [afterBinding setCenter:CGPointMake(_bgImageView.frame.size.width / 2, _bgImageView.frame.size.height / 2 + 100)];
//}
//
//
//#pragma mark  -------------------------SELF UIBUTTON Pressed methods ------------------------------------
//
//-(void)immediatelyBindingPressedown
//{
//    [[PPWebView sharedInstance] userInfoSecurityWebShow];
//    [self hiddenAlertSecuityViewInRight];
//}
//-(void)afterBindingPressedown
//{
//    [self hiddenAlertSecuityViewInRight];
//}
//
//#pragma mark  -------------------------SELF VIEW HIDDEN AND SHOW BY Orientation methods ------------------------------------
////消失到右边
//-(void)hiddenAlertSecuityViewInRight
//{
//    [super hiddenViewInRight];
//}
//
////从右边展示
//-(void)showAlertSecuityViewByRight{
//    [super showViewByRight];
////    [super performSelector:@selector(showViewByRight) withObject:nil afterDelay:6];
//}
//
//
////消失到左边
//-(void)hiddenAlertSecuityViewInLeft
//{
//    [super hiddenViewInLeft];
//    
//}
//
//-(void)closeButtonPressed{
//    [super closeButtonPressed];
//    [[[PPAppPlatformKit sharedInstance] delegate] ppClosePageViewCallBack:PPAlertSecurityViewPageCode];
//}
//
///// <summary>
///// 登陆从左边展示
///// </summary>
///// <returns>无返回</returns>
//-(void)showAlertSecuityViewByLeft{
////    [super performSelector:@selector(showViewByLeft) withObject:nil afterDelay:6];
//    [super showViewByLeft];
//}
//
//
//-(void)didHiddenView
//{
//    ppAlertSecurityView = nil;
//    [super didHiddenView];
//}
//
//- (void)hiddenViewInRight
//{
//    [super hiddenViewInRight];
//}
//
//- (void)dealloc
//{
//    [super dealloc];
//}
//
//
//@end

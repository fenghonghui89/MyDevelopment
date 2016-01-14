//
//  PPWebView.m
//  PPUserUIKit
//
//  Created by seven  mr on 1/24/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPWebView.h"
#import "PPUserPay.h"
#import "PPUIKit.h"
#import "PPAccountsSecurityCenter.h"
#import "PPUnionPayViewController.h"
#import "PPExchange.h"
#import "PPCenterView.h"
#import "PPAppPlatformKitConfig.h"
#import "PPCommon.h"
#import "PPAlixPay.h"
#import "PPFindPassWordByTypeView.h"






@interface PPWebView () {
    
    
}


@end





@implementation PPWebView




- (id)init
{
    self = [super init];
    if (self) {
        [self.backButton setHidden:YES];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleLogin"]];
        [self.verticalLineLeftView setHidden:YES];
        [_verticalLineRightView setHidden:NO];
        [self setUserInteractionEnabled:NO];
        
        
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_indicator setFrame:CGRectMake(50, 0, 50, 50)];
        [_indicator startAnimating];
        [_topView addSubview:_indicator];
        [_indicator release];
        
        
        pageWebView = [[UIWebView alloc] init];
        
        [pageWebView setBackgroundColor:[UIColor whiteColor]];
        [pageWebView setDataDetectorTypes:UIDataDetectorTypePhoneNumber];
        pageWebView.scalesPageToFit = YES;
        pageWebView.delegate = self;
        [[pageWebView.subviews objectAtIndex:0] setShowsHorizontalScrollIndicator:NO];
        [[pageWebView.subviews objectAtIndex:0] setShowsVerticalScrollIndicator:NO];
        [[pageWebView.subviews objectAtIndex:0] setBounces:NO];

        _toolBottomView = [[UIImageView alloc] init];
        

        [_toolBottomView setUserInteractionEnabled:YES];
        [_toolBottomView setBackgroundColor:[PPCommon getColor:@"CCCCCC"]];
        
        UIView *tollBottomLineView = [[UIView alloc] init];
        [tollBottomLineView setFrame:CGRectMake(0, 0, 600, 2)];
        [_toolBottomView addSubview:tollBottomLineView];
        [tollBottomLineView setBackgroundColor:[PPCommon getColor:@"F7F7F7"]];
        [tollBottomLineView release];
        
        _retreatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _advanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        [_retreatButton addTarget:self action:@selector(_retreatButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
        [_advanceButton addTarget:self action:@selector(_advanceButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
        [_refreshButton addTarget:self action:@selector(_refreshButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_retreatButton setImage:[PPUIKit setLocaImage:@"PPWebViewRetreat_Normal"] forState:UIControlStateNormal];
        [_advanceButton setImage:[PPUIKit setLocaImage:@"PPWebViewAadvance_Normal"] forState:UIControlStateNormal];
        [_refreshButton setImage:[PPUIKit setLocaImage:@"PPWebViewRefresh_Normal"] forState:UIControlStateNormal];
        
        [_retreatButton setImage:[PPUIKit setLocaImage:@"PPWebViewRetreat"] forState:UIControlStateHighlighted];
        [_advanceButton setImage:[PPUIKit setLocaImage:@"PPWebViewAadvance"] forState:UIControlStateHighlighted];
        [_refreshButton setImage:[PPUIKit setLocaImage:@"PPWebViewRefresh"] forState:UIControlStateHighlighted];
        
        [_retreatButton setEnabled:NO];
        [_advanceButton setEnabled:NO];
        
        [_toolBottomView addSubview:_retreatButton];
        [_toolBottomView addSubview:_advanceButton];
        [_toolBottomView addSubview:_refreshButton];
        [_toolBottomView setHidden:YES];
        
        [_bgImageView addSubview:_toolBottomView];
        [_bgImageView addSubview:pageWebView];
        [_toolBottomView release];
        [pageWebView release];
        
        
        mbProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [mbProgressHUD hide:YES];
        
        
        [self initVerticalFrame];
        
        
    }
    return self;
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

//竖
-(void)initVerticalFrame
{
//    [super initVerticalFrame];
    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        [_bgImageView setFrame:CGRectMake(UI_IPAD_SCREEN_X, UI_IPAD_SCREEN_Y, UI_IPHONE_SCREEN_WIDTH, UI_IPHONE_SCREEN_HEIGHT)];
//        [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
//        [[_mainView viewWithTag:10] setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT + 200, UI_SCREEN_WIDTH)];
//    }else{
        [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        [_bgImageView setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
//    }
    [_closeButton setFrame:CGRectMake(_bgImageView.frame.size.width - 50, 0, 50, 50)];
    [self.backButton setFrame:CGRectMake(0, 0, 50, 50)];
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
    
    [_toolBottomView setFrame:CGRectMake(0, _bgImageView.frame.size.height - 40, _bgImageView.frame.size.width, 40)];
    [pageWebView setFrame:CGRectMake(0, _topView.frame.size.height + 1, _bgImageView.frame.size.width,
                                     _bgImageView.frame.size.height - _topView.frame.size.height)];
    [_advanceButton setFrame:CGRectMake(_toolBottomView.frame.size.width / 2 - 20, 0, 40, 40)];
    [_retreatButton setFrame:CGRectMake(_advanceButton.frame.origin.x / 2 - 20, 0, 40, 40)];
    [_refreshButton setFrame:CGRectMake(_advanceButton.frame.origin.x / 2 * 3 + 20, 0, 40, 40)];
    [_indicator setFrame:CGRectMake(50, 0, 50, 50)];

}


//横
-(void)initHorizontalFrame
{
//    [super initHorizontalFrame];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        //iPad处理部分
//        [_bgImageView setFrame:CGRectMake(UI_IPAD_SCREEN_Y, UI_IPAD_SCREEN_X,UI_IPHONE_SCREEN_HEIGHT, UI_IPHONE_SCREEN_WIDTH)];
//        [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)];
//        [[_mainView viewWithTag:10] setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT + 200, UI_SCREEN_WIDTH)];
//        
//    }else{
        //iPhone处理部分
//    }
    [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)];
    [_bgImageView setFrame:CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)];

    [_topView setFrame:CGRectMake(0, 0, _bgImageView.frame.size.width, 50)];
    [_titleView setFrame:CGRectMake(50, 0, _bgImageView.frame.size.width - 50 * 2, 50)];
    [_titleLabel sizeToFit];
    [_titleImage sizeToFit];
    [_titleLabel setFrame:CGRectMake(_titleView.frame.size.width / 2 - _titleLabel.frame.size.width / 2 + 15,
                                     0, _titleLabel.frame.size.width + 18, 50)];
    [_titleImage setFrame:CGRectMake(_titleLabel.frame.origin.x - 55, 0, 50, 50)];
    _horizontalLineView.frame = CGRectMake(0, 50, _bgImageView.frame.size.width, 1.0);
    [_closeButton setFrame:CGRectMake(_bgImageView.frame.size.width - 50, 0, 50, 50)];
    [self.backButton setFrame:CGRectMake(0, 0, 50, 50)];
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
    
    [_toolBottomView setFrame:CGRectMake(0, _bgImageView.frame.size.height - 40, _bgImageView.frame.size.width, 40)];
    [pageWebView setFrame:CGRectMake(0, _topView.frame.size.height + 1, _bgImageView.frame.size.width,
                                     _bgImageView.frame.size.height - _topView.frame.size.height)];
    [_advanceButton setFrame:CGRectMake(_toolBottomView.frame.size.width / 2 - 20, 0, 40, 40)];
    [_retreatButton setFrame:CGRectMake(_advanceButton.frame.origin.x / 2 - 20, 0, 40, 40)];
    [_refreshButton setFrame:CGRectMake(_advanceButton.frame.origin.x / 2 * 3 + 20, 0, 40, 40)];
    [_indicator setFrame:CGRectMake(50, 0, 50, 50)];

}


#pragma mark  - 充值并兑换WEB页面,充值WEB页面-

/**
 *  请求充值并兑换WEB页面
 *
 *  @param paramBillNo      请求的订单号
 *  @param paramBillNoTitle 请求的订单标题
 *  @param paramPayMoney    请求订单的金额
 *  @param paramRoleId      请求订单购买的角色ID
 *  @param paramZoneId      请求订单购买的服务器ID
 */
-(void)rechargeAndExchangeWebShow:(NSString *)paramBillNo
                      BillNoTitle:(NSString *)paramBillNoTitle
                         PayMoney:(NSString *)paramPayMoney
                           RoleId:(NSString *)paramRoleId
                           ZoneId:(int)paramZoneId
{
    flag = PPWebViewCodeRechargeAndExchange;
    rechargeAndExchangeBillNo = paramBillNo;
    if (PP_ISNSLOG) {
        NSLog(@"%d--%@",flag,rechargeAndExchangeBillNo);        
    }
    NSMutableURLRequest *request = [PPUserPay webRequestPayAndExchangeWithBillNo:paramBillNo BillNoTitle:paramBillNoTitle
                                                                        PayMoney:paramPayMoney RoleId:paramRoleId ZoneId:paramZoneId];
    if (request == nil) {
        return;
    }
    [pageWebView loadRequest:request];
    [self showWebViewByRight];
}

/**
 *  请求充值WEB页面
 *
 *  @param paramAmount 请求充值的金额
 */
-(void)rechargeWebShow:(NSString *)paramAmount{
    flag = PPWebViewCodeRecharge;
    NSMutableURLRequest *request = [PPUserPay webRequestPPPay:paramAmount];
    [pageWebView loadRequest:request];
    [self showWebViewByRight];
}

#pragma mark - 重置密码web页面 -
/**
 *  通过密保电话重置密码web页面 /通过密保问题重置密码web页面
 *
 *  @param paramResetPass 类型
 *  @param paramUserName  用户名
 */

-(void)resetPass:(ResetPass)paramResetPass UserName:(NSString *)paramUserName
{
    NSString *requestURLStr = @"";
    
    if (paramResetPass == ResetPassByPhonePage)
    {
        requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_FINDPWDBYPHONEPAGE];
    }
    else if (paramResetPass == ResetPassByQuestionPage)
    {
        requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_FINDPWDBYQUESTIONPAGE];
    }
    
    NSURL *requestUrl = [[NSURL alloc] initWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [requestUrl release];
    requestUrl = nil;
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"version\":\"%@\"}",
                                 paramUserName,PP_REQUEST_VERSION];
    if (PP_ISNSLOG) {
        NSLog(@"请求地址URL--\n%@",requestURLStr);
        NSLog(@"请求resetPass--\n%@",requsetBodyData);
    }
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    
    //    return request;
    [pageWebView loadRequest:request];
    [self showWebViewByRight];
}




#pragma mark - web页面操作 上一页，下一页，刷新 -

- (void)_retreatButtonPressdown{
    [pageWebView goBack];
}

- (void)_refreshButtonPressdown{
    [pageWebView reload];
}

- (void)_advanceButtonPressdown{
    [pageWebView goForward];
}

#pragma mark  - 关闭视图，返回上一层 -

-(void)closeButtonPressdown
{
    [_indicator stopAnimating];
    [self hiddenWebViewInRight];
    [[[PPAppPlatformKit sharedInstance] delegate] ppCloseWebViewCallBack:flag];
}


-(void)backButtonPressed
{
    [self hiddenWebViewInRight];
    PPCenterView *ppCenterView = [[PPCenterView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppCenterView atIndex:1002];
    [ppCenterView showCenterViewByLeft];
    [ppCenterView release];
    
}

#pragma mark  - 视图显示，隐藏，消失 -
-(void)showWebViewByLeft
{
    [super showViewByLeft];
}

-(void)hiddenWebViewInLeft
{
    [super hiddenViewInLeft];
}

- (void)hiddenWebViewInRight
{
    [super hiddenViewInRight];
}

-(void)showWebViewByRight
{
    [super showViewByRight];

}
-(void)didHiddenView
{

    [PPMBProgressHUD hideAllHUDsForView:self animated:YES];
    [super didHiddenView];
}

-(void)didShowView
{
    
}

#pragma mark  - UIWebViewDelegate -
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{

    _retreatButton.enabled = pageWebView.canGoBack;
    _advanceButton.enabled = pageWebView.canGoForward;
//    self.actionBarButtonItem.enabled = !self.mainWebView.isLoading;
    
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@",request.URL];
    
    if ([url isEqualToString:@""]) {

    }
    
    //重定向到此域名为银联启动
    if([url isEqualToString:@"http://www.8.com/"]){
        [self closeButtonPressdown];
        PPUnionPayViewController *ppUnionPayViewController = [[PPUnionPayViewController alloc] init];
        [ppUnionPayViewController getUPPAYCreateTime];
        if (PP_ISNSLOG) {
            NSLog(@"启动银联接口");
        }
    }
    
    
    
    //重定向到此域名为支付宝快捷支付
    else if ([url isEqualToString:@"http://www.9.com/"])
    {
        if (PP_ISNSLOG) {
            NSLog(@"启动支付宝快捷支付接口");
        }
        [self closeButtonPressdown];
        PPAlixPay *ppAlixPay = [[PPAlixPay alloc] init];
        [ppAlixPay showViewDidLoad];
        [ppAlixPay release];
    }
    if (PP_ISNSLOG) {
        NSLog(@"%@",url);
    }

    [url release];

    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_titleLabel setText:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    if (PP_ISNSLOG) {
        NSLog(@"webView开始加载");
    }
    [_indicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [mbProgressHUD hide:YES];
    [self setUserInteractionEnabled:YES];
    [_indicator stopAnimating];
    if ([[NSString stringWithFormat:@"%@",webView.request.URL] hasPrefix:@"http://bbs.996.com"])
    {
        [_titleLabel setText:@"996手游论坛"];
    }
    else
    {
        [_titleLabel setText:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
    }
    _retreatButton.enabled = pageWebView.canGoBack;
    _advanceButton.enabled = pageWebView.canGoForward;
    [self onDeviceOrientationChange:NO];
    if (PP_ISNSLOG) {
        NSLog(@"webView加载结束");
    }

    NSString *currRequsetUrlStr = [NSString stringWithFormat:@"%@",[[webView request] URL]];
    if (PP_ISNSLOG) {
        NSLog(@"加载结束的页面是%@",currRequsetUrlStr);
    }

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

    if (PP_ISNSLOG) {
        NSLog(@"%@",[error localizedDescription]);
        NSLog(@"webView加载失败");
    }
    
    [_indicator stopAnimating];
    [self setUserInteractionEnabled:YES];
    [mbProgressHUD setLabelText:@"加载失败！"];
    [mbProgressHUD show:YES];
    if (error.code == -1009) {
        [mbProgressHUD setLabelText:@"网络异常，请检查你的网络！"];
        
    }else if (error.code == -999){
//        [mbProgressHUD hide:YES];
    }
    [mbProgressHUD hide:YES afterDelay:2];

}





#pragma mark - UITextFieldDelegate -

- (void)textChange
{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        {
            [self rollupView:60];
        }
    }
    else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        if (_bgImageView.frame.size.height <= 480)
        {
            [self rollupView:60];
        }
    }
}




- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textChange:(UITextField *)paramTextField
{
    
}

#pragma mark - 键盘通知事件 -

- (void)keyboardWillHideCallBack:(NSNotification *)noti
{
    [super keyboardWillHideCallBack:noti];
    [self revertView];
}

- (void)keyboardWillShowCallBack:(NSNotification *)noti
{
    [super keyboardWillShowCallBack:noti];
    [self textChange];
    
}
- (void)keyboardDidShowCallBack:(NSNotification *)noti{
    [super keyboardDidShowCallBack:noti];
}

#pragma mark - dealloc -

- (void)dealloc
{
    
    //Clear All Cookies
    //    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
    //
    //        //if([[cookie domain] isEqualToString:someNSStringUrlDomain]) {
    //
    //        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    //
    //    }
    //
    //    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //
    //    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    //    [NSURLCache setSharedURLCache:sharedCache];
    //
    //    pageWebView.delegate = nil;
    NSLog(@"webView delloc");
    [super dealloc];
}


#pragma mark - (过期) -
/// <summary>
/// 请求论坛WEB页面
/// </summary>
//-(void)goBBS{
//    flag = PPWebViewCodeBBS;
//    NSMutableURLRequest *request = [PPAccountsSecurityCenter webRequestBBS];
//    [pageWebView loadRequest:request];
//    [self showWebViewByRight];
//}

-(void)goToAddress:(NSString *)paramAddress
{
    
    NSURL *requestUrl = [[NSURL alloc] initWithString:[paramAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    NSLog(@"%@")
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    
    [requestUrl release];
    requestUrl = nil;
    
    if (PP_ISNSLOG) {
        NSLog(@"请求地址URL--\n%@",paramAddress);
    }
    [request setTimeoutInterval:10];
    
    
    [pageWebView loadRequest:request];
    [self showWebViewByRight];
}


@end

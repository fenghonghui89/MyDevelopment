//
//  PPTempUserRegClauseAlertView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-4-24.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPGameVersionUpdateAlertView.h"
#import "PPAppPlatformKit.h"
#import "PPAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+Util.h"

#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

static const CGFloat PPAlertViewDefaultWidth = 276;
static const CGFloat PPAlertViewMinimumHeight = 132;
static const CGFloat PPAlertViewDefaultButtonHeight = 40;

@implementation PPGameVersionUpdateAlertView
@synthesize delegate;
/**
 *descrpition : 初始化
 @param paramForce 是否强制更新
 @param paramUpdateDescribeList 更新列表
 @param paramDownloadUrl 新版本下载地址
 @param paramNewestVersion 最新版本号
 *
 */
- (id)initWithGameVersion:(PPGameVersion *)gameVersion
{
    self = [super init];
    if (self) {
        isIgnoreUpdate = NO;
        isForce = gameVersion.isUpdateForce;
        if (downloadUrl) {
            [downloadUrl release];
            downloadUrl = nil;
        }
        if (newestVersion) {
            [newestVersion release];
            newestVersion = nil;
        }
        if (_gameVersion) {
            [_gameVersion release];
            _gameVersion = nil;
        }
        _gameVersion = [gameVersion retain];
        
        downloadUrl = [gameVersion.downloadUrl retain];
        newestVersion = [gameVersion.version retain];
        
        grayView = [[UIView alloc] init];
        [grayView setBackgroundColor:[UIColor blackColor]];
        [grayView setFrame:CGRectMake(-420, -480, 320 * 4, 480 * 4)];
        [self addSubview:grayView];
        [grayView release];
        
        //        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[[PPUIKit setLocaImage:@"PPUIAlertViewBG"]
        //                                                                          stretchableImageWithLeftCapWidth:142
        //                                                                          topCapHeight:31]];
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[self alertBackgroundImage]];
        //        alertBackgroundImage
        [backgroundView setUserInteractionEnabled:YES];
        [backgroundView  setTag:10];
        [self addSubview:backgroundView];
        [backgroundView release];
        
        titleLabel = [[UILabel alloc] init];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:@"游戏更新日志"];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [backgroundView addSubview:titleLabel];
        
        [titleLabel release];
        ignoreUpdateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [ignoreUpdateButton addTarget:self action:@selector(ignoreUpdateButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox"];
        [ignoreUpdateButton setImage:iamgeTmp
                            forState:UIControlStateNormal];
        [backgroundView addSubview:ignoreUpdateButton];
        
        ignoreUpdateLabel = [[PPHyperlinkLabel alloc] init];
        [ignoreUpdateLabel setDelegate:self];
        [ignoreUpdateLabel setText:@"忽略本次版本更新"];
        [ignoreUpdateLabel setTextColor:[UIColor whiteColor]];
        [ignoreUpdateLabel setBackgroundColor:[UIColor clearColor]];
        [backgroundView addSubview:ignoreUpdateLabel];
        [ignoreUpdateLabel release];
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton addTarget:self action:@selector(cancelButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:[UIColor clearColor]];
        [cancelButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-Cancel-Normal-update"] stretchableImageWithLeftCapWidth:6.0 topCapHeight:6.0]
                                forState:UIControlStateNormal];
        [backgroundView addSubview:cancelButton];
        
        
        OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [OKButton addTarget:self action:@selector(OKButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
        [OKButton setTitle:@"立即更新" forState:UIControlStateNormal];
        [OKButton setBackgroundColor:[UIColor clearColor]];
        [OKButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-Button-Normal-update"] stretchableImageWithLeftCapWidth:6.0 topCapHeight:6.0]
                            forState:UIControlStateNormal];
//        [OKButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertOKbutton"] stretchableImageWithLeftCapWidth:6.0 topCapHeight:6.0]
//                            forState:UIControlStateNormal];
        [backgroundView addSubview:OKButton];
        
        
        //        [[self appearance] setCancelButtonBackgroundImage:[[PPUIKit setLocaImage:@""] resizableImageWithCapInsets:buttonEdgeInsets]
        //                                                 forState:UIControlStateNormal];
        //
        //        [[self appearance] setButtonBackgroundImage:[[PPUIKit setLocaImage:@""] resizableImageWithCapInsets:buttonEdgeInsets]
        //                                           forState:UIControlStateNormal];
        
        
        if (isForce) {
            [PPUIKit setVerifyingUpdate:NO];
            [ignoreUpdateButton setHidden:YES];
            //            [ignoreUpdateLabel setHidden:YES];
            [ignoreUpdateLabel setTextAlignment:NSTextAlignmentLeft];
            [ignoreUpdateLabel setUserInteractionEnabled:NO];
            [ignoreUpdateLabel setText:@"*****此版本为强制更新*****"];
            
            [ignoreUpdateLabel setTextColor:[UIColor redColor]];
            [cancelButton setHidden:YES];
        }else{
            [ignoreUpdateLabel setUserInteractionEnabled:YES];
            [ignoreUpdateButton setHidden:NO];
            [ignoreUpdateLabel setText:@"忽略本次版本更新"];
            
            [cancelButton setHidden:NO];
            
        }
        
        textUpdateScrollView = [[UITextView alloc] init];
        
        NSMutableString *str = [[NSMutableString alloc] init];
        [str appendString:[NSString stringWithFormat:@"版本号------%@\n",gameVersion.version]];
        [str appendString:[NSString stringWithFormat:@"%@\n",gameVersion.newestIpaDescription]];

        for (NSDictionary *versionDic in gameVersion.historyVersionArray) {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                [str appendString:@"\n\n****************************************************************************************************\n\n"];
            }else{
                [str appendString:@"\n\n******************************************************************************************************\n\n"];
            }
            
            [str appendString:[NSString stringWithFormat:@"版本号------%@\n",[versionDic objectForKey:@"historyVersion"]]];
            [str appendString:[NSString stringWithFormat:@"%@\n",[versionDic objectForKey:@"updateDescription"]]];
            

        }

        [textUpdateScrollView setText:str];
        [str release];
        [textUpdateScrollView setEditable:NO];
        [textUpdateScrollView setContentSize:CGSizeMake(250, 260)];
        [backgroundView addSubview:textUpdateScrollView];
        [textUpdateScrollView release];
        
        [self initVerticalFrame];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChange:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        
    }
    return self;
}


#pragma mark - 设备旋转 调整视图的位置和尺寸 -

-(void)initVerticalFrame{
    paramInterfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    UIView *backgroundView = [self viewWithTag:10];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self setFrame:CGRectMake(225, 260, UI_IPHONE_SCREEN_WIDTH, UI_IPHONE_SCREEN_HEIGHT)];
        [backgroundView setFrame:CGRectMake(20, (UI_IPHONE_SCREEN_HEIGHT - 380) / 2, 280 , 380)];
    }else{
        [self setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        [backgroundView setFrame:CGRectMake(20, (UI_SCREEN_HEIGHT - 380) / 2, 280 , 380)];
    }
 
    
    
    
    CGSize titleSize = CGSizeMake(210, 30);
    

    [titleLabel setFrame:CGRectMake((backgroundView.frame.size.width - titleSize.width) / 2,
                                    10, titleSize.width, titleSize.height)];


    
    
    
    [textUpdateScrollView setFrame:CGRectMake(15, titleLabel.frame.size.height + 10, 250, 240)];
    [cancelButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20, 110, 40)];
    [ignoreUpdateButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20 - 44, 30, 44)];
 
    if (isForce) {
        [OKButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20, 110 * 2 + 20, 40)];
        [ignoreUpdateLabel setFrame:CGRectMake(ignoreUpdateButton.frame.size.width + 10, backgroundView.frame.size.height - 40 - 20 - 44, 200, 44)];
    }else{
        [OKButton setFrame:CGRectMake(20 + 110 + 20, backgroundView.frame.size.height - 40 - 20, 110, 40)];
        [ignoreUpdateLabel setFrame:CGRectMake(ignoreUpdateButton.frame.size.width + 20 + 10, backgroundView.frame.size.height - 40 - 20 - 44, 180, 44)];
    }
}

-(void)initHorizontalFrame{
    paramInterfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    UIView *backgroundView = [self viewWithTag:10];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [backgroundView setFrame:CGRectMake(20, (UI_IPHONE_SCREEN_HEIGHT - 280) / 2, 280 , 280)];
    }else{
        [backgroundView setFrame:CGRectMake(20, (UI_SCREEN_HEIGHT - 280) / 2, 280 , 280)];
    }
 
    [textUpdateScrollView setFrame:CGRectMake(15, titleLabel.frame.size.height + 10, 250, 140)];
    
    [cancelButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20, 110, 40)];
    [ignoreUpdateButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20 - 44, 30, 44)];
    if (isForce) {
        [OKButton setFrame:CGRectMake(20, backgroundView.frame.size.height - 40 - 20, 110 * 2 + 20, 40)];
        [ignoreUpdateLabel setFrame:CGRectMake(ignoreUpdateButton.frame.size.width + 10, backgroundView.frame.size.height - 40 - 20 - 44, 200, 44)];
    }else{
        [ignoreUpdateLabel setFrame:CGRectMake(ignoreUpdateButton.frame.size.width + 20 + 10, backgroundView.frame.size.height - 40 - 20 - 44, 180, 44)];
        [OKButton setFrame:CGRectMake(20 + 110 + 20, backgroundView.frame.size.height - 40 - 20, 110, 40)];
    }
}

-(void)onDeviceOrientationChange:(BOOL)paramAnimated {
    
    /**
     *页面旋屏通知回调
     *首先判断是否开启允许旋屏
     *判断旋转后当前状态栏方向。根据方向旋转View，并加载坐标
     */
    
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (paramAnimated) {
        NSTimeInterval duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
        switch (paramInterfaceOrientation) {
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


#pragma mark - 更新软件 -

//创建服务器接受的plist组装参数，iOS 7.1以后版本使用
- (NSString *)createServerPlistURL
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    
    NSMutableString *var_params = [NSMutableString string];
    
    [var_params appendFormat:@"item0-url=%@&",_gameVersion.downloadUrl];
    [var_params appendFormat:@"item1-url=%@&",_gameVersion.artWorkUrl];
    [var_params appendFormat:@"item2-url=%@&",_gameVersion.artWorkUrl108];
    [var_params appendFormat:@"metadata-bundle-identifier=%@&",[infoDict objectForKey:@"CFBundleIdentifier"]];
    [var_params appendFormat:@"metadata-bundle-version=%@&",_gameVersion.version];
    [var_params appendFormat:@"metadata-kind=%@&",@"software"];
    [var_params appendFormat:@"metadata-title=%@&",[infoDict objectForKey:@"CFBundleDisplayName"]];
    [var_params appendFormat:@"metadata-subtitle=%@",[infoDict objectForKey:@"CFBundleDisplayName"]];
    
    NSString *encodeParams = [var_params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *paramsBase64String = [encodeParams encodeStringToBase64URLFormat];
    NSString *url = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=https://sslapi.25pp.com/c/%@.plist",paramsBase64String];

    if (PP_ISNSLOG) {
        NSLog(@"%@",url);
    }

    //测试地址
    //    NSString *url = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=http://192.168.1.67/%@.plist",paramsBase64String];
    //    NSLog(@"%@",url);
    //    NSLog(@"length = %d",url.length);
    //    NSString *url = [NSString stringWithFormat:@"itms-services://?action=download-manifest&amp;url=%@", downloadUrl];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    return url;
}


-(void)gameUpdate{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self createServerPlistURL]]];
    
}

#pragma mark - sendRequest -

-(void)sendRequest:(NSMutableURLRequest *)request
{
    if (![NSURLConnection canHandleRequest:request])
    {
        return;
    }
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (recvData) {
        [recvData release];
        recvData = nil;
    }
    
    if(connection){
        recvData = [[NSMutableData alloc] init];
    }
    [connection start];
    [connection release];
}


#pragma mark - 忽略这个版本更新及UI更新，下载更新，不进行更新及回调 -

//进行更新

-(void)OKButtonPressdown{
    ppMBProgress = [PPMBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [ppMBProgress setLabelText:@"正在更新"];
    [ppMBProgress hide:YES afterDelay:3];
    [OKButton setTag:1];
    [self dismissAlertView:OKButton];
    [self performSelector:@selector(gameUpdate) withObject:nil afterDelay:1];

    [delegate didClickButton:OKButton];
}
//不进行更新
-(void)cancelButtonPressdown{
    [cancelButton setTag:2];
    if (isIgnoreUpdate) {
        [self ignoreGameUpdate];
    }
    [self dismissAlertView:cancelButton];

    [delegate didClickButton:cancelButton];
    [self performSelector:@selector(afterVerifyingUpdatePass) withObject:nil afterDelay:0.5];
}

//不进行更新回调

-(void)afterVerifyingUpdatePass{
    if ([[PPAppPlatformKit sharedInstance] delegate]) {
        [[[PPAppPlatformKit sharedInstance] delegate] ppVerifyingUpdatePassCallBack];
    }
}

//忽略更新方法
-(void)ignoreGameUpdate{
    if (![[NSFileManager defaultManager] fileExistsAtPath:PP_UPDATEGAMEFLAG_FILE]) {
        NSArray *tempArray = [[NSArray alloc] initWithObjects:newestVersion, nil];
        [tempArray writeToFile:PP_UPDATEGAMEFLAG_FILE atomically:NO];
        [tempArray release];
    }else{
        NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:PP_UPDATEGAMEFLAG_FILE];
        if ([tempArray count] > 0) {
            [tempArray insertObject:newestVersion atIndex:0];
            [tempArray writeToFile:PP_UPDATEGAMEFLAG_FILE atomically:NO];
        }
    }
    
    
}
-(void)myLabel:(PPHyperlinkLabel *)myLabel{
    [self ignoreUpdateButtonPressdown];
    
}
-(void)ignoreUpdateButtonPressdown{
    if (isIgnoreUpdate) {
        isIgnoreUpdate = NO;
        [ignoreUpdateLabel setTextColor:[UIColor whiteColor]];
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox"];
        [ignoreUpdateButton setImage:iamgeTmp
                           forState:UIControlStateNormal];
    }else{
        isIgnoreUpdate = YES;
        [ignoreUpdateLabel setTextColor:COLOR(59,136,195,1.0)];
        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox_checked"];
        [ignoreUpdateButton setImage:iamgeTmp
                           forState:UIControlStateNormal];
    }
}

#pragma mark - 显示Model视图  关闭视图 -

-(int)showModel
{
    
    [self onDeviceOrientationChange:NO];
    //    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:self atIndex:1000];
    [grayView setAlpha:0.4];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[self viewWithTag:10].layer addAnimation:popAnimation forKey:nil];
    //    CFRunLoopRun();
    return self.tag;
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    alertView.tag = buttonIndex;
    alertView.delegate = nil;

    //    CFRunLoopStop(CFRunLoopGetCurrent());
}

-(void)dismissAlertView:(id)sender{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(alertViewIsRemoved)];
	[grayView setAlpha:0.0f];
	[UIView commitAnimations];
}

- (void)alertViewIsRemoved{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
	[self removeFromSuperview];
    self = nil;
}


#pragma mark - 获取 Alert背景颜色 -

- (UIImage *)alertBackgroundImage
{
	CGRect rect = CGRectMake(0, 0, PPAlertViewDefaultWidth, PPAlertViewMinimumHeight);
	const CGFloat lineWidth = 2;
	const CGFloat cornerRadius = 8;
    
	CGFloat shineWidth = rect.size.width * 1.33;
	CGFloat shineHeight = rect.size.width * 0.2;
	CGFloat shineOriginX = rect.size.width * 0.5 - shineWidth * 0.5;
	CGFloat shineOriginY = -shineHeight * 0.45;
	CGRect shineRect = CGRectMake(shineOriginX, shineOriginY, shineWidth, shineHeight);
    
	UIColor *fillColor = [UIColor colorWithRed:1/255.0 green:21/255.0 blue:54/255.0 alpha:0.9];
	UIColor *strokeColor = [UIColor colorWithWhite:1.0 alpha:0.7];
	
	BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(rect.size, opaque, [[UIScreen mainScreen] scale]);
    
	CGRect fillRect = CGRectInset(rect, lineWidth, lineWidth);
	UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:fillRect cornerRadius:cornerRadius];
	[fillColor setFill];
	[fillPath fill];
	
	CGRect strokeRect = CGRectInset(rect, lineWidth * 0.5, lineWidth * 0.5);
	UIBezierPath *strokePath = [UIBezierPath bezierPathWithRoundedRect:strokeRect cornerRadius:cornerRadius];
	strokePath.lineWidth = lineWidth;
	[strokeColor setStroke];
	[strokePath stroke];
	
	UIBezierPath *shinePath = [UIBezierPath bezierPathWithOvalInRect:shineRect];
	[fillPath addClip];
	[shinePath addClip];
	
    const size_t locationCount = 2;
    CGFloat locations[locationCount] = { 0.0, 1.0 };
    CGFloat components[locationCount * 4] = {
		1, 1, 1, 0.75,  // Translucent white
		1, 1, 1, 0.05   // More translucent white
	};
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, locationCount);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGPoint startPoint = CGPointMake(CGRectGetMidX(shineRect), CGRectGetMinY(shineRect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(shineRect), CGRectGetMaxY(shineRect));
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	CGFloat capHeight = CGRectGetMaxY(shineRect);
	CGFloat capWidth = rect.size.width * 0.5;
	return [image resizableImageWithCapInsets:UIEdgeInsetsMake(capHeight, capWidth, rect.size.height - capHeight, capWidth)];
}



#pragma mark - (没有用到的方法) - 

- (NSString *)returnStringWithoutStr:(NSString *)allStr without:(NSString *)removeStr
{
    NSMutableString *strval = [NSMutableString  stringWithString:allStr];
    while (true) {
        NSRange range = [strval rangeOfString:removeStr];
        if (range.location == NSNotFound) {
            break;
        }
        else
        {
            [strval deleteCharactersInRange:range];
        }
    }
    allStr = strval;
    return allStr;
}

- (void) changeArray:(NSMutableArray *)dicArray
        orderWithKey:(NSString *)key
           ascending:(BOOL)yesOrNo
{
    NSSortDescriptor *distanceDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                                       ascending:yesOrNo];
    NSArray *descriptors = [NSArray arrayWithObjects:distanceDescriptor,nil];
    [dicArray sortUsingDescriptors:descriptors];
    [distanceDescriptor release];
}

#pragma mark - (过期方法)  -

//- (id)initWithForce:(BOOL)paramForce UpdateDescribeList:(NSDictionary *)paramUpdateDescribeList DownloadUrl:(NSString *)paramDownloadUrl
//      NewestVersion:(NSString *)paramNewestVersion
//{
//    self = [super init];
//    if (self) {
//        isIgnoreUpdate = NO;
//        isForce = paramForce;
//        if (downloadUrl) {
//            [downloadUrl release];
//            downloadUrl = nil;
//        }
//        if (newestVersion) {
//            [newestVersion release];
//            newestVersion = nil;
//        }
//
//        downloadUrl = [paramDownloadUrl retain];
//        newestVersion = [paramNewestVersion retain];
//
//        grayView = [[UIView alloc] init];
//        [grayView setBackgroundColor:[UIColor blackColor]];
//        [grayView setFrame:CGRectMake(-420, -480, 320 * 4, 480 * 4)];
//        [self addSubview:grayView];
//        [grayView release];
//
////        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[[PPUIKit setLocaImage:@"PPUIAlertViewBG"]
////                                                                          stretchableImageWithLeftCapWidth:142
////                                                                          topCapHeight:31]];
//        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[self alertBackgroundImage]];
////        alertBackgroundImage
//        [backgroundView setUserInteractionEnabled:YES];
//        [backgroundView  setTag:10];
//        [self addSubview:backgroundView];
//        [backgroundView release];
//
//        titleLabel = [[UILabel alloc] init];
//        [titleLabel setBackgroundColor:[UIColor clearColor]];
//        [titleLabel setTextColor:[UIColor whiteColor]];
//        [titleLabel setText:@"游戏更新日志"];
//        [titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [backgroundView addSubview:titleLabel];
//
//        [titleLabel release];
//        ignoreUpdateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [ignoreUpdateButton addTarget:self action:@selector(ignoreUpdateButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
//        UIImage *iamgeTmp = [PPUIKit setLocaImage:@"PPCheckbox"];
//        [ignoreUpdateButton setImage:iamgeTmp
//                            forState:UIControlStateNormal];
//        [backgroundView addSubview:ignoreUpdateButton];
//
//        ignoreUpdateLabel = [[PPHyperlinkLabel alloc] init];
//        [ignoreUpdateLabel setDelegate:self];
//        [ignoreUpdateLabel setText:@"忽略本次版本更新"];
//        [ignoreUpdateLabel setTextColor:[UIColor whiteColor]];
//        [ignoreUpdateLabel setBackgroundColor:[UIColor clearColor]];
//        [backgroundView addSubview:ignoreUpdateLabel];
//        [ignoreUpdateLabel release];
//
//        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [cancelButton addTarget:self action:@selector(cancelButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
//        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//        [cancelButton setBackgroundColor:[UIColor clearColor]];
//        [cancelButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-Cancel-Normal"] stretchableImageWithLeftCapWidth:6.0 topCapHeight:6.0]
//                                forState:UIControlStateNormal];
//        [backgroundView addSubview:cancelButton];
//
//
//        OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [OKButton addTarget:self action:@selector(OKButtonPressdown) forControlEvents:UIControlEventTouchUpInside];
//        [OKButton setTitle:@"立即更新" forState:UIControlStateNormal];
//        [OKButton setBackgroundColor:[UIColor clearColor]];
//        [OKButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-Button-Normal"] stretchableImageWithLeftCapWidth:6.0 topCapHeight:6.0]
//                            forState:UIControlStateNormal];
////        [OKButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertOKbutton"] stretchableImageWithLeftCapWidth:6.0 topCapHeight:6.0]
////                            forState:UIControlStateNormal];
//        [backgroundView addSubview:OKButton];
//
//
////        [[self appearance] setCancelButtonBackgroundImage:[[PPUIKit setLocaImage:@""] resizableImageWithCapInsets:buttonEdgeInsets]
////                                                 forState:UIControlStateNormal];
////
////        [[self appearance] setButtonBackgroundImage:[[PPUIKit setLocaImage:@""] resizableImageWithCapInsets:buttonEdgeInsets]
////                                           forState:UIControlStateNormal];
//
//
//        if (isForce) {
//            [ignoreUpdateButton setHidden:YES];
////            [ignoreUpdateLabel setHidden:YES];
//            [ignoreUpdateLabel setTextAlignment:NSTextAlignmentLeft];
//            [ignoreUpdateLabel setUserInteractionEnabled:NO];
//            [ignoreUpdateLabel setText:@"*****此版本为强制更新*****"];
//
//            [ignoreUpdateLabel setTextColor:[UIColor redColor]];
//            [cancelButton setHidden:YES];
//        }else{
//            [ignoreUpdateLabel setUserInteractionEnabled:YES];
//            [ignoreUpdateButton setHidden:NO];
//            [ignoreUpdateLabel setText:@"忽略本次版本更新"];
//
//            [cancelButton setHidden:NO];
//
//        }
//
//
//
//
//
//        textUpdateScrollView = [[UITextView alloc] init];
//
//        NSMutableString *str = [[NSMutableString alloc] init];
//
//
//        NSMutableArray *allKey = [[NSMutableArray alloc] initWithArray:[paramUpdateDescribeList allKeys]];
//        NSArray *resultArray = [allKey sortedArrayUsingSelector:@selector(compare:)];
//
//        for (int i = [resultArray count] - 1; i >= 0; i--) {
//            NSString *key = [resultArray objectAtIndex:i];
//            [str appendString:[NSString stringWithFormat:@"版本号------%@\n",key ]];
//            NSDictionary *dic = [paramUpdateDescribeList objectForKey:key];
//            [str appendString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"log"]]];
//            if (i > 0){
//                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//                    [str appendString:@"\n\n**************************************************************************************************************\n\n"];
//                }else{
//                    [str appendString:@"\n\n******************************************************************************************************\n\n"];
//                }
//            }
//        }
//
//
//
//        [textUpdateScrollView setText:str];
//        [str release];
//        [textUpdateScrollView setEditable:NO];
//        [textUpdateScrollView setContentSize:CGSizeMake(250, 260)];
//        [backgroundView addSubview:textUpdateScrollView];
//        [textUpdateScrollView release];
//
//        [self initVerticalFrame];
//
//
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(onDeviceOrientationChange:)
//                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
//                                                   object:nil];
//
//    }
//    return self;
//}




@end

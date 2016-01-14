//
//  PPUserUIKit.m
//  PPUserUIKit
//
//  Created by seven  mr on 1/14/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPUIKit.h"
#import <UIKit/UIKit.h>
#import "PPLoginView.h"
#import "PPRegisterView.h"
#import "PPCenterView.h"
#import "PPUpdatePassWordView.h"
#import "PPWebView.h"
#import "PPUnionPayViewController.h"
#import "PPAlertSecurityView.h"
#import "PPLoginSucceedNotiView.h"
#import "PPAppPlatformKitConfig.h"
#import "PPGameVersionUpdateAlertView.h"
#import "PPAppPlatformKit.h"



static PPUIKit *ppUIkit = nil;
static BOOL isDeviceOrientationPortrait = YES;
static BOOL isDeviceOrientationPortraitUpsideDown = YES;
static BOOL isDeviceOrientationLandscapeLeft = YES;
static BOOL isDeviceOrientationLandscapeRight = YES;
static BOOL verifyingUpdate = NO;


@implementation PPUIKit

PPMBProgressHUD *mbPreogressHUD;

/**
 *  初始化SDK界面。必须写在window初始化完成之后
 *
 *  @return PPUIKit单例
 */
+ (PPUIKit *)sharedInstance
{
    if(!ppUIkit){
        ppUIkit = [[PPUIKit alloc] init];

//        [mbPreogressHUD hide:YES];
        [PPUIKit setVerifyingUpdate:NO];

    }
    return ppUIkit;
}

#pragma mark - 检查 版本更新，更新成功，失败 回调 -
/**
 *  检查版本更新
 */
-(void)checkGameUpdate
{
    mbPreogressHUD = [PPMBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
    [PPUIKit setVerifyingUpdate:NO];
    [mbPreogressHUD show:YES];
    [mbPreogressHUD setLabelText:@"正在检查游戏版本"];
    PPGameUpdateManager *ppGame = [PPGameUpdateManager defaultPPGameUpdateManager];
    [ppGame ppRequestGameVersionWithDelegate:ppUIkit];
}

- (void) didSuccessGetGameUpdateInfoCallBack:(PPGameVersion *)gameVersion
{
    
    [PPUIKit setVerifyingUpdate:YES];
    [mbPreogressHUD hide:YES];
    [ppUIkit release];
    
    int status = gameVersion.status;
    if (status == IH_E_UPDATE) {
        //查看本地是否存在忽略的版本，并检查当前版本是否被忽略
        if ([[NSFileManager defaultManager] fileExistsAtPath:PP_UPDATEGAMEFLAG_FILE]) {
            NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:PP_UPDATEGAMEFLAG_FILE];
            if (PP_ISNSLOG) {
                NSLog(@"读取出本地忽略的版本%@",tempArray);
            }
            for (NSString *tempStr in tempArray){
                //如果服务端返回的最新版本存在本地忽略版本名单中，则不用提示更新
                if ([tempStr isEqualToString:gameVersion.version]) {
                    if ([[PPAppPlatformKit sharedInstance] delegate]) {
                        [[[PPAppPlatformKit sharedInstance] delegate] ppVerifyingUpdatePassCallBack];
                    }
                    return;
                }
            }
        }
        //如果当前版本要求强制更新
        if (gameVersion.isUpdateForce)
        {
            [PPUIKit setVerifyingUpdate:NO];
            
            PPGameVersionUpdateAlertView *ppGameAlertView = [[PPGameVersionUpdateAlertView alloc]
                                                             initWithGameVersion:gameVersion];
            [ppGameAlertView showModel];
            [ppGameAlertView release];
            if (PP_ISNSLOG) {
                NSLog(@"此版本要求强制更新");
            }
        }
        else
        {
            [PPUIKit setVerifyingUpdate:YES];
            //不强更
            PPGameVersionUpdateAlertView *ppGameAlertView = [[PPGameVersionUpdateAlertView alloc]
                                                             initWithGameVersion:gameVersion];
            [ppGameAlertView showModel];
            [ppGameAlertView release];
            if (PP_ISNSLOG) {
                NSLog(@"此版本不要求强制更新");
            }
        }
    }
    else if (status == IH_E_NOT_UPDATE){
        if (PP_ISNSLOG) {
            NSLog(@"没有检测到新版本");
        }
        [PPUIKit setVerifyingUpdate:YES];
        if ([[PPAppPlatformKit sharedInstance] delegate]) {
            [[[PPAppPlatformKit sharedInstance] delegate] ppVerifyingUpdatePassCallBack];
        }
    }
    else if(status == IH_E_INVALID_BUID)
    {
        if (PP_ISNSLOG) {
            NSLog(@"开发者后台配置的CFBundleIdentifier不正确");
        }
        [PPUIKit setVerifyingUpdate:NO];
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"游戏BundleId不正确，请联系运营"];
        [alert setCancelButtonTitle:@"确定" block:^{
            exit(0);
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    //    IH_E_APP_NOT_FOUND 		= 	3,	//更新库不存在
    else if(status == IH_E_APP_NOT_FOUND)
    {
        if (PP_ISNSLOG) {
            NSLog(@"没有检测到新版本");
        }
        [PPUIKit setVerifyingUpdate:YES];
        if ([[PPAppPlatformKit sharedInstance] delegate]) {
            [[[PPAppPlatformKit sharedInstance] delegate] ppVerifyingUpdatePassCallBack];
        }
    }
    //    IH_E_APP_NOT_EXIST 		= 	4,	//正版库不存在
    else if(status == IH_E_APP_NOT_EXIST)
    {
        [PPUIKit setVerifyingUpdate:NO];
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"App不存在或资源尚未同步成功，请联系运营！"];
        [alert setCancelButtonTitle:@"确定" block:^{
            exit(0);
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
        
        
    }
    //请求参数错误
    else if(status == IH_E_INVALID_DATA)
    {
        [PPUIKit setVerifyingUpdate:NO];
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"请求参数错误！"];
        [alert setCancelButtonTitle:@"确定" block:^{
            exit(0);
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    [PPMBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
    
}

- (void) didFailRequestConnectionCallBack:(TRHTTPConnectionError)errorCode userInfo:(NSMutableDictionary *)userInfo
{
    
    [PPUIKit setVerifyingUpdate:NO];
    [mbPreogressHUD setLabelText:@"网络异常,检查更新失败"];
    [mbPreogressHUD hide:YES afterDelay:1];
    
    [ppUIkit release];
    
    PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ALERTTITLE message:@"网络异常,检查游戏更新失败!是否重新检查？"];
    [alert setCancelButtonTitle:@"确定" block:^{
        [[PPUIKit sharedInstance] checkGameUpdate];
    }];
    [alert addButtonWithTitle:@"退出" block:^{
        exit(0);
    }];
    [alert show];
    [alert release];
    
    if (PP_ISNSLOG) {
        NSLog(@"检测游戏更新失败，通信错误");
    }
    [PPMBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
}


#pragma mark - 获取本地PPImage.bundle 中图片 -
/**
 *  获取本地PPImage.bundle 中图片
 *
 *  @param paramImageName 图片名字
 *
 *  @return 图片
 */
+ (UIImage *)setLocaImage:(NSString *)paramImageName{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *imagePath = [mainBundle pathForResource:[NSString stringWithFormat:@"PPImage.bundle/%@",paramImageName] ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

#pragma mark - 关闭键盘 -
+ (void)clostKeyBoard{
    //关闭键盘
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
}



#pragma mark - 设置和获取 是否进行更新 -
//NO为不通过重复检查更新
+(void)setVerifyingUpdate:(BOOL)paramVerifyingUpdate{
    verifyingUpdate = paramVerifyingUpdate;
}

+(BOOL)getVerifyingUpdate{
    return verifyingUpdate;
}

#pragma mark - SET/GET 设置支持的方向 -
/**
 * @brief     设置SDK是否允许竖立设备Home键在下方向
 * @param     INPUT paramDeviceOrientationPortrait: YES 支持 ，NO 不支持， 默认为YES
 * @return    无返回
 */
+(void)setIsDeviceOrientationPortrait:(BOOL)paramDeviceOrientationPortrait{
    isDeviceOrientationPortrait = paramDeviceOrientationPortrait;
}

/**
 *  获取SDK是否允许竖立设备Home键在下方向
 *
 *  @return 返回BOOL
 */
+(BOOL)getIsDeviceOrientationPortrait{
    return isDeviceOrientationPortrait;
}

/**
 *  设置SDK是否允许竖立设备Home键在上方向
 *
 *  @param paramDeviceOrientationPortraitUpsideDown 是否允许
 */
+(void)setIsDeviceOrientationPortraitUpsideDown:(BOOL)paramDeviceOrientationPortraitUpsideDown{
    isDeviceOrientationPortraitUpsideDown = paramDeviceOrientationPortraitUpsideDown;
}

/**
 *  获取SDK是否允许竖立设备Home键在上方向
 *
 *  @return 返回BOO
 */
+(BOOL)getIsDeviceOrientationPortraitUpsideDown{
    return isDeviceOrientationPortraitUpsideDown;
}

/**
 *  设置SDK是否允许横放设备Home键在左方向
 *
 *  @param paramDeviceOrientationLandscapeLeft 是否允许
 */
+(void)setIsDeviceOrientationLandscapeLeft:(BOOL)paramDeviceOrientationLandscapeLeft{
    isDeviceOrientationLandscapeLeft = paramDeviceOrientationLandscapeLeft;
}

/**
 *  获取SDK是否允许竖立设备Home键在左方向
 *
 *  @return 返回BOOL
 */
+(BOOL)getIsDeviceOrientationLandscapeLeft{
    return isDeviceOrientationLandscapeLeft;
}

/**
 *  设置SDK是否允许横放设备Home键在右方向
 *
 *  @param paramDeviceOrientationLandscapeRight 是否允许
 */
+(void)setIsDeviceOrientationLandscapeRight:(BOOL)paramDeviceOrientationLandscapeRight{
    isDeviceOrientationLandscapeRight = paramDeviceOrientationLandscapeRight;
}

/**
 *  获取SDK是否允许竖立设备Home键在右方向
 *
 *  @return 返回BOOL
 */
+(BOOL)getIsDeviceOrientationLandscapeRight{
    return isDeviceOrientationLandscapeRight;
}





#pragma mark - dealloc -
-(void)dealloc
{
    ppUIkit = nil;
    if (PPDEALLOC_ISNSLOG) {
        NSLog(@"uikit dealloc");
    }
    [super dealloc];
}

#pragma mark - 过期方法 -
//因为获取都是状态栏旋转前的尺寸
+ (int)getHeight
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft ||
            [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
            return 480;
        }
        else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait ||
                 [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)
        {
            return 320;
        }
    }
    else
    {
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft ||
            [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
            return [[UIScreen mainScreen] bounds].size.height;
        }
        else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait ||
                 [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)
        {
            return [[UIScreen mainScreen] bounds].size.width;
        }
    }
    NSLog(@"获取宽度错误");
    return 0;
}



//因为获取都是状态栏旋转前的尺寸
+ (int)getWidth{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft ||
            [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
            return 320;
        }
        else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait ||
                 [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)
        {
            return 480;
        }
    }
    else
    {
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft ||
            [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
            return [[UIScreen mainScreen] bounds].size.width;
        }
        else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait ||
                 [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)
        {
            return [[UIScreen mainScreen] bounds].size.height;
        }
    }
    NSLog(@"获取宽度错误");
    return 0;
}
@end

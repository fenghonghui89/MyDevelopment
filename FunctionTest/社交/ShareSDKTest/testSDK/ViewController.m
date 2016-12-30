//
//  ViewController.m
//  testSDK
//
//  Created by hanyfeng on 15/1/23.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface ViewController ()<ISSShareViewDelegate>

@end

@implementation ViewController

#pragma mark - vc lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - action
- (IBAction)shareBtnPress:(id)sender
{
    [self shareEvent1:sender];
}

- (IBAction)ipadSharePress:(id)sender
{
    [self shareEvent5:sender];
}

//TODO:普通-iphone
-(void)shareEvent1:(id)sender
{    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"content:xx"
                                       defaultContent:@"defaultContent:xxx"
                                                image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"header1" ofType:@"png"]]
                                                title:@"title:xxxx"
                                                  url:@"http://www.mob.com"
                                          description:@"description:xxxxx"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                    NSLog(@"***错误码：%d",[error errorCode]);
                                    NSLog(@"***错误描述：%@",[error errorDescription]);
                                    
                                }
                            }];
}

//TODO:普通-ipad
-(void)shareEvent2:(id)sender
{
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容xxxxxx"
                                       defaultContent:@"测试一下~~~"
                                                image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"header" ofType:@"png"]]
                                                title:@"ShareSDK~~~"
                                                  url:@"http://www.mob.com"
                                          description:@"人人专用：这是一条测试信息~~"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                    NSLog(@"***错误码：%d",[error errorCode]);
                                    NSLog(@"***错误描述：%@",[error errorDescription]);
                                    
                                }
                            }];
}

//TODO:自定义分享列表、自定义标题栏
-(void)shareEvent3:(id)sender
{
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容xxxxxx"
                                       defaultContent:@"测试一下~~~"
                                                image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"header" ofType:@"png"]]
                                                title:@"ShareSDK~~~"
                                                  url:@"http://www.mob.com"
                                          description:@"人人专用：这是一条测试信息~~"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建自定义分享列表
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeWeixiSession,ShareTypeWeixiTimeline,ShareTypeWeixiFav,ShareTypeQQ,ShareTypeQQSpace,ShareTypeSinaWeibo,ShareTypeTencentWeibo,ShareTypeSMS,nil];
    
    
    //自定义标题栏相关委托
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"自定义标题栏相关委托"
                                                              oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:YES
                                                       wxTimelineButtonHidden:YES
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:self
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                    NSLog(@"***错误码：%d",[error errorCode]);
                                    NSLog(@"***错误描述：%@",[error errorDescription]);
                                    
                                }
                            }];
}

//TODO:直接显示编辑框 不显示分享菜单
-(void)shareEvent4:(id)sender
{
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容xxxxxx"
                                       defaultContent:@"测试一下~~~"
                                                image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"header" ofType:@"png"]]
                                                title:@"ShareSDK~~~"
                                                  url:@"http://www.mob.com"
                                          description:@"人人专用：这是一条测试信息~~"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //直接显示编辑框 不显示分享菜单
    [ShareSDK showShareViewWithType:ShareTypeSinaWeibo
                          container:nil
                            content:publishContent
                      statusBarTips:YES
                        authOptions:nil
                       shareOptions:nil
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 
                                 if (state == SSPublishContentStateSuccess)
                                 {
                                     NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                                 }
                                 else if (state == SSPublishContentStateFail)
                                 {
                                     NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                 }
                             }];
}

//TODO:自定义UI分享
-(void)shareEvent5:(id)sender
{
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容xxxxxx"
                                       defaultContent:@"测试一下~~~"
                                                image:[ShareSDK imageWithPath:[[NSBundle mainBundle] pathForResource:@"header" ofType:@"png"]]
                                                title:@"ShareSDK~~~"
                                                  url:@"http://www.mob.com"
                                          description:@"人人专用：这是一条测试信息~~"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //自定义UI分享
    [ShareSDK shareContent:publishContent
                      type:ShareTypeSinaWeibo
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                        }
                        
                    }];
}

//TODO:天工
-(void)shareEvent6:(id)sender
{
    //自动授权
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleModal
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    
    
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"content"
                                       defaultContent:@"天工网问答app分享"
                                                image:[ShareSDK jpegImageWithImage:[UIImage imageNamed:@"header1"] quality:0.8]
                                                title:@"title"
                                                  url:@"www.baidu.com"
                                          description:@"content"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    //要分享的列表
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeWeixiSession,ShareTypeWeixiTimeline,ShareTypeWeixiFav,ShareTypeQQ,ShareTypeQQSpace,ShareTypeSinaWeibo,ShareTypeTencentWeibo,ShareTypeSMS,nil];
    
    
    
    
    //分享界面 选项
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"title"
                                                              oneKeyShareList:shareList
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:YES
                                                       wxTimelineButtonHidden:NO
                                                         showKeyboardOnAppear:YES
                                                            shareViewDelegate:nil
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
    
    //分享的 底ViewControoler
    id<ISSContainer> container = [ShareSDK container];
    
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                }
                            }];

}

#pragma mark - delegate
#pragma mark ISSShareViewDelegate
- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType

{
    //修改分享编辑框的标题栏颜色
    viewController.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
//    //将分享编辑框的标题栏替换为图片
//    UIImage *image = [UIImage imageNamed:@"header.png"];
//    [viewController.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
}



@end

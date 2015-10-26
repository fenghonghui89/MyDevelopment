//
//  ViewController.m
//  umengtest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//



#import "ViewController.h"
#import "UMShareManager.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - < action > -
/**
 *  登录
 *
 *  @param sender 无
 */
- (IBAction)loginBtnTap:(id)sender
{
    switch (((UIButton *)sender).tag) {
        case 100:
            //微信
            [[UMShareManager share] wechatLogin:self];
            break;
        case 101:
            [[UMShareManager share] weiboLogin:self];
            break;
        case 102:
            [[UMShareManager share] qqlogin:self];
            break;
        default:
            break;
    }
}

/**
 *  分享
 *
 *  @param sender 无
 */
- (IBAction)shareBtnTap:(id)sender
{
    [[UMShareManager share] share:self
                        shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
                       shareImage:[UIImage imageNamed:@"UMS_douban_icon.png"]];
}

/**
 *  注销
 *
 *  @param sender 无
 */
- (IBAction)logoutBtnTap:(id)sender
{
    switch (((UIButton *)sender).tag) {
        case 300:
            [[UMShareManager share] logout:LoginTypeWeChat];
            break;
        case 301:
            [[UMShareManager share] logout:LoginTypeWeibo];
            break;
        case 302:
            [[UMShareManager share] logout:LoginTypeQQ];
            break;
        default:
            break;
    }
}


@end

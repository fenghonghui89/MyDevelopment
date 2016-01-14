//
//  PPLoginSucceedNotiView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-4-17.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPBaseView.h"
/**
 *  登录成功，欢迎回来页面
 */
@interface PPLoginSucceedNotiView : UIImageView
{
    UIImageView *ppLogoImageView;
    UILabel *userNameLabel;
    BOOL isShow;
}

+ (PPLoginSucceedNotiView *)sharedInstance;
-(void)showNotiView;
@end



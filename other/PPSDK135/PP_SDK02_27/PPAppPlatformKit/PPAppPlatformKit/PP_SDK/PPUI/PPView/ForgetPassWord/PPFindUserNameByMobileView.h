//
//  PPFindUserNameByMobile.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-11.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPMBProgressHUD.h"
#import "PPWebViewData.h"
/**
 *  通过手机号 找回账号
 */
@interface PPFindUserNameByMobileView : PPBaseView
<
PPWebViewDataDelegate
>
{
    UIButton *_confirmButton;
    UIImageView *_mobileImageView;
    UILabel *_mobileLabel;
    UITextField *_mobileTextField;
    PPMBProgressHUD *mbProgressHUD;
}

- (void) showPPFindUserNameByMobileViewByRight;
- (void) showPPFindUserNameByMobileViewByLeft;
@end


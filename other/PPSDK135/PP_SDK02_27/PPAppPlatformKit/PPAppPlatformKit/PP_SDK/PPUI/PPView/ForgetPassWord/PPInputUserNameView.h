//
//  PPInputUserName.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-5.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPMBProgressHUD.h"
/**
 *  忘记密码， 输入用户名，先验证用户名的存在，在找回密码
 */
@interface PPInputUserNameView : PPBaseView
{
    UIButton *_confirmButton;
    UIImageView *_userNameImageView;
    UILabel *_userNameLabel;
    UITextField *_userNameField;

}

- (void) showPPInputUserNameViewByRight;
- (void) showPPInputUserNameViewByLeft;
@end

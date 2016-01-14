//
//  PPPasswordProtectionView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-10.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPBaseView.h"
#import "PPCenterTableViewCell.h"
#import "PPWebViewData.h"
#import "PPMBProgressHUD.h"

/*
 标识当前页面
 */
typedef enum {
	PPVerificationModeQuestion = 1,
	PPVerificationModeMailBox = 2,
    PPVerificationModePhone = 3,
} PPVerificationMode;


/**
 *  密保设置页面
 */
@interface PPPasswordProtectionView : PPBaseView //PPBaseView <UIGestureRecognizerDelegate,UITextFieldDelegate>
<
UITableViewDelegate,
UITableViewDataSource,
PPWebViewDataDelegate
>
{
    UITableView *_passwordProtectionSettingTableView;
    
    //账号是否绑定到邮箱
    BOOL isBoundToMailBox;
    //账号是否绑定到手机
    BOOL isBoundToPhoneNumber;
    //账号是否设置密保问题
    BOOL isBoundToSecretQuestions;
    
    PPMBProgressHUD *ppMBProgressHUD;
    NSDictionary *_tableViewDic;
    int _userInfoSecurityLevel;
}





/// <summary>
/// 密保设置页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showPasswordProtectionViewByRight;


/// <summary>
/// 密保设置页面从左边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showPasswordProtectionViewByLeft;

@end

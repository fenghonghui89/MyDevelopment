
//  PPCenterView.h
//  PPUserUIKit
//
//  Created by seven  mr on 1/23/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPHyperlinkLabel.h"
#import "PPBaseView.h"
#import "PPCenterTableViewCell.h"
#import "PPWebViewData.h"

/**
 *  PP用户中心
 */
@interface PPCenterView : PPBaseView
<
UIAlertViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
PPWebViewDataDelegate
>
{
    
    UITableView *_centerTableView;
    UITextField *userNameText;
    UIButton *bindUserInfoButton;
    UIButton *updatePassWordButton;
    UIButton *userInfoProvingButton;
    UIButton *logoffActiveUserButton;
    UIButton *goBBSButton;
    
    UIButton *rechargeButton;
    UIButton *rechargeRecordButton;
    UIButton *consumeRecordButton;
    UIButton *helpButton;
    
    double balance;
}

/**
 *  用户中心从右边展示
 */
-(void)showCenterViewByRight;

/**
 *  用户中心从左边展示
 */
-(void)showCenterViewByLeft;

@end

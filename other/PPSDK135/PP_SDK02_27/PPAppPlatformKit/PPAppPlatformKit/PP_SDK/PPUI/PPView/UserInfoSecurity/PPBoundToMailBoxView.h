//
//  PPBoundToMailBoxView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-11.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPBaseView.h"
#import "PPMBProgressHUD.h"
#import "PPWebViewData.h"
#import "PPPasswordProtectionView.h"

/**
 *  绑定，检查，验证，邮箱
 */
@interface PPBoundToMailBoxView : PPBaseView //PPBaseView <UIGestureRecognizerDelegate,UITextFieldDelegate>
<
PPWebViewDataDelegate,
UITableViewDataSource,
UITableViewDelegate
>
{
    UIImageView *boundToMailBoxImageView;
    UIButton *_boundGetCodeButton;
    UIButton *boundToMailBoxButton;

    UIImageView *_boundCodeImageView;
    UITextField *_boundCodeTextfield;
    
    PPMBProgressHUD *ppMBProgressHUD;
    UITableView *_tableView;
    NSMutableArray *_tableViewArray;
    NSMutableArray *_allArray;
}

@property (nonatomic, assign) BOOL isUpdate;
@property (nonatomic, retain) NSString *oldEmail;
@property (nonatomic, retain) UITextField *boundToMailBoxTextfield;

@property (nonatomic, assign) PPVerificationMode nextView;



/// <summary>
/// 绑定邮箱页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showBoundToMailBoxViewByRight;


///// <summary>
///// 绑定邮箱页面从左边展示
///// </summary>
///// <returns>无返回</returns>
//-(void)showBoundToMailBoxViewByLeft;

@end

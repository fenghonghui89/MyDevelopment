//
//  PPFindPassWordByType.h
//  SDKDemoForFramework
//  招回帐号密码公用页面
//  Created by Seven on 13-11-5.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPMBProgressHUD.h"
#import "PPWebViewData.h"


/**
 *  找回方式页面（找回密码，找账号）
 */
@interface PPFindPassWordByTypeView : PPBaseView
<
UITableViewDelegate,
UITableViewDataSource,
PPWebViewDataDelegate
>
{
    UITableView *_passwordProtectionSettingTableView;
    
    //账号是否绑定到邮箱
    BOOL _isBoundToMailBox;
    //账号是否绑定到手机
    BOOL _isBoundToPhoneNumber;
    //账号是否设置密保问题
    BOOL _isBoundToSecretQuestions;
    PPMBProgressHUD *ppMBProgressHUD;
    NSDictionary *_tableViewDic;
}

@property (nonatomic, retain) NSString *currUserName;
@property (nonatomic, assign) BOOL forgetUserNameOrPass;


- (void) showPPFindPassWordByTypeViewByRight;
- (void) showPPFindPassWordByTypeViewByLeft;

@end

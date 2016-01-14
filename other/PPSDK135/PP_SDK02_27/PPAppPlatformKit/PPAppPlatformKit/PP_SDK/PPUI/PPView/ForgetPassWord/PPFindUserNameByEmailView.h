//
//  PPFindUserNameByEmailView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-8.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPMBProgressHUD.h"
#import "PPWebViewData.h"
/**
 *  通过邮箱找回账号 
 */
@interface PPFindUserNameByEmailView : PPBaseView
<
PPWebViewDataDelegate,
UITableViewDataSource,
UITableViewDelegate
>
{
    UIImageView *_boundToMailBoxImageView;
    UILabel *_boundToMailBoxLabel;
    UITextField *_boundToMailBoxTextfield;
    
    
    
    UIButton *_boundToMailBoxButton;
    PPMBProgressHUD *ppMBProgressHUD;
    
    UITableView *_tableView;
    NSMutableArray *_tableViewArray;
    NSMutableArray *_allArray;
    NSMutableArray *_emailAddressArray;
}





-(void)showFindUserNameByEmailViewByRight;
-(void)showFindUserNameByEmailViewByLeft;

@end

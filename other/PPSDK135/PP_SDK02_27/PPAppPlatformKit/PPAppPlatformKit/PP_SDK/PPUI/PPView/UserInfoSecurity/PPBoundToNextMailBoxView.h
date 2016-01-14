//
//  PPBoundToNextMailBoxView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-28.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPWebViewData.h"
#import "PPMBProgressHUD.h"
/**
 *  绑定邮箱
 */
@interface PPBoundToNextMailBoxView : PPBaseView
<
PPWebViewDataDelegate,
UITableViewDataSource,
UITableViewDelegate
>
{
    UIImageView *boundToMailBoxImageView;
    UILabel *boundToMailBoxLabel;
    UITextField *boundToMailBoxTextfield;
    

    
    UIButton *boundToMailBoxButton;
    PPMBProgressHUD *ppMBProgressHUD;
    
    UITableView *_tableView;
    NSMutableArray *_tableViewArray;
    NSMutableArray *_allArray;
    
    //NOTE For KT
    BOOL _textFieldShowClear;
    
}
@property (nonatomic, retain) NSString *nextCode;

/// <summary>
/// 绑定邮箱页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showBoundToNextMailBoxViewByRight;

@end

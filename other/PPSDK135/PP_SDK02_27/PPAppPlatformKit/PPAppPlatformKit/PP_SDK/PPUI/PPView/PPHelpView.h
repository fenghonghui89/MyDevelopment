//
//  PPHelpView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-9.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPWebViewData.h"
#import "PPMBProgressHUD.h"

/**
 *  帮助中心
 */
@interface PPHelpView : PPBaseView //PPBaseView <UIGestureRecognizerDelegate,UITextFieldDelegate>
<
UITableViewDataSource,
UITableViewDelegate,
PPWebViewDataDelegate
>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    int lastHitSection;
    PPMBProgressHUD *_ppMBProgressHUD;
}
@end

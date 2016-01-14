//
//  PPForgetWhat.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-7.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"

/**
 *  忘记密码，账号选择页面
 */
@interface PPForgetWhatView : PPBaseView
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView *_tableView;
    NSDictionary *_tableViewDic;
}

- (void)showPPPForgetWhatViewByRight;
- (void)showPPPForgetWhatViewByLeft;
@end
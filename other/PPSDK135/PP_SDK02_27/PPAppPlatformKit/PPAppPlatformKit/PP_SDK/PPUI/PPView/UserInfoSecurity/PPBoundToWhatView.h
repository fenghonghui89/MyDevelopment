//
//  PPBoundToWhatView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-12-10.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPPasswordProtectionView.h"

/**
 *  选择验证方式
 */
@interface PPBoundToWhatView : PPBaseView //PPBaseView <UIGestureRecognizerDelegate,UITextFieldDelegate>
<
UITableViewDataSource,
UITableViewDelegate
>
{
    UITableView *_tableView;
    
}
@property(nonatomic,retain)NSDictionary *tableViewDic;
@property(nonatomic,assign)PPVerificationMode nextView;
@property(nonatomic,retain)NSMutableArray* nextViewArray;
- (void)showPPBoundToWhatViewByRight;
- (void)showPPBoundToWhatViewByLeft;
@end

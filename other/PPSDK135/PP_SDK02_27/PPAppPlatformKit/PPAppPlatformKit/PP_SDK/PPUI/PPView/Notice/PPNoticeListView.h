//
//  PPNoticeListView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-22.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "RMPersonTableViewCell.h"
#import "PPNoticeManager.h"
#import "MJRefreshHeaderView.h"
#import "PPRefreshFootMoreView.h"


typedef NS_ENUM(NSInteger, PageType) {
    PageTypeOfNoti = 1,                   //公告
    PageTypeOfEmail = 2                  //邮件
};




@interface PPNoticeListView : PPBaseView<UITableViewDataSource,UITableViewDelegate,RMSwipeTableViewCellDelegate,PPNoticeManagerDelegate,MJRefreshBaseViewDelegate>
{
    PPMBProgressHUD *_ppMBProgressHUD;
    UITableView *_tableView;
    NSMutableArray *_tableArray;
    UIView *_headSegView;
    UIView *_segmentedControlButtonView;
    UIView *_footToolView;
    UIImageView *noRecordView;
    
    UIButton *_markToReadedButton;
    UIButton *_markToUnreadedButton;
    UIButton *_deleteSelectedMailButton;
    
    
    CGFloat _oldY;
    
    UIView *_sectionView;
    CGFloat headSegView_newY;
    //底部View滑动偏移量
    CGFloat _footToolViewFixed_newY;

    UIButton *_editButton;
    UIButton *_selectAllButton;
    
    BOOL _isCheckedAll;
    
    PPRefreshFootMoreView *_footer;
    MJRefreshHeaderView *_header;
    int _currPage;

    
    //选中的行数组
    NSMutableArray *_selectedCellArray;
}
+ (PPNoticeListView *)sharedInstance;
-(void)showPPNoticeListViewByRight;
-(void)showPPNoticeListViewByLeft;

@property (nonatomic, assign) PageType pageType;
@property (nonatomic, assign) UIButton *notiButton;
@property (nonatomic, assign) UIButton *emailButton;
@property (nonatomic, assign) BOOL editStatus;
@property (nonatomic, assign) BOOL isCellAnimation;


- (void)segButtonTouchUpInside:(UIButton *)paramSender;


@end

//
//  PPSpendingRecordView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-16.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPDropDownView.h"
#import "PPSpendingRecordTableViewCell.h"
#import "PPWebViewData.h"
#import "PPRefreshFootMoreView.h"
#import "MJRefreshHeaderView.h"
#import "PPMBProgressHUD.h"

@interface PPSpendingRecordView : PPBaseView<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,PPDropDownViewDelegate,PPWebViewDataDelegate,MJRefreshBaseViewDelegate>
{
    
    //当前选择查询的到账状态
    PPOrderStatus _currentQureyedStatus;
    //当前选择查询的充值时间
    PPOrderData _currentQueryedTime;
    
    //查询界面顶端的segment
    UIView *querySegmentedView;

        
    //充值记录查询页面的上半部分view
    UIView *spendingRecordQueryView;
        
    UIImageView *spendingStatusImageView;
    UIImageView *spendingTimeImageView;
    UIImageView *queriedOrderIdImageView;
    
    UILabel *spendingStatusTitleLabel;
    UILabel *spendingTimeTitleLabel;
    UILabel *queriedOrderIdTitleLabel;
        
    UILabel *spendingStatusValueLabel;
    UILabel *spendingTimeValueLabel;
        
    UITextField *queriedOrderIdTextField;
        
    //界面的下拉按钮
    UIButton *spendingStatusListButton;
    UIButton *spendingTimeListButton;
        
    //查询按钮
    UIButton *queryByCombinedConditionsButton;
    UIButton *queryByOrderIdButton;
        
    //显示数据用的tableview
    UITableView *_spendingRecordTableView;
        
    //显示在tableview上方的view
    UIView *spendingRecordDataView;
    
    PPRefreshFootMoreView *_footer;
    MJRefreshHeaderView *_header;
    
    int _currPage;
//    NSMutableArray *tempArrForGrouping;
    
    //spendingRecordDataView的标签view，显示表头上文字的label
    UILabel *timeLabel;
    UILabel *orderIdLabel;
    UILabel *spendingAmountLabel;
    UILabel *gameNameLabel;
    UILabel *orderStatusLabel;
        
    //标记当前展示的是哪个view(0表示初始化时展示的查询界面view，1表示点查询按钮是展示的数据列表view)
    int currentDisplayedView;
    //标记当前是按哪个条件查询（1表示当前按时间查询，2表示当前按订单号查询）
    int currentQueriedCondition;
    PPDropDownView *spendingStatusListView;
    PPDropDownView *spendingTimeListView;
    
    PPMBProgressHUD *mbProgressHUD;
    
    UIImageView *noRecordView;
    
    
    NSMutableArray *_sortedArrForArrays;
    NSMutableArray *_sectionHeadsKeys;

}



//从右边展示
-(void)showSpendingRecordViewByRight;

@end

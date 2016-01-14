//
//  PPRechargeRecordView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-8.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPBaseView.h"
#import "PPDropDownView.h"
#import "PPWebViewData.h"
#import "PPRefreshFootMoreView.h"
#import "MJRefreshHeaderView.h"
#import "PPMBProgressHUD.h"

@interface PPRechargeRecordView : PPBaseView<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,PPDropDownViewDelegate,PPWebViewDataDelegate,MJRefreshBaseViewDelegate>

{
   //当前选择查询的到账状态
    PPOrderStatus _currentQureyedStatus;
    //当前选择查询的充值时间
    PPOrderData _currentQueryedTime;
    
    //充值记录查询页面的上半部分view
    UIView *rechargeRecordQueryView;
    
    //查询界面顶端的segment
    UIView *querySegmentedView;
    
//    UISegmentedControl *queryViewSegment;
    
    UIImageView *rechargeStatusImageView;
    UIImageView *rechargeTimeImageView;
    UIImageView *queriedOrderIdImageView;
    
    UILabel *rechargeStatusTitleLabel;
    UILabel *rechargeTimeTitleLabel;
    UILabel *queriedOrderIdTitleLabel;
    
    UILabel *rechargeStatusValueLabel;
    UILabel *rechargeTimeValueLabel;
    
    UITextField *queriedOrderIdTextField;
    
    //界面的下拉按钮
    UIButton *rechargeStatusListButton;
    UIButton *rechargeTimeListButton;
    
    //查询按钮
    UIButton *queryByCombinedConditionsButton;
    UIButton *queryByOrderIdButton;
    
    //显示数据用的tableview
    UITableView *_rechargeRecordTableView;
    
    //显示在tableview上方的view
    UIView *rechargeRecordDataView;
    UIImageView *noRecordView;
    
    PPMBProgressHUD *mbProgressHUD;
    
    PPRefreshFootMoreView *_footer;
    MJRefreshHeaderView *_header;
    int _currPage;
    //表头上的标签加到这个view上
    UILabel *timeLabel;
    UILabel *orderIdLabel;
    UILabel *rechargeAmountLabel;
    UILabel *arrivedAmountLabel;
    UILabel *rechargeTypeLabel;
    UILabel *rechargeStatusLabel;
    
    //标记当前展示的是哪个view(0表示初始化时展示的查询界面view，1表示点查询按钮是展示的数据列表view)
    int currentDisplayedView;
    
    //标记当前是按哪个条件查询（1表示当前按时间查询，2表示当前按订单号查询）
    int currentQueriedCondition;
    PPDropDownView *rechargeStatusListView;
    PPDropDownView *rechargeTimeListView;
    
    NSMutableArray *_sortedArrForArrays;
    NSMutableArray *_sectionHeadsKeys;
}




//从右边展示
-(void)showRechargeRecordViewByRight;


@end

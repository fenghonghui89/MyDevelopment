//
//  PPRechargeRecordView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-8.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPRechargeRecordView.h"
#import "PPUIKit.h"
#import "PPCenterView.h"
#import "PPRechargeRecordTableViewCell.h"
#import "PPCommon.h"
#import "PPListItemView.h"


@implementation PPRechargeRecordView

-(id)init{
    self=[super init];
    if (self) {
        [_bgImageView setClipsToBounds:YES];
        [self.backButton setHidden:NO];
        [_titleLabel setText:@"充值记录"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleRechangeRecord"]];
        currentDisplayedView=0;
        _currPage = 1;
        
        if (_sortedArrForArrays) {
            [_sortedArrForArrays release];
            _sortedArrForArrays = nil;
        }
        
        if (_sectionHeadsKeys) {
            [_sectionHeadsKeys release];
            _sectionHeadsKeys = nil;
        }
        
        _sortedArrForArrays = [[NSMutableArray alloc] init];
        //initialize a array to hold tableview‘s header keys
        _sectionHeadsKeys = [[NSMutableArray alloc] init];
        //默认查询今天的记录
        _currentQueryedTime = PPOrderDataToday;
        //默认查询成功状态的记录
        _currentQureyedStatus = PPOrderStatusSucceed;
   
        rechargeRecordQueryView = [[UIView alloc] init];
        [rechargeRecordQueryView setBackgroundColor:[UIColor clearColor]];
        [_bgImageView insertSubview:rechargeRecordQueryView belowSubview:_topView];
        [rechargeRecordQueryView release];
        
        querySegmentedView = [[UIView alloc] init];
        [[querySegmentedView layer] setMasksToBounds:YES];
        [[querySegmentedView layer] setCornerRadius:3.0f];
        [[querySegmentedView layer] setBorderWidth:1.0f];
        [[querySegmentedView layer] setBorderColor:[[PPCommon getColor:@"2181f7"] CGColor]];
        [rechargeRecordQueryView addSubview:querySegmentedView];
        [querySegmentedView release];
        
        for (int i = 0; i<2; i++) {
            
            UIButton *segmentedButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [segmentedButton setFrame:CGRectMake(150 * i, 0, 150, 29)];
            [querySegmentedView addSubview:segmentedButton];
            [segmentedButton setTag:i];
            [[segmentedButton titleLabel] setFont:[UIFont systemFontOfSize:15.0f]];
            if (i == 0) {
                [segmentedButton setTitle:@"按组合条件查询" forState:UIControlStateNormal];
                [segmentedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [segmentedButton setBackgroundColor:[PPCommon getColor:@"2181f7"]];
            }
            else{
                [segmentedButton setTitle:@"按订单号码查询" forState:UIControlStateNormal];
                [segmentedButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
                [segmentedButton setBackgroundColor:[UIColor whiteColor]];
            }
            [segmentedButton addTarget:self action:@selector(segmentedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }

        rechargeStatusImageView = [[UIImageView alloc] init];
        [rechargeStatusImageView setUserInteractionEnabled:YES];
        [rechargeRecordQueryView addSubview:rechargeStatusImageView];
        [rechargeStatusImageView release];
        
        rechargeStatusTitleLabel = [[UILabel alloc] init];
        [rechargeStatusTitleLabel setBackgroundColor:[UIColor clearColor]];
        [rechargeStatusTitleLabel setText:@"到账状态"];
        [rechargeStatusTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [rechargeStatusTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [rechargeStatusImageView addSubview:rechargeStatusTitleLabel];
        [rechargeStatusTitleLabel release];
        
        
        rechargeStatusValueLabel = [[UILabel alloc] init];
        [rechargeStatusValueLabel setBackgroundColor:[UIColor clearColor]];
        [rechargeStatusValueLabel setText:@"充值成功"];
        [rechargeStatusValueLabel setFont:[UIFont systemFontOfSize:15]];
        [rechargeStatusValueLabel setTextAlignment:NSTextAlignmentLeft];
        [rechargeStatusImageView addSubview:rechargeStatusValueLabel];
        [rechargeStatusValueLabel release];
        
        rechargeStatusListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [rechargeStatusListButton addTarget:self action:@selector(rechargeStatusListButtonPressedDown) forControlEvents:UIControlEventTouchUpInside];
        [rechargeStatusImageView addSubview:rechargeStatusListButton];
        
        rechargeStatusListView =[[PPDropDownView alloc] init];
        rechargeStatusListView.selectedIndex = 1;
        [rechargeStatusListView setDelegate:self];
        [rechargeRecordQueryView addSubview:rechargeStatusListView];
        [rechargeStatusListView release];

        [rechargeStatusListView addItemWithButtonTitle:@"充值失败" itemFrame:CGRectMake(0, 0, _bgImageView.frame.size.width, 44)];
        [rechargeStatusListView addItemWithButtonTitle:@"充值成功" itemFrame:CGRectMake(0, 44, _bgImageView.frame.size.width, 44)];
        [rechargeStatusListView addItemWithButtonTitle:@"充值取消" itemFrame:CGRectMake(0, 44 * 2, _bgImageView.frame.size.width, 44)];
        [rechargeStatusListView addItemWithButtonTitle:@"全部状态" itemFrame:CGRectMake(0, 44 * 3, _bgImageView.frame.size.width, 44)];


        rechargeTimeListView =[[PPDropDownView alloc] init];
        rechargeTimeListView.selectedIndex = 0;
        [rechargeTimeListView setDelegate:self];
        [rechargeRecordQueryView addSubview:rechargeTimeListView];
        [rechargeTimeListView release];
        
        [rechargeTimeListView addItemWithButtonTitle:@"今天内" itemFrame:CGRectMake(0, 0, _bgImageView.frame.size.width, 44)];
        [rechargeTimeListView addItemWithButtonTitle:@"本月内" itemFrame:CGRectMake(0, 44, _bgImageView.frame.size.width, 44)];
        [rechargeTimeListView addItemWithButtonTitle:@"上一个月" itemFrame:CGRectMake(0, 44 * 2, _bgImageView.frame.size.width, 44)];
        [rechargeTimeListView addItemWithButtonTitle:@"上两个月" itemFrame:CGRectMake(0, 44 * 3, _bgImageView.frame.size.width, 44)];

        
        rechargeTimeImageView = [[UIImageView alloc] init];
        [rechargeTimeImageView setUserInteractionEnabled:YES];
        [rechargeRecordQueryView addSubview:rechargeTimeImageView];
        [rechargeTimeImageView release];
        
        rechargeTimeTitleLabel = [[UILabel alloc] init];
        [rechargeTimeTitleLabel setBackgroundColor:[UIColor clearColor]];
        [rechargeTimeTitleLabel setText:@"充值时间"];
        [rechargeTimeTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [rechargeTimeTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [rechargeTimeImageView addSubview:rechargeTimeTitleLabel];
        [rechargeTimeTitleLabel release];
        
        rechargeTimeValueLabel = [[UILabel alloc] init];
        [rechargeTimeValueLabel setBackgroundColor:[UIColor clearColor]];
        [rechargeTimeValueLabel setText:@"今天内"];
        [rechargeTimeValueLabel setFont:[UIFont systemFontOfSize:15]];
        [rechargeTimeValueLabel setTextAlignment:NSTextAlignmentLeft];
        [rechargeTimeImageView addSubview:rechargeTimeValueLabel];
        [rechargeTimeValueLabel release];
        
        rechargeTimeListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rechargeTimeListButton addTarget:self action:@selector(rechargeTimeListButtonPressedDown) forControlEvents:UIControlEventTouchUpInside];
        [rechargeTimeImageView addSubview:rechargeTimeListButton];
        
        queryByCombinedConditionsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [queryByCombinedConditionsButton setTitle:@"按组合条件查询" forState:UIControlStateNormal];
        [queryByCombinedConditionsButton addTarget:self action:@selector(queryByCombinedConditionsButtonPressedDown) forControlEvents:UIControlEventTouchUpInside];
        [queryByCombinedConditionsButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [queryByCombinedConditionsButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [rechargeRecordQueryView addSubview:queryByCombinedConditionsButton];
        
        queriedOrderIdImageView = [[UIImageView alloc] init];
        [queriedOrderIdImageView setUserInteractionEnabled:YES];
        [rechargeRecordQueryView addSubview:queriedOrderIdImageView];
        [queriedOrderIdImageView setHidden:YES];
        [queriedOrderIdImageView release];
   
        queriedOrderIdTitleLabel = [[UILabel alloc] init];
        [queriedOrderIdTitleLabel setBackgroundColor:[UIColor clearColor]];
        [queriedOrderIdTitleLabel setText:@"订单号码"];
        [queriedOrderIdTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [queriedOrderIdTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [queriedOrderIdImageView addSubview:queriedOrderIdTitleLabel];
        [queriedOrderIdTitleLabel release];
        
        queriedOrderIdTextField = [[UITextField alloc] init];
        [queriedOrderIdTextField setDelegate:self];
        [queriedOrderIdTextField setPlaceholder:@"请输入订单号码"];
        [queriedOrderIdTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [queriedOrderIdTextField setFont:[UIFont systemFontOfSize:15]];
        [queriedOrderIdTextField setReturnKeyType:UIReturnKeyDone];
        [queriedOrderIdTextField setKeyboardType:UIKeyboardTypeDecimalPad];
        queriedOrderIdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [queriedOrderIdImageView addSubview:queriedOrderIdTextField];
        [queriedOrderIdTextField release];
        
        
        queryByOrderIdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [queryByOrderIdButton setTitle:@"按订单号查询" forState:UIControlStateNormal];
        [queryByOrderIdButton addTarget:self action:@selector(queryByOrderIdButtonPressedDown) forControlEvents:UIControlEventTouchUpInside];
        [queryByOrderIdButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [queryByOrderIdButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [queryByOrderIdButton setHidden:YES];
        [rechargeRecordQueryView addSubview:queryByOrderIdButton];
        
        rechargeRecordDataView = [[UIView alloc] init];
        [rechargeRecordDataView setBackgroundColor:[UIColor clearColor]];
        [_bgImageView insertSubview:rechargeRecordDataView belowSubview:_topView];
        [rechargeRecordDataView release];

        noRecordView = [[UIImageView alloc] init];
        [rechargeRecordDataView addSubview:noRecordView];
        [noRecordView setHidden:YES];
        [noRecordView release];

        UILabel *noRecordLabel = [[UILabel alloc] init];
        [noRecordLabel setFrame:CGRectMake(-30, 50, 110, 30)];
        [noRecordLabel setText:@"T_T 暂无记录"];
        [noRecordLabel setTextColor:[PPCommon getColor:@"cccccc"]];
        [noRecordLabel setBackgroundColor:[UIColor clearColor]];
        [noRecordLabel setTextAlignment:NSTextAlignmentCenter];
        [noRecordLabel setFont:[UIFont systemFontOfSize:14]];
        [noRecordView addSubview:noRecordLabel];
        [noRecordLabel release];

        
        timeLabel = [self initRechargeRecordHeaderLabel:timeLabel withText:@"充值\n时间" numberOfLines:2];
        [timeLabel setTextAlignment:NSTextAlignmentLeft];
        [rechargeRecordDataView addSubview:timeLabel];
        
        orderIdLabel = [self initRechargeRecordHeaderLabel:timeLabel withText:@"订单\n号码" numberOfLines:2];
        [rechargeRecordDataView addSubview:orderIdLabel];

        rechargeAmountLabel = [self initRechargeRecordHeaderLabel:timeLabel withText:@"充值\n金额\n(元)" numberOfLines:3];
        [rechargeRecordDataView addSubview:rechargeAmountLabel];
        
        arrivedAmountLabel = [self initRechargeRecordHeaderLabel:timeLabel withText:@"实际\n到账\n(PP币)" numberOfLines:3];
        [rechargeRecordDataView addSubview:arrivedAmountLabel];
        
        rechargeTypeLabel = [self initRechargeRecordHeaderLabel:timeLabel withText:@"充值\n方式" numberOfLines:2];
        [rechargeRecordDataView addSubview:rechargeTypeLabel];
        
        rechargeStatusLabel = [self initRechargeRecordHeaderLabel:timeLabel withText:@"到账\n状态" numberOfLines:2];
        [rechargeRecordDataView addSubview:rechargeStatusLabel];

        _rechargeRecordTableView=[[UITableView alloc] init];
        [_rechargeRecordTableView setDelegate:self];
        [_rechargeRecordTableView setDataSource:self];
        [_rechargeRecordTableView setBackgroundColor:[UIColor clearColor]];
        [rechargeRecordDataView addSubview:_rechargeRecordTableView];
        [_rechargeRecordTableView release];

        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = self;
        _header.viewHeight = 65.0;
        [_header setBackgroundColor:[UIColor clearColor]];
        _header.scrollView = _rechargeRecordTableView;
        [_header release];
        
        // 上拉加载更多
        _footer = [[PPRefreshFootMoreView alloc] init];
        [_rechargeRecordTableView setTableFooterView:_footer];
        [_footer setBackgroundColor:[UIColor clearColor]];
        [_footer release];
        
        [noRecordView setImage:[[PPUIKit setLocaImage:@"PPNoRecord"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        [rechargeStatusImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [rechargeTimeImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [queriedOrderIdImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        [rechargeStatusListButton setImage:[PPUIKit setLocaImage:@"PPArrowRight"] forState:UIControlStateNormal];
        [rechargeTimeListButton setImage:[PPUIKit setLocaImage:@"PPArrowRight"] forState:UIControlStateNormal];
        
        //查询按钮
        [queryByCombinedConditionsButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]
                                                   forState:UIControlStateNormal];
        [queryByOrderIdButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]
                                        forState:UIControlStateNormal];

        mbProgressHUD = [[PPMBProgressHUD alloc] initWithView:_rechargeRecordTableView];
        [_rechargeRecordTableView addSubview:mbProgressHUD];
        [mbProgressHUD release];

        [self initVerticalFrame];
    }
    return self;
}


//竖
-(void)initVerticalFrame{
    
    [super initVerticalFrame];
    [querySegmentedView setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, 15, 300, 29)];
    if (currentDisplayedView == 0)
    {
        for (UIView *view in [querySegmentedView subviews]) {
            CGRect rect = [view frame];
            rect.size.height = querySegmentedView.frame.size.height;
            rect.size.width = querySegmentedView.frame.size.width / 2;
            if (view.tag == 0) {
                rect.origin.x = 0;
            }
            else
            {
                rect.origin.x = querySegmentedView.frame.size.width / 2;
            }
            [view setFrame:rect];
        }
        [self reloadViewsForHeight:44];
    }
    else
    {
        [self reloadDataView];
    }

    [_header setFrame:CGRectMake(0, -65, _bgImageView.frame.size.width, 65)];
    
    CGRect arrowRect = _header.arrowImage.frame;
    arrowRect.size.height = 55.0f;
    [_header.arrowImage setFrame:arrowRect];
    
    CGRect statusLabelRect = _header.lastUpdateTimeLabel.frame;
    statusLabelRect.origin.y = 30.0f;
    [_header.lastUpdateTimeLabel setFrame:statusLabelRect];
    
    _header.viewHeight = 65.0;

}

//横
-(void)initHorizontalFrame{
    
    [super initHorizontalFrame];
    
    [querySegmentedView setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, 15, 300, 29)];
    if (currentDisplayedView == 0)
    {
        for (UIView *view in [querySegmentedView subviews]) {
            CGRect rect = [view frame];
            rect.size.height = querySegmentedView.frame.size.height;
            rect.size.width = querySegmentedView.frame.size.width / 2;
            if (view.tag == 0) {
                rect.origin.x = 0;
            }
            else
            {
                rect.origin.x = querySegmentedView.frame.size.width / 2;
            }
            [view setFrame:rect];
        }
        [self reloadViewsForHeight:35];
    }
    else
    {
        [self reloadDataView];
    }
    
    [_header setFrame:CGRectMake(0, -45, _bgImageView.frame.size.width, 45)];
    
    CGRect arrowRect = _header.arrowImage.frame;
    arrowRect.size.height = 35.0f;
    [_header.arrowImage setFrame:arrowRect];
    
    CGRect statusLabelRect = _header.lastUpdateTimeLabel.frame;
    statusLabelRect.origin.y = 25.0f;
    [_header.lastUpdateTimeLabel setFrame:statusLabelRect];
    
    _header.viewHeight = 45.0;
}

- (void)reloadDataView{
    //显示在tableview上方的view
    [rechargeRecordDataView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    if (_bgImageView.frame.size.width == 320) {
        //rechargeRecordDataView的标签view，显示表头上文字的label
        [timeLabel setFrame:CGRectMake(16, 0, 27, 62)];
        [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x+timeLabel.frame.size.width, 0, 95, 62)];
        [rechargeAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x+orderIdLabel.frame.size.width, 0, 45, 62)];
        [arrivedAmountLabel setFrame:CGRectMake(rechargeAmountLabel.frame.origin.x+rechargeAmountLabel.frame.size.width, 0, 45, 62)];
        [rechargeTypeLabel setFrame:CGRectMake(arrivedAmountLabel.frame.origin.x+arrivedAmountLabel.frame.size.width, 0, 47, 62)];
        [rechargeStatusLabel setFrame:CGRectMake(rechargeTypeLabel.frame.origin.x+rechargeTypeLabel.frame.size.width, 0, 40, 62)];
    }
    else if (_bgImageView.frame.size.width > 320)
    {
        int widthIncrement = (_bgImageView.frame.size.width - 320) / 5;
        //rechargeRecordDataView的标签view，显示表头上文字的label
        [timeLabel setFrame:CGRectMake(16, 0, 27 + widthIncrement, 62)];
        [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x+timeLabel.frame.size.width, 0, 95 + widthIncrement, 62)];
        [rechargeAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x+orderIdLabel.frame.size.width, 0, 50 + widthIncrement, 62)];
        [arrivedAmountLabel setFrame:CGRectMake(rechargeAmountLabel.frame.origin.x + rechargeAmountLabel.frame.size.width, 0, 50 + widthIncrement, 62)];
        [rechargeTypeLabel setFrame:CGRectMake(arrivedAmountLabel.frame.origin.x + arrivedAmountLabel.frame.size.width, 0, 37 + widthIncrement, 62)];
        [rechargeStatusLabel setFrame:CGRectMake(rechargeTypeLabel.frame.origin.x + rechargeTypeLabel.frame.size.width, 0, 40, 62)];
    }
    //显示数据用的tableview
    [_rechargeRecordTableView setFrame:CGRectMake(0, 62, rechargeRecordDataView.frame.size.width,rechargeRecordDataView.frame.size.height-62)];
    [noRecordView setFrame:CGRectMake((rechargeRecordDataView.frame.size.width - 50) / 2, (rechargeRecordDataView.frame.size.height - 80) / 2, 50, 50)];
}



- (void)reloadViewsForHeight:(float)height
{
    
    //充值记录查询页面的上半部分view
    [rechargeRecordQueryView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [rechargeStatusImageView setFrame:CGRectMake(0,querySegmentedView.frame.origin.y + querySegmentedView.frame.size.height + 20, _bgImageView.frame.size.width, height)];
    [queriedOrderIdImageView setFrame:CGRectMake(0, rechargeStatusImageView.frame.origin.y, _bgImageView.frame.size.width, height)];
    
    if ([rechargeStatusListView isOpen])
    {
        [rechargeStatusListView setFrame:CGRectMake(0, rechargeStatusImageView.frame.origin.y + rechargeStatusImageView.frame.size.height, rechargeStatusImageView.frame.size.width, height * 4)];
        
        int i = 0;
        int height = 0;
        if ([rechargeStatusListView.items count] > 0) {
            height = rechargeStatusListView.frame.size.height / [rechargeStatusListView.items count];
        }
        for (PPListItemView *itemView in [rechargeStatusListView items]) {
            CGRect rect = [itemView frame];
            rect.size.width = rechargeStatusListView.frame.size.width;
            rect.size.height = height;
            
            rect.origin.y = height * i;
            [itemView setFrame:rect];
            i++;
        }
    }
    else
    {
        [rechargeStatusListView setFrame:CGRectMake(0, rechargeStatusImageView.frame.origin.y + rechargeStatusImageView.frame.size.height, rechargeStatusImageView.frame.size.width, 0)];
    }

    [rechargeTimeImageView setFrame:CGRectMake(0, rechargeStatusListView.frame.origin.y + rechargeStatusListView.frame.size.height, _bgImageView.frame.size.width, height)];

    if ([rechargeTimeListView isOpen]) {
        [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y + rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, height * 4)];
        
        int i = 0;
        int height = 0;
        if ([rechargeTimeListView.items count] > 0) {
            height = rechargeTimeListView.frame.size.height / [rechargeTimeListView.items count];
        }
        for (PPListItemView *itemView in [rechargeTimeListView items]) {
            CGRect rect = [itemView frame];
            rect.size.width = rechargeTimeListView.frame.size.width;
            rect.size.height = height;
            
            rect.origin.y = height * i;
            [itemView setFrame:rect];
            i++;
        }
    }
    else{
        [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y + rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, 0)];
    }
    
    [rechargeStatusTitleLabel setFrame:CGRectMake(16, 0, 61, height)];
    [rechargeTimeTitleLabel setFrame:CGRectMake(16, 0, 61, height)];
    [queriedOrderIdTitleLabel setFrame:CGRectMake(16, 0, 61, height)];
    
    [rechargeStatusValueLabel setFrame:CGRectMake(rechargeStatusTitleLabel.frame.origin.x + rechargeStatusTitleLabel.frame.size.width + 16,0 , 61, height)];
    //        NSLog(@"rechargeStatusValueLabel.width = %f",rechargeStatusValueLabel.frame.origin.x);
    [rechargeTimeValueLabel setFrame:CGRectMake(rechargeTimeTitleLabel.frame.origin.x + rechargeTimeTitleLabel.frame.size.width + 16,0, 61, height)];
    
    [queriedOrderIdTextField setFrame:CGRectMake(queriedOrderIdTitleLabel.frame.origin.x + queriedOrderIdTitleLabel.frame.size.width + 16,0 , queriedOrderIdImageView.frame.size.width - queriedOrderIdTextField.frame.origin.x - 16, height)];
    
    //界面的下拉按钮
    [rechargeStatusListButton setFrame:CGRectMake(16, 0, rechargeStatusImageView.frame.size.width - 16, height)];
    [rechargeStatusListButton setImageEdgeInsets:UIEdgeInsetsMake(0, rechargeStatusListButton.frame.size.width - 25, 0, 16)];
    [rechargeTimeListButton setFrame:CGRectMake(16, 0, rechargeTimeImageView.frame.size.width - 16, height)];
    [rechargeTimeListButton setImageEdgeInsets:UIEdgeInsetsMake(0, rechargeTimeListButton.frame.size.width - 25, 0, 16)];
    
    //查询按钮
    [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width - 300) / 2, rechargeTimeListView.frame.origin.y+rechargeTimeListView.frame.size.height + 20, 300, height)];
    
    [queryByOrderIdButton setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, queriedOrderIdImageView.frame.origin.y + 44 + 20, 300, height)];
    
    //显示在tableview上方的view
    [rechargeRecordDataView setFrame:CGRectMake(0, _bgImageView.frame.size.height, _bgImageView.frame.size.width, _bgImageView.frame.size.height - 50)];
    
    if (_bgImageView.frame.size.width == 320) {
        //rechargeRecordDataView的标签view，显示表头上文字的label
        [timeLabel setFrame:CGRectMake(16, 0, 27, 62)];
        [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x + timeLabel.frame.size.width, 0, 95, 62)];
        [rechargeAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x + orderIdLabel.frame.size.width, 0, 45, 62)];
        [arrivedAmountLabel setFrame:CGRectMake(rechargeAmountLabel.frame.origin.x + rechargeAmountLabel.frame.size.width, 0, 45, 62)];
        [rechargeTypeLabel setFrame:CGRectMake(arrivedAmountLabel.frame.origin.x + arrivedAmountLabel.frame.size.width, 0, 47, 62)];
        [rechargeStatusLabel setFrame:CGRectMake(rechargeTypeLabel.frame.origin.x + rechargeTypeLabel.frame.size.width, 0, 40, 62)];
    }
    else if (_bgImageView.frame.size.width > 320)
    {
        int widthIncrement = (_bgImageView.frame.size.width - 320) / 5;
        //rechargeRecordDataView的标签view，显示表头上文字的label
        [timeLabel setFrame:CGRectMake(16, 0, 27 + widthIncrement, 62)];
        [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x + timeLabel.frame.size.width, 0, 95 + widthIncrement, 62)];
        [rechargeAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x + orderIdLabel.frame.size.width, 0, 50 + widthIncrement, 62)];
        [arrivedAmountLabel setFrame:CGRectMake(rechargeAmountLabel.frame.origin.x + rechargeAmountLabel.frame.size.width, 0, 50 + widthIncrement, 62)];
        [rechargeTypeLabel setFrame:CGRectMake(arrivedAmountLabel.frame.origin.x + arrivedAmountLabel.frame.size.width, 0, 37 + widthIncrement, 62)];
        [rechargeStatusLabel setFrame:CGRectMake(rechargeTypeLabel.frame.origin.x + rechargeTypeLabel.frame.size.width, 0, 40, 62)];
    }
    //显示数据用的tableview
    [_rechargeRecordTableView setFrame:CGRectMake(0, 62, rechargeRecordDataView.frame.size.width,rechargeRecordDataView.frame.size.height - 62)];

    [noRecordView setFrame:CGRectMake((rechargeRecordDataView.frame.size.width - 50) / 2, (rechargeRecordDataView.frame.size.height - 80) / 2, 50, 50)];
    
}


//----------------------------segment点选----------------------------------
- (void)segmentedButtonClicked:(UIButton *)button
{
    [rechargeStatusListView closeView];
    [rechargeTimeListView closeView];
    
    [self reloadViewsForHeight:rechargeStatusImageView.frame.size.height];
    
    [[rechargeStatusListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
    [[rechargeTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
    
    if ([button tag] == 0 ) {
        NSLog(@"按组合条件查询");
        [queriedOrderIdImageView setHidden:YES];
        [queryByOrderIdButton setHidden:YES];
        
        [rechargeStatusImageView setHidden:NO];
        [rechargeTimeImageView setHidden:NO];
        [queryByCombinedConditionsButton setHidden:NO];
        [queriedOrderIdTextField resignFirstResponder];
	}
	else if([button tag] == 1) {
        NSLog(@"按订单号码查询");
        [queriedOrderIdImageView setHidden:NO];
        [queryByOrderIdButton setHidden:NO];
        
        [rechargeStatusImageView setHidden:YES];
        [rechargeTimeImageView setHidden:YES];
        [queryByCombinedConditionsButton setHidden:YES];
	}
    for (UIButton * btn in [querySegmentedView subviews]) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn  == button) {
                [btn setBackgroundColor:[PPCommon getColor:@"2181f7"]];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            else{
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
            }
        }
        
    }
}

//-----------------------------tableview的代理----------------------------------

//设置每个组别中cell的个数
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    // 让刷新控件恢复默认的状态
    [_header endRefreshing];
    [[_footer infoLabel] setText:@"上拉即可刷新"];
    [[_footer activityIndicator] stopAnimating];
    return  [[_sortedArrForArrays objectAtIndex:section] count];
}

//设置组别个数
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sortedArrForArrays count];
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPRechargeRecordTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[[PPRechargeRecordTableViewCell alloc] init] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        int sectionNumber = [indexPath section];
        int rowNumber = [indexPath row];
        
        if ([_sortedArrForArrays count] > sectionNumber) {
            NSArray *arr = [_sortedArrForArrays objectAtIndex:sectionNumber];
            if ([arr count] > rowNumber) {
                
                NSDictionary *tempDic = [arr objectAtIndex:rowNumber];
                
                NSString *timeString = [[[tempDic objectForKey:@"datetime"] substringFromIndex:11] stringByReplacingOccurrencesOfString:@"-" withString:@":"];
                 
                 int status = [[tempDic objectForKey:@"status"] intValue];
                if (status == 1)
                {
                    [[cell rechargeStatusLabel] setText:@"成功"];
                }
                else
                {
                    [[cell rechargeStatusLabel] setText:@"失败"];
                }
                [[cell timeLabel] setText:timeString];
                [[cell orderIdLabel] setText:[NSString stringWithFormat:@"%@", [tempDic objectForKey:@"order_id"]]];
                [[cell rechargeAmountLabel] setText:[tempDic objectForKey:@"amount"]];
                [[cell arrivedAmountLabel] setText:[tempDic objectForKey:@"reamount"]];
                [[cell rechargeTypeLabel] setText:[tempDic objectForKey:@"type"]];
                
            }
            else {
                NSLog(@"arr out of range");
            }
        }
        else {
            NSLog(@"sortedArrForArrays out of range");
        }
    }

    return cell;
}


-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    if (_sectionHeadsKeys ) {
        if ([_sectionHeadsKeys count] >= section) {
            [view setFrame:CGRectMake(0, 0, _bgImageView.frame.size.width, 23)];
            [view setBackgroundColor:[PPCommon getColor:@"f7f7f7"]];
     
            UILabel *label = [[UILabel alloc] init];
            [label setFrame:CGRectMake(16, 0, 200, 23)];
            [label setBackgroundColor:[UIColor clearColor]];
            
            [label setText:[_sectionHeadsKeys objectAtIndex:section]];
            [label setFont:[UIFont boldSystemFontOfSize:10.0f]];
            [view addSubview:label];
            [label release];
        }
    }
    return [view autorelease];
}
//-----------------------------tableview的代理----------------------------------

//---------------------------------------点击查询按钮----------------------------
-(void)queryByCombinedConditionsButtonPressedDown{
    [queriedOrderIdTextField resignFirstResponder];
    [[_rechargeRecordTableView tableFooterView] setHidden:YES];
    
    [_sortedArrForArrays removeAllObjects];
    [_sectionHeadsKeys removeAllObjects];

    currentDisplayedView = 1;
    currentQueriedCondition = 1;
    
    [self hideRechargeRecordQueryViewInTop];
    [_header setState:RefreshStateRefreshing];
    
//    PPWebViewData *pp = [[PPWebViewData alloc] init];
//    [pp setDelegate:self];
//    [pp getRechargeRecordByTime:_currentQureyedStatus Data:_currentQueryedTime Page:_currPage];
//    [pp release];
}

-(void)queryByOrderIdButtonPressedDown{
    [queriedOrderIdTextField resignFirstResponder];
    
    [[_rechargeRecordTableView tableFooterView] setHidden:YES];
    
    NSString *orderId = [queriedOrderIdTextField text];
//    if ([orderId length] != 16)
//    {
//        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:@"订单号长度有误！请输入正确订单号"];
//        [alert setCancelButtonTitle:@"确定" block:^{
//        }];
//        [alert addButtonWithTitle:nil block:nil];
//        [alert show];
//        [alert release];
//    }
    if(![self isNumText:orderId])
    {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:@"订单号格式有误！请输入正确的订单号"];
        [alert setCancelButtonTitle:@"确定" block:^{
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    else
    {
        currentDisplayedView = 1;
        currentQueriedCondition = 2;
        [self hideRechargeRecordQueryViewInTop];
        
        [_header setState:RefreshStateRefreshing];
        
//        PPWebViewData *pp = [[PPWebViewData alloc] init];
//        [pp setDelegate:self];
//        [pp getRechargeRecordByOrderId:[queriedOrderIdTextField text]];
//        [pp release];
    }
}

//是否是纯数字
- (BOOL)isNumText:(NSString *)str{
    NSString * regex = @"[0-9]+$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
    
}

//---------------------------------------点击查询按钮----------------------------

//---------------------------查询页面和数据显示页面的切换---------------------------

- (void)showRechargeRecordQueryViewFromTop{
    
    [self onDeviceOrientationChange:NO];

    [UIView beginAnimations:@"showView2" context:nil];
    [rechargeRecordQueryView setFrame:CGRectMake(0, -_bgImageView.frame.size.height+50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [rechargeRecordDataView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [UIView setAnimationDuration:0.6];
    [rechargeRecordQueryView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [rechargeRecordDataView setFrame:CGRectMake(0, _bgImageView.frame.size.height, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)hideRechargeRecordQueryViewInTop{
    [_sortedArrForArrays removeAllObjects];
    [_sectionHeadsKeys removeAllObjects];
    [_rechargeRecordTableView reloadData];
    [noRecordView setHidden:YES];
    
    [self onDeviceOrientationChange:NO];
    [UIView beginAnimations:@"hideView2" context:nil];
    [rechargeRecordQueryView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [rechargeRecordDataView setFrame:CGRectMake(0, _bgImageView.frame.size.height, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];

    [UIView setAnimationDuration:0.6];
    [rechargeRecordQueryView setFrame:CGRectMake(0, -_bgImageView.frame.size.height+50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [rechargeRecordDataView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

//---------------------------查询页面和数据显示页面的切换-------------------------------------

//充值记录显示列表上方的View上的label的初始化方法
-(UILabel *)initRechargeRecordHeaderLabel:(UILabel *)label withText:(NSString *)text numberOfLines:(int)number{
    
    label = [[UILabel alloc]init];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:10.0f]];
    [label setTextColor:COLOR(2, 2, 2, 1)];
    [label setText:text];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setNumberOfLines:number];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    return [label autorelease] ;
}

//将日期转换成相应格式的字符串
- (NSString *)getStringFromDate:(NSDate *)date withFormat:(NSString *)format{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
//    [dateFormatter setDateFormat:@"yyyy年MM月dd日 EEEE"];
    [dateFormatter setDateFormat:format];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
//    NSLog(@"newDateString %@", dateString);
    [dateFormatter release];
    return dateString;
}

//将服务端返回的数组按日期分割成二维数组
- (NSMutableArray *)getSortedArrays:(NSMutableArray *)arrToSort {
    
    NSMutableArray *chineseStringsArray = [NSMutableArray array];
    for(int i = 0; i < [arrToSort count]; i++) {
        NSString *str = [[[arrToSort objectAtIndex:i] objectForKey:@"datetime"] substringToIndex:10];
        [chineseStringsArray addObject:str];
    }

    NSMutableArray *arrayForArrays = [[NSMutableArray alloc] init];
    BOOL checkValueAtIndex= _currPage == 1 ? NO : YES;  //flag to check
    
    NSMutableArray *tempArrForGrouping = [[NSMutableArray alloc] init];
    for(int index = 0; index < [chineseStringsArray count]; index++)
    {
        
        NSMutableString *sr= [chineseStringsArray objectAtIndex:index];
        if(![_sectionHeadsKeys containsObject:sr ])//here I'm checking whether the character already in the selection header keys or not
        {
            [_sectionHeadsKeys addObject:sr ];
            if (tempArrForGrouping) {
                [tempArrForGrouping release];
                tempArrForGrouping = nil;
            }
            tempArrForGrouping = [[NSMutableArray alloc] init];
            checkValueAtIndex = NO;
        }
        if([_sectionHeadsKeys containsObject:sr])
        {
            [tempArrForGrouping addObject:[arrToSort objectAtIndex:index]];
            if(checkValueAtIndex == NO)
            {
                [arrayForArrays addObject:tempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
    }
    [tempArrForGrouping release];
    return arrayForArrays;
}


//---------------------------------------下拉列表的处理--------------------------------------
- (void)rechargeStatusListButtonPressedDown{
    
//    NSLog(@"到账状态List按钮");
    float itemViewsHeight = rechargeStatusImageView.frame.size.height;
    if (rechargeStatusListView.isOpen) {
        
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [rechargeStatusListView setFrame:CGRectMake(0, rechargeStatusImageView.frame.origin.y+rechargeStatusImageView.frame.size.height, rechargeStatusImageView.frame.size.width, 0)];
    
        [rechargeTimeImageView setFrame:CGRectMake(0, rechargeStatusListView.frame.origin.y+rechargeStatusListView.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight)];
        
        
        [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y+rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, rechargeTimeListView.frame.size.height)];
       
        //查询按钮
        [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width - 300) / 2, rechargeTimeListView.frame.origin.y + rechargeTimeListView.frame.size.height + 20, 300, itemViewsHeight)];
         [rechargeStatusListView closeView];

        [[rechargeStatusListButton imageView] setTransform:CGAffineTransformMakeRotation(0)];
        [UIView commitAnimations];
    }
    else{
        int i = 0;
        
        for (PPListItemView *itemView in [rechargeStatusListView items]) {
            CGRect rect = [itemView frame];
            rect.size.width = rechargeStatusListView.frame.size.width;
            rect.size.height = itemViewsHeight;
            
            rect.origin.y = itemViewsHeight * i;
            [itemView setFrame:rect];
            i++;
        }

        if ([rechargeTimeListView isOpen]) {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            
            [rechargeStatusListView setFrame:CGRectMake(0, rechargeStatusImageView.frame.origin.y+rechargeStatusImageView.frame.size.height, rechargeStatusListView.frame.size.width, itemViewsHeight * 4)];
            [rechargeTimeImageView setFrame:CGRectMake(0, rechargeStatusListView.frame.origin.y+rechargeStatusListView.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight)];
            
            
            [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y+rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, 0)];
            
            //查询按钮
            [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width-300) / 2, rechargeTimeListView.frame.origin.y + rechargeTimeListView.frame.size.height + 20, 300, itemViewsHeight)];
            [rechargeStatusListView openView];
             [[rechargeStatusListButton imageView] setTransform:CGAffineTransformMakeRotation(1.57)];
            
            [rechargeTimeListView closeView];
            [rechargeTimeListButton setTransform:CGAffineTransformMakeRotation(0)];
 
            [UIView commitAnimations];
        }
        else
        {

            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            
            [rechargeStatusListView setFrame:CGRectMake(0, rechargeStatusImageView.frame.origin.y + rechargeStatusImageView.frame.size.height, rechargeStatusListView.frame.size.width, itemViewsHeight * 4)];
            [rechargeTimeImageView setFrame:CGRectMake(0, rechargeStatusListView.frame.origin.y + rechargeStatusListView.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight)];
            
            
            [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y + rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, rechargeTimeListView.frame.size.height)];
            
            //查询按钮
            [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width - 300) / 2, rechargeTimeListView.frame.origin.y + rechargeTimeListView.frame.size.height + 20, 300, itemViewsHeight)];
            [rechargeStatusListView openView];
             [[rechargeStatusListButton imageView] setTransform:CGAffineTransformMakeRotation(1.57)];
            
            [UIView commitAnimations];
        }
        [rechargeStatusListView selectItem:rechargeStatusListView.selectedIndex];
    }
}

-(void)rechargeTimeListButtonPressedDown{

    float itemViewsHeight = rechargeStatusImageView.frame.size.height;
    
    if (rechargeTimeListView.isOpen) {
        
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y + rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, 0)];
        
        //查询按钮
        [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width - 300) / 2, rechargeTimeListView.frame.origin.y + rechargeTimeListView.frame.size.height + 20, 300, itemViewsHeight)];
//        [rechargeTimeListButton setTransform : CGAffineTransformMakeRotation(0)];
        [[rechargeTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
        [rechargeTimeListView closeView];
        [UIView commitAnimations];
    }
    else{
        int i = 0;
        
        for (PPListItemView *itemView in [rechargeTimeListView items]) {
            CGRect rect = [itemView frame];
            rect.size.width = rechargeTimeListView.frame.size.width;
            rect.size.height = itemViewsHeight;
            
            rect.origin.y = itemViewsHeight * i;
            [itemView setFrame:rect];
            i++;
        }
        
        [rechargeTimeListView selectItem:rechargeTimeListView.selectedIndex];
        if ([rechargeStatusListView isOpen])
        {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            [rechargeStatusListView setFrame:CGRectMake(0, rechargeStatusImageView.frame.origin.y + rechargeStatusImageView.frame.size.height, rechargeStatusListView.frame.size.width, 0)];
            [rechargeTimeImageView setFrame:CGRectMake(0, rechargeStatusListView.frame.origin.y + rechargeStatusListView.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight)];
            [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y + rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, itemViewsHeight*4)];
            //查询按钮
            [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width - 300) / 2, rechargeTimeListView.frame.origin.y + rechargeTimeListView.frame.size.height + 20, 300, itemViewsHeight)];
//            [rechargeTimeListButton setTransform : CGAffineTransformMakeRotation(1.57)];
            [[rechargeTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(1.57)];
            [rechargeTimeListView openView];
//            [rechargeStatusListButton setTransform : CGAffineTransformMakeRotation(0)];
            [[rechargeStatusListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
            [rechargeStatusListView closeView];
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y + rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, itemViewsHeight * 4)];
            //查询按钮
            [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width - 300) / 2, rechargeTimeListView.frame.origin.y + rechargeTimeListView.frame.size.height + 20, 300, itemViewsHeight)];
//            [rechargeTimeListButton setTransform : CGAffineTransformMakeRotation(1.57)];
            [[rechargeTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(1.57)];
            [rechargeTimeListView openView];
            [UIView commitAnimations];
        }
    }
}

-(void)dropDownView:(PPDropDownView *)view selectedIndex:(NSInteger)index withInfo:(NSDictionary *)info{
    
    [view.selectedItem cancelSelectedState];
    view.selectedIndex = index;
    view.selectedItem = [view.items objectAtIndex:index];
    
    if (view == rechargeStatusListView) {
        [rechargeStatusValueLabel setText:[info objectForKey:@"itemText"]];
        _currentQureyedStatus = index;
        
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [view closeView];
        //    [self reloadViewsForHeight:rechargeStatusImageView.frame.size.height];
        
        [rechargeStatusListView setFrame:CGRectMake(0, rechargeStatusImageView.frame.origin.y + rechargeStatusImageView.frame.size.height, rechargeStatusImageView.frame.size.width, 0)];
        
        [rechargeTimeImageView setFrame:CGRectMake(0, rechargeStatusListView.frame.origin.y + rechargeStatusListView.frame.size.height, _bgImageView.frame.size.width, rechargeStatusImageView.frame.size.height)];
        
        
        [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y + rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, rechargeTimeListView.frame.size.height)];
        
        //查询按钮
        [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width - 300) / 2, rechargeTimeListView.frame.origin.y+rechargeTimeListView.frame.size.height + 20, 300, rechargeStatusImageView.frame.size.height)];
//        [rechargeStatusListButton setTransform : CGAffineTransformMakeRotation(0)];
        [[rechargeStatusListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
        
        [UIView commitAnimations];
        
    }
    else{
        [rechargeTimeValueLabel setText:[info objectForKey:@"itemText"]];
        _currentQueryedTime = index + 1;
        
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [view closeView];
        
        [rechargeTimeListView setFrame:CGRectMake(0, rechargeTimeImageView.frame.origin.y + rechargeTimeImageView.frame.size.height, rechargeTimeImageView.frame.size.width, rechargeTimeListView.frame.size.height)];
        
        //查询按钮
        [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width - 300) / 2, rechargeTimeListView.frame.origin.y+rechargeTimeListView.frame.size.height + 20, 300, rechargeStatusImageView.frame.size.height)];
        [[rechargeTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
        
        [UIView commitAnimations];
    }
}


//---------------------------------------下拉列表的处理--------------------------------------



//--------------------------------------刷新数据 并加载到tableview中------------------------
-(void)loadData:(int)page
{
    PPWebViewData *pp = [[PPWebViewData alloc] init];
    [pp  setDelegate:self];
    
    if (currentQueriedCondition == 1)
    {
        [pp getRechargeRecordByTime:_currentQureyedStatus Data:_currentQueryedTime Page:page];
    }
    else if(currentQueriedCondition == 2)
    {
        [pp getRechargeRecordByOrderId:[queriedOrderIdTextField text]];
    }
    
    [pp release];
}


#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH : mm : ss.SSS";
    if (_header == refreshView)
    {
        _currPage = 1;
        [self loadData:_currPage];
        [_footer setCanLoadMore:NO];
        
    }
    [formatter release];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollViewSystem{
    
    
    
    if (scrollViewSystem.contentOffset.y + scrollViewSystem.frame.size.height >= scrollViewSystem.contentSize.height)
    {
        if (_footer.canLoadMore &&_footer.isDragging)
        {
            [[_footer infoLabel] setText:@"加载中..."];
            //            [tableView setScrollEnabled:YES];
            [_footer setIsDragging:NO];
            [[_footer activityIndicator] startAnimating];
            _currPage ++;
            [self loadData:_currPage];
        }
    }
    
}

//--------------------------------------刷新数据 并加载到tableview中------------------------

//--------------------------------------请求查询数据的回调----------------------------------
-(void)rechargeRecordByTimeJsonResponseCallBack:(NSDictionary *)paramDic
{
    if (PP_ISNSLOG) {
        NSLog(@"---------paramDic---------%@",paramDic);
    }
//    [mbProgressHUD hide:YES];
    [_header endRefreshing];
    
    if ([[paramDic objectForKey:@"error"] intValue] == 0)
    {
        if ([[paramDic objectForKey:@"data"] count] == 0)
        {
            [_footer setCanLoadMore:NO];
            [[_rechargeRecordTableView tableFooterView] setHidden:YES];
            if (_currPage == 1)
            {
                [noRecordView setHidden:NO];
            }
            else
            {
                [noRecordView setHidden:YES];
            }
        }
        
        else if ([[paramDic objectForKey:@"data"] count] < 20)
        {
            [_footer setCanLoadMore:NO];
            [[_rechargeRecordTableView tableFooterView] setHidden:YES];
            [noRecordView setHidden:YES];
        }
        else
        {
            [_footer setCanLoadMore:YES];
            [[_rechargeRecordTableView tableFooterView] setHidden:NO];
            [noRecordView setHidden:YES];
        }

        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:[paramDic objectForKey:@"data"]];
        if (_currPage == 1)
        {
            

            [_sectionHeadsKeys removeAllObjects];
            [_sortedArrForArrays removeAllObjects];

            _sortedArrForArrays = [self getSortedArrays:tempArray];

        }
        else
        {
            [_sortedArrForArrays addObjectsFromArray:[self getSortedArrays:tempArray]];
        }
        [_footer setIsDragging:YES];
        [_rechargeRecordTableView reloadData];
        [tempArray release];
    }
    else
    {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ADDRESS message:[paramDic objectForKey:@"msg"]];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
}

//740613889 123456
//获取按订单号查询的返回结果
- (void)rechargeRecordByOrderIdJsonResponseCallBack:(NSDictionary *)paramDic
{
    if (paramDic == nil)
    {
        NSLog(@"按订单号查询没有返回结果");
    }
//    [mbProgressHUD hide:YES];
    
    [_sortedArrForArrays removeAllObjects];
    [_sectionHeadsKeys removeAllObjects];
    
    if ([[paramDic objectForKey:@"error"] intValue] == 0)
    {
        NSDictionary *dataDic = [paramDic objectForKey:@"data"];
        if ([dataDic count] > 0) {
            [_sectionHeadsKeys addObject:[[dataDic objectForKey:@"datetime"] substringToIndex:10]];
            NSArray *tempArray = [[NSArray alloc] initWithObjects:dataDic, nil];
            [_sortedArrForArrays addObject:tempArray];
            [tempArray release];
            
            [noRecordView setHidden:YES];
        }
        else
        {
            [noRecordView setHidden:NO];
        }
    }
    else
    {
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ADDRESS message:[paramDic objectForKey:@"msg"]];
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    
    [_header endRefreshing];
    [_footer setCanLoadMore:NO];
    [[_rechargeRecordTableView tableFooterView] setHidden:YES];
    [_rechargeRecordTableView reloadData];
    
}


- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError{
    // 让刷新控件恢复默认的状态
    [_header endRefreshing];
    [[_footer infoLabel] setText:@"上拉即可刷新"];
    [[_footer activityIndicator] stopAnimating];
    mbProgressHUD.labelText = @"通信失败，稍后再试";
    [mbProgressHUD show:YES];
    [mbProgressHUD hide:YES afterDelay:2];
}

- (void)responseDidFailWithErrorCallBack
{
    // 让刷新控件恢复默认的状态
    [_header endRefreshing];
    [[_footer infoLabel] setText:@"上拉即可刷新"];
    [[_footer activityIndicator] stopAnimating];
    mbProgressHUD.labelText = @"通信失败，稍后再试";
    [mbProgressHUD show:YES];
    [mbProgressHUD hide:YES afterDelay:2];
}
//--------------------------------------请求查询数据的回调----------------------------------

-(void)showRechargeRecordViewByRight{
    
    [super showViewByRight];
}

-(void)backButtonPressed
{
    //currentDisplayedView == 1表示是数据列表页面，currentDisplayedView ==0表示是数据查询页面
    if (currentDisplayedView == 1) {
        currentDisplayedView = 0;
        
        _currPage = 1;
        [_rechargeRecordTableView setContentOffset:CGPointMake(0, 0)];
        [self showRechargeRecordQueryViewFromTop];
    }
    else if (currentDisplayedView == 0) {
        [self hiddenRechargeRecordViewInRight];
        
        PPCenterView *ppCenterView = [[PPCenterView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppCenterView atIndex:1002];
        [ppCenterView showCenterViewByLeft];
        [ppCenterView release];
    }
    
}

-(void)hiddenRechargeRecordViewInRight
{
    [super hiddenViewInRight];
}

-(void)didHiddenView

{   [mbProgressHUD removeFromSuperview];
    [super didHiddenView];
}

-(void)didShowView{
    
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [queriedOrderIdTextField resignFirstResponder];
}

- (void)dealloc{
    NSLog(@"rechargeRecordView----------dealloc");
    [_sortedArrForArrays release];
    _sortedArrForArrays = nil;
    [_sectionHeadsKeys release];
    _sectionHeadsKeys = nil;
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

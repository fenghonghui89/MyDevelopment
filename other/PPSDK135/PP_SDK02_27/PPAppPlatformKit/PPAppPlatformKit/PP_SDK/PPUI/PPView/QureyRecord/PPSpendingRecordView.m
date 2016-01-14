//
//  PPSpendingRecordView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-16.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPSpendingRecordView.h"
#import "PPUIKit.h"
#import "PPCommon.h"


@implementation PPSpendingRecordView


- (id)init
{
    self = [super init];
    if (self) {
        [_bgImageView setClipsToBounds:YES];
        [self.backButton setHidden:NO];
        [_titleLabel setText:@"消费记录"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleRechangeRecord"]];
        currentDisplayedView=0;
        
        _currPage = 1;
        
        _sortedArrForArrays = [[NSMutableArray alloc] init];
        _sectionHeadsKeys = [[NSMutableArray alloc] init];      //initialize a array to hold tableview‘s header keys
        _currentQueryedTime = PPOrderDataToday;//默认查询今天的记录
        _currentQureyedStatus = PPOrderStatusSucceed;//默认查询成功状态的记录
  
        spendingRecordQueryView = [[UIView alloc] init];
        [spendingRecordQueryView setBackgroundColor:[UIColor clearColor]];
        [_bgImageView insertSubview:spendingRecordQueryView belowSubview:_topView];
        [spendingRecordQueryView release];
        
        
        querySegmentedView = [[UIView alloc] init];
        [[querySegmentedView layer] setMasksToBounds:YES];
        [[querySegmentedView layer] setCornerRadius:3.0f];
        [[querySegmentedView layer] setBorderWidth:1.0f];
        [[querySegmentedView layer] setBorderColor:[[PPCommon getColor:@"2181f7"] CGColor]];
        [spendingRecordQueryView addSubview:querySegmentedView];
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
        
        spendingStatusImageView = [[UIImageView alloc] init];
        [spendingStatusImageView setUserInteractionEnabled:YES];
        [spendingRecordQueryView addSubview:spendingStatusImageView];
        [spendingStatusImageView release];
        
        spendingStatusTitleLabel = [[UILabel alloc] init];
        [spendingStatusTitleLabel setBackgroundColor:[UIColor clearColor]];
        [spendingStatusTitleLabel setText:@"到账状态"];
        [spendingStatusTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [spendingStatusTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [spendingStatusImageView addSubview:spendingStatusTitleLabel];
        [spendingStatusTitleLabel release];
        
        
        spendingStatusValueLabel = [[UILabel alloc] init];
        [spendingStatusValueLabel setBackgroundColor:[UIColor clearColor]];
        [spendingStatusValueLabel setText:@"已到账"];
        [spendingStatusValueLabel setFont:[UIFont systemFontOfSize:15]];
        [spendingStatusValueLabel setTextAlignment:NSTextAlignmentLeft];
        [spendingStatusImageView addSubview:spendingStatusValueLabel];
        [spendingStatusValueLabel release];
        
        spendingStatusListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [spendingStatusListButton addTarget:self action:@selector(spendingStatusListButtonPressedDown) forControlEvents:UIControlEventTouchUpInside];
        [spendingStatusImageView addSubview:spendingStatusListButton];
        
        spendingStatusListView =[[PPDropDownView alloc] init];
        spendingStatusListView.selectedIndex = _currentQureyedStatus;
//        [spendingStatusListView setBackgroundColor:[UIColor redColor]];
        [spendingStatusListView setDelegate:self];
        [spendingRecordQueryView addSubview:spendingStatusListView];
        [spendingStatusListView release];
        
        [spendingStatusListView addItemWithButtonTitle:@"未到账" itemFrame:CGRectMake(0, 0, _bgImageView.frame.size.width, 44)];
        [spendingStatusListView addItemWithButtonTitle:@"已到账" itemFrame:CGRectMake(0, 44, _bgImageView.frame.size.width, 44)];
        [spendingStatusListView addItemWithButtonTitle:@"已取消" itemFrame:CGRectMake(0, 44 * 2, _bgImageView.frame.size.width, 44)];
        [spendingStatusListView addItemWithButtonTitle:@"全部状态" itemFrame:CGRectMake(0, 44 * 3, _bgImageView.frame.size.width, 44)];
        
        spendingTimeListView =[[PPDropDownView alloc] init];
        spendingTimeListView.selectedIndex = _currentQueryedTime - 1;
        [spendingTimeListView setBackgroundColor:[UIColor redColor]];
        [spendingTimeListView setDelegate:self];
        [spendingRecordQueryView addSubview:spendingTimeListView];
        [spendingTimeListView release];
        
        [spendingTimeListView addItemWithButtonTitle:@"今天内" itemFrame:CGRectMake(0, 0, _bgImageView.frame.size.width, 44)];
        [spendingTimeListView addItemWithButtonTitle:@"本月内" itemFrame:CGRectMake(0, 44, _bgImageView.frame.size.width, 44)];
        [spendingTimeListView addItemWithButtonTitle:@"上一个月" itemFrame:CGRectMake(0, 44 * 2, _bgImageView.frame.size.width, 44)];
        [spendingTimeListView addItemWithButtonTitle:@"上两个月" itemFrame:CGRectMake(0, 44 * 3, _bgImageView.frame.size.width, 44)];
        
        
        
        spendingTimeImageView = [[UIImageView alloc] init];
        [spendingTimeImageView setUserInteractionEnabled:YES];
        [spendingRecordQueryView addSubview:spendingTimeImageView];
        [spendingTimeImageView release];
        
        spendingTimeTitleLabel = [[UILabel alloc] init];
        [spendingTimeTitleLabel setBackgroundColor:[UIColor clearColor]];
        [spendingTimeTitleLabel setText:@"消费时间"];
        [spendingTimeTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [spendingTimeTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [spendingTimeImageView addSubview:spendingTimeTitleLabel];
        [spendingTimeTitleLabel release];
        
        spendingTimeValueLabel = [[UILabel alloc] init];
        [spendingTimeValueLabel setBackgroundColor:[UIColor clearColor]];
        [spendingTimeValueLabel setText:@"今天内"];
        [spendingTimeValueLabel setFont:[UIFont systemFontOfSize:15]];
        [spendingTimeValueLabel setTextAlignment:NSTextAlignmentLeft];
        [spendingTimeImageView addSubview:spendingTimeValueLabel];
        [spendingTimeValueLabel release];
        
        spendingTimeListButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [spendingTimeListButton addTarget:self action:@selector(spendingTimeListButtonPressedDown) forControlEvents:UIControlEventTouchUpInside];
        [spendingTimeImageView addSubview:spendingTimeListButton];
        
        queryByCombinedConditionsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [queryByCombinedConditionsButton setTitle:@"按组合条件查询" forState:UIControlStateNormal];
        [queryByCombinedConditionsButton addTarget:self action:@selector(queryByCombinedConditionsButtonPressedDown) forControlEvents:UIControlEventTouchUpInside];
        [queryByCombinedConditionsButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [queryByCombinedConditionsButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [spendingRecordQueryView addSubview:queryByCombinedConditionsButton];
        
        queriedOrderIdImageView = [[UIImageView alloc] init];
        [queriedOrderIdImageView setUserInteractionEnabled:YES];
        [spendingRecordQueryView addSubview:queriedOrderIdImageView];
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
        [spendingRecordQueryView addSubview:queryByOrderIdButton];
        
        spendingRecordDataView = [[UIView alloc] init];
        [spendingRecordDataView setBackgroundColor:[UIColor clearColor]];
        [_bgImageView insertSubview:spendingRecordDataView belowSubview:_topView];
        [spendingRecordDataView release];
    
        
        noRecordView = [[UIImageView alloc] init];
        [spendingRecordDataView addSubview:noRecordView];
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
        
        _spendingRecordTableView=[[UITableView alloc] init];
        [_spendingRecordTableView setDelegate:self];
        [_spendingRecordTableView setDataSource:self];
        [_spendingRecordTableView setBackgroundColor:[UIColor clearColor]];
        [spendingRecordDataView addSubview:_spendingRecordTableView];
        [_spendingRecordTableView release];

        timeLabel = [self initspendingRecordHeaderLabel:timeLabel withText:@"消费\n时间" numberOfLines:2];
        [timeLabel setTextAlignment:NSTextAlignmentLeft];
        [spendingRecordDataView addSubview:timeLabel];
//        [timeLabel release];
        
        orderIdLabel = [self initspendingRecordHeaderLabel:timeLabel withText:@"订单\n号码" numberOfLines:2];
        [spendingRecordDataView addSubview:orderIdLabel];
//        [orderIdLabel release];
        
        spendingAmountLabel = [self initspendingRecordHeaderLabel:timeLabel withText:@"PP币\n数量" numberOfLines:3];
        [spendingRecordDataView addSubview:spendingAmountLabel];
//        [spendingAmountLabel release];
        
        gameNameLabel = [self initspendingRecordHeaderLabel:timeLabel withText:@"游戏\n名称" numberOfLines:2];
        [spendingRecordDataView addSubview:gameNameLabel];
//        [gameNameLabel release];
        
        orderStatusLabel = [self initspendingRecordHeaderLabel:timeLabel withText:@"消费\n状态" numberOfLines:2];
        [spendingRecordDataView addSubview:orderStatusLabel];
//        [orderStatusLabel release];
        

        
        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = self;
        [_header setScrollView:_spendingRecordTableView];
        [_header setBackgroundColor:[UIColor clearColor]];
        [_header release];
        
        // 上拉加载更多
        _footer = [[PPRefreshFootMoreView alloc] init];
        [_spendingRecordTableView setTableFooterView:_footer];
        [_footer setBackgroundColor:[UIColor clearColor]];
        [_footer release];
        
        [noRecordView setImage:[PPUIKit setLocaImage:@"PPNoRecord"]];
        [spendingStatusImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [spendingTimeImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [queriedOrderIdImageView setImage:[[PPUIKit setLocaImage:@"PPInputBoxMiddle"]stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        
        [spendingStatusListButton setImage:[PPUIKit setLocaImage:@"PPArrowRight"] forState:UIControlStateNormal];
        [spendingTimeListButton setImage:[PPUIKit setLocaImage:@"PPArrowRight"] forState:UIControlStateNormal];
        
        //查询按钮
        [queryByCombinedConditionsButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"]stretchableImageWithLeftCapWidth:10 topCapHeight:10]  forState:UIControlStateNormal];
        [queryByOrderIdButton setBackgroundImage:[[PPUIKit setLocaImage:@"bgButton"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        
        
        mbProgressHUD = [[PPMBProgressHUD alloc] initWithView:_spendingRecordTableView];
        [_spendingRecordTableView addSubview:mbProgressHUD];
        [mbProgressHUD release];
        
    }
    return self;
}


//竖
-(void)initVerticalFrame{
    
    [super initVerticalFrame];
    
    [querySegmentedView setFrame:CGRectMake((_bgImageView.frame.size.width - 300) / 2, 15, 300, 29)];
    if (currentDisplayedView == 0)
    {
        for (UIButton *view in [querySegmentedView subviews]) {
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
            
            //        rect.size.height = height;
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


- (void)reloadViewsForHeight:(float)height
{
    //充值记录查询页面的上半部分view
    [spendingRecordQueryView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    
    [spendingStatusImageView setFrame:CGRectMake(0, querySegmentedView.frame.origin.y + querySegmentedView.frame.size.height +20, _bgImageView.frame.size.width, height)];
    
    if ([spendingStatusListView isOpen])
    {
        [spendingStatusListView setFrame:CGRectMake(0, spendingStatusImageView.frame.origin.y + spendingStatusImageView.frame.size.height, spendingStatusImageView.frame.size.width, height * 4)];
        
        int i = 0;
        int height = 0;
        if ([spendingStatusListView.items count] > 0) {
            height = spendingStatusListView.frame.size.height / [spendingStatusListView.items count];
        }
        for (PPListItemView *itemView in [spendingStatusListView items]) {
            CGRect rect = [itemView frame];
            rect.size.width = spendingStatusListView.frame.size.width;
            rect.size.height = height;
            
            rect.origin.y = height * i;
            [itemView setFrame:rect];
            i++;
        }
    }
    else
    {
        [spendingStatusListView setFrame:CGRectMake(0, spendingStatusImageView.frame.origin.y + spendingStatusImageView.frame.size.height, spendingStatusImageView.frame.size.width, 0)];
    }
    
    [spendingTimeImageView setFrame:CGRectMake(0, spendingStatusListView.frame.origin.y + spendingStatusListView.frame.size.height, _bgImageView.frame.size.width, height)];

    if ([spendingTimeListView isOpen]) {
        [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y + spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, height * 4)];
        
        int i = 0;
        int height = 0;
        if ([spendingTimeListView.items count] > 0) {
            height = spendingTimeListView.frame.size.height / [spendingTimeListView.items count];
        }
        for (PPListItemView *itemView in [spendingTimeListView items]) {
            CGRect rect = [itemView frame];
            rect.size.width = spendingTimeListView.frame.size.width;
            rect.size.height = height;
            
            rect.origin.y = height * i;
            [itemView setFrame:rect];
            i++;
        }
    }
    else{
        [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y + spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, 0)];
    }
    //查询按钮
    [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width - 300) / 2, spendingTimeListView.frame.origin.y+spendingTimeListView.frame.size.height + 20, 300, height)];
    
    [queriedOrderIdImageView setFrame:CGRectMake(0, querySegmentedView.frame.origin.y + querySegmentedView.frame.size.height + 20, _bgImageView.frame.size.width, height)];
    
    [spendingStatusTitleLabel setFrame:CGRectMake(16, 0, 61, height)];
    [spendingTimeTitleLabel setFrame:CGRectMake(16, 0, 61, height)];
    [queriedOrderIdTitleLabel setFrame:CGRectMake(16, 0, 61, height)];
    
    [spendingStatusValueLabel setFrame:CGRectMake(spendingStatusTitleLabel.frame.origin.x + spendingStatusTitleLabel.frame.size.width+16,0 , 61, height)];
    [spendingTimeValueLabel setFrame:CGRectMake(spendingTimeTitleLabel.frame.origin.x + spendingTimeTitleLabel.frame.size.width+16,0, 61, height)];
    
    [queriedOrderIdTextField setFrame:CGRectMake(queriedOrderIdTitleLabel.frame.origin.x + queriedOrderIdTitleLabel.frame.size.width + 16,0 , queriedOrderIdImageView.frame.size.width - 77 - 16, height)];
    
    //界面的下拉按钮
    [spendingStatusListButton setFrame:CGRectMake(spendingStatusImageView.frame.size.width - 16 - 44, 0, 44, height)];
    [spendingTimeListButton setFrame:CGRectMake(spendingTimeImageView.frame.size.width -16 - 44, 0, 44, height)];
    
    //界面的下拉按钮
    [spendingStatusListButton setFrame:CGRectMake(16, 0, spendingStatusImageView.frame.size.width - 16, height)];
    [spendingStatusListButton setImageEdgeInsets:UIEdgeInsetsMake(0, spendingStatusListButton.frame.size.width - 25, 0, 16)];
    [spendingTimeListButton setFrame:CGRectMake(16, 0, spendingTimeImageView.frame.size.width - 16, height)];
    [spendingTimeListButton setImageEdgeInsets:UIEdgeInsetsMake(0, spendingTimeListButton.frame.size.width - 25, 0, 16)];
    
    
    [queryByOrderIdButton setFrame:CGRectMake((_bgImageView.frame.size.width-300) / 2, queriedOrderIdImageView.frame.origin.y+queriedOrderIdImageView.frame.size.height + 20, 300, height)];
    
    
    
    //显示在tableview上方的view
    [spendingRecordDataView setFrame:CGRectMake(0, _bgImageView.frame.size.height, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    
    if(_bgImageView.frame.size.width == 320)
    {
        //spendingRecordDataView的标签view，显示表头上文字的label
        [timeLabel setFrame:CGRectMake(16, 0, 27, 62)];
        [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x + timeLabel.frame.size.width, 0, 95, 62)];
        [spendingAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x + orderIdLabel.frame.size.width, 0, 50, 62)];
        
        [gameNameLabel setFrame:CGRectMake(spendingAmountLabel.frame.origin.x + spendingAmountLabel.frame.size.width, 0, 100, 62)];
        [orderStatusLabel setFrame:CGRectMake(gameNameLabel.frame.origin.x + gameNameLabel.frame.size.width, 0, 27, 62)];
    }
    else if(_bgImageView.frame.size.width > 320)
    {
        int widthIncrement = (_bgImageView.frame.size.width - 320) / 4;
        //spendingRecordDataView的标签view，显示表头上文字的label
        [timeLabel setFrame:CGRectMake(16, 0, 27 + widthIncrement, 62)];
        [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x + timeLabel.frame.size.width, 0, 95 + widthIncrement, 62)];
        [spendingAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x + orderIdLabel.frame.size.width, 0, 50 + widthIncrement, 62)];
        
        [gameNameLabel setFrame:CGRectMake(spendingAmountLabel.frame.origin.x + spendingAmountLabel.frame.size.width, 0, 100 + widthIncrement, 62)];
        [orderStatusLabel setFrame:CGRectMake(gameNameLabel.frame.origin.x + gameNameLabel.frame.size.width, 0, 27, 62)];
    }
    //显示数据用的tableview
    [_spendingRecordTableView setFrame:CGRectMake(0, 62, spendingRecordDataView.frame.size.width,spendingRecordDataView.frame.size.height - 62)];
    [noRecordView setFrame:CGRectMake((_bgImageView.frame.size.width - 50) / 2, (_bgImageView.frame.size.height - 160) / 2, 50, 50)];
}

- (void) reloadDataView
{
    //显示在tableview上方的view
    [spendingRecordDataView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    
    if(_bgImageView.frame.size.width == 320)
    {
        //spendingRecordDataView的标签view，显示表头上文字的label
        [timeLabel setFrame:CGRectMake(16, 0, 27, 62)];
        [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x + timeLabel.frame.size.width, 0, 95, 62)];
        [spendingAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x + orderIdLabel.frame.size.width, 0, 50, 62)];
        
        [gameNameLabel setFrame:CGRectMake(spendingAmountLabel.frame.origin.x + spendingAmountLabel.frame.size.width, 0, 100, 62)];
        [orderStatusLabel setFrame:CGRectMake(gameNameLabel.frame.origin.x + gameNameLabel.frame.size.width, 0, 27, 62)];
    }
    else if(_bgImageView.frame.size.width > 320)
    {
        int widthIncrement = (_bgImageView.frame.size.width - 320) / 4;
        //spendingRecordDataView的标签view，显示表头上文字的label
        [timeLabel setFrame:CGRectMake(16, 0, 27 + widthIncrement, 62)];
        [orderIdLabel setFrame:CGRectMake(timeLabel.frame.origin.x + timeLabel.frame.size.width, 0, 95 + widthIncrement, 62)];
        [spendingAmountLabel setFrame:CGRectMake(orderIdLabel.frame.origin.x + orderIdLabel.frame.size.width, 0, 50 + widthIncrement, 62)];
        
        [gameNameLabel setFrame:CGRectMake(spendingAmountLabel.frame.origin.x + spendingAmountLabel.frame.size.width, 0, 100 + widthIncrement, 62)];
        [orderStatusLabel setFrame:CGRectMake(gameNameLabel.frame.origin.x + gameNameLabel.frame.size.width, 0, 27, 62)];
    }
    //显示数据用的tableview
    [_spendingRecordTableView setFrame:CGRectMake(0, 62, spendingRecordDataView.frame.size.width,spendingRecordDataView.frame.size.height - 62)];
    [noRecordView setFrame:CGRectMake((_bgImageView.frame.size.width - 50) / 2, (_bgImageView.frame.size.height - 160) / 2, 50, 50)];
}


- (UILabel *)initspendingRecordHeaderLabel:(UILabel *)label withText:(NSString *)text numberOfLines:(int)number{
    label = [[UILabel alloc]init];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:10.0f]];
    [label setTextColor:COLOR(2, 2, 2, 1)];
    [label setText:text];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setNumberOfLines:number];
    //    [label setLineBreakMode: NSLineBreakModeWordWrap];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    return [label autorelease];

}

- (void)segmentedButtonClicked:(UIButton *)button{
    [spendingStatusListView closeView];
    [spendingTimeListView closeView];
    
    [self reloadViewsForHeight:spendingStatusImageView.frame.size.height];
    [[spendingStatusListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
    [[spendingTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
    
    if ([button tag] == 0 ) {
        if (PP_ISNSLOG) {
            
        }
        
        [queriedOrderIdImageView setHidden:YES];
        [queryByOrderIdButton setHidden:YES];
        
        [spendingStatusImageView setHidden:NO];
        [spendingTimeImageView setHidden:NO];
        [queryByCombinedConditionsButton setHidden:NO];
        [queriedOrderIdTextField resignFirstResponder];
	}
	else if([button tag] == 1) {
        if (PP_ISNSLOG) {
            
        }
        [queriedOrderIdImageView setHidden:NO];
        [queryByOrderIdButton setHidden:NO];
        
        [spendingStatusImageView setHidden:YES];
        [spendingTimeImageView setHidden:YES];
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
//-------------------------tableView的处理---------------------------------------
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
    return  [_sortedArrForArrays count];
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPSpendingRecordTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[PPSpendingRecordTableViewCell alloc] init];
        
        int sectionNumber = [indexPath section];
        int rowNumber = [indexPath row];
        
        if ([_sortedArrForArrays count] > sectionNumber) {
            NSArray *arr = [_sortedArrForArrays objectAtIndex:sectionNumber];
            if ([arr count] > rowNumber) {
                
                NSDictionary *tempDic = [arr objectAtIndex:rowNumber];
                
                
                //到账状态
                int status = [[tempDic objectForKey:@"status"] intValue];
                if (status == 1)
                {
                    [[cell orderStatusLabel] setText:@"已到账"];
                }
                else
                {
                    [[cell orderStatusLabel] setText:@"未到账"];
                }
                //到账时间
                NSString *timeString = [[[tempDic objectForKey:@"datetime"] substringFromIndex:11] stringByReplacingOccurrencesOfString:@"-" withString:@":"];
                [[cell timeLabel] setText:timeString];
                //消费单号
                [[cell orderIdLabel] setText:[NSString stringWithFormat:@"%@", [tempDic objectForKey:@"exchange_no"]]];
                //到账金额
                NSMutableString *amountString =[NSMutableString stringWithString:[tempDic objectForKey:@"amount"]];
                //标注是否为测试币
                if ([[tempDic objectForKey:@"isTest"] intValue] != 1)
                {
                    [amountString appendString:@"[测试币]"];
                }
                [[cell spendingAmountLabel] setText:amountString];
                
                //游戏名称
                [[cell gameNameLabel] setText:[tempDic objectForKey:@"appname"]];
            }
            else {
                NSLog(@"arr out of range");
            }
        }
        else {
            NSLog(@"sortedArrForArrays out of range");
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return [cell autorelease];

}


-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    if (_sectionHeadsKeys )
    {
        if ([_sectionHeadsKeys count] >= section)
        {
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

-(void)dropDownView:(PPDropDownView *)view selectedIndex:(NSInteger)index withInfo:(NSDictionary *)info{
    NSLog(@"选择了一项");
    [view.selectedItem cancelSelectedState];
    view.selectedIndex = index;
    view.selectedItem = [view.items objectAtIndex:index];
    
    if (view == spendingStatusListView) {
        [spendingStatusValueLabel setText:[info objectForKey:@"itemText"]];
        _currentQureyedStatus = index;
        
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [view closeView];
        //    [self reloadViewsForHeight:spendingStatusImageView.frame.size.height];
        
        [spendingStatusListView setFrame:CGRectMake(0, spendingStatusImageView.frame.origin.y+spendingStatusImageView.frame.size.height, spendingStatusImageView.frame.size.width, 0)];
        
        [spendingTimeImageView setFrame:CGRectMake(0, spendingStatusListView.frame.origin.y+spendingStatusListView.frame.size.height, _bgImageView.frame.size.width, spendingStatusImageView.frame.size.height)];
        
        
        [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y+spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, spendingTimeListView.frame.size.height)];
        
        //查询按钮
        [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width-300)/2, spendingTimeListView.frame.origin.y+spendingTimeListView.frame.size.height+20, 300, spendingStatusImageView.frame.size.height)];
        [[spendingStatusListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
        
        [UIView commitAnimations];
        
    }
    else{
        [spendingTimeValueLabel setText:[info objectForKey:@"itemText"]];
        _currentQueryedTime = index+1;
        
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [view closeView];
        //    [self reloadViewsForHeight:spendingStatusImageView.frame.size.height];
        
        [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y+spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, spendingTimeListView.frame.size.height)];
        
        //查询按钮
        [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width-300)/2, spendingTimeListView.frame.origin.y+spendingTimeListView.frame.size.height+20, 300, spendingStatusImageView.frame.size.height)];
        [[spendingTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
        
        [UIView commitAnimations];
    }
}
//选择时间的列表
- (void)spendingTimeListButtonPressedDown{

    float itemViewsHeight = spendingStatusImageView.frame.size.height;
    
    
    if (spendingTimeListView.isOpen) {
        
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y+spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, 0)];
        
        //查询按钮
        [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width-300)/2, spendingTimeListView.frame.origin.y+spendingTimeListView.frame.size.height+20, 300, itemViewsHeight)];
        [[spendingTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
        [spendingTimeListView closeView];
        [UIView commitAnimations];

    }
    else
    {
        int i = 0;

        for (PPListItemView *itemView in [spendingTimeListView items]) {
            CGRect rect = [itemView frame];
            rect.size.width = spendingTimeListView.frame.size.width;
            rect.size.height = itemViewsHeight;
            
            rect.origin.y = itemViewsHeight * i;
            [itemView setFrame:rect];
            i++;
        }
        
        if ([spendingStatusListView isOpen])
        {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            [spendingStatusListView setFrame:CGRectMake(0, spendingStatusImageView.frame.origin.y+spendingStatusImageView.frame.size.height, spendingStatusImageView.frame.size.width, 0)];
            [spendingTimeImageView setFrame:CGRectMake(0, spendingStatusListView.frame.origin.y+spendingStatusListView.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight)];
            [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y+spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, itemViewsHeight*4)];
            //查询按钮
            [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width-300)/2, spendingTimeListView.frame.origin.y+spendingTimeListView.frame.size.height+20, 300, itemViewsHeight)];
            [[spendingTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(1.57)];
            [spendingTimeListView openView];
            
            [[spendingStatusListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
            [spendingStatusListView closeView];
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y+spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, itemViewsHeight*4)];
            //查询按钮
            [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width-300)/2, spendingTimeListView.frame.origin.y+spendingTimeListView.frame.size.height+20, 300, itemViewsHeight)];
            [[spendingTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(1.57)];
            [spendingTimeListView openView];
            [UIView commitAnimations];
        }
        [spendingTimeListView selectItem:spendingTimeListView.selectedIndex];
        
        
    }
   
}

- (void)spendingStatusListButtonPressedDown{
    
    float itemViewsHeight = spendingStatusImageView.frame.size.height;

    if (spendingStatusListView.isOpen) {
        [UIView beginAnimations:@"HideUpDropDownView" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2f];
        [spendingStatusListView setFrame:CGRectMake(0, spendingStatusImageView.frame.origin.y+spendingStatusImageView.frame.size.height, spendingStatusImageView.frame.size.width, 0)];
        
        [spendingTimeImageView setFrame:CGRectMake(0, spendingStatusListView.frame.origin.y+spendingStatusListView.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight)];
        
        
        [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y+spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, spendingTimeListView.frame.size.height)];
        
        //查询按钮
        [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width-300)/2, spendingTimeListView.frame.origin.y+spendingTimeListView.frame.size.height+20, 300, itemViewsHeight)];
        [spendingStatusListView closeView];
        [[spendingStatusListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
        [UIView commitAnimations];
        
        [spendingStatusListView closeView];
        
    }
    else
    {
        int i = 0;
        
        for (PPListItemView *itemView in [spendingStatusListView items]) {
            CGRect rect = [itemView frame];
            rect.size.width = spendingStatusListView.frame.size.width;
            rect.size.height = itemViewsHeight;
            
            rect.origin.y = itemViewsHeight * i;
            [itemView setFrame:rect];
            i++;
        }
        
        if ([spendingTimeListView isOpen])
        {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            
            [spendingStatusListView setFrame:CGRectMake(0, spendingStatusImageView.frame.origin.y+spendingStatusImageView.frame.size.height, spendingStatusListView.frame.size.width, itemViewsHeight*4)];
            [spendingTimeImageView setFrame:CGRectMake(0, spendingStatusListView.frame.origin.y+spendingStatusListView.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight)];
            [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y+spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, 0)];
            
            //查询按钮
            [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width-300)/2, spendingTimeListView.frame.origin.y+spendingTimeListView.frame.size.height+20, 300, itemViewsHeight)];
            [spendingStatusListView openView];
            [[spendingStatusListButton imageView] setTransform : CGAffineTransformMakeRotation(1.57)];
            [spendingTimeListView closeView];
            [[spendingTimeListButton imageView] setTransform : CGAffineTransformMakeRotation(0)];
            
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:@"HideUpDropDownView" context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.2f];
            
            [spendingStatusListView setFrame:CGRectMake(0, spendingStatusImageView.frame.origin.y+spendingStatusImageView.frame.size.height, spendingStatusListView.frame.size.width, itemViewsHeight*4)];
            [spendingTimeImageView setFrame:CGRectMake(0, spendingStatusListView.frame.origin.y+spendingStatusListView.frame.size.height, _bgImageView.frame.size.width, itemViewsHeight)];
            
            
            [spendingTimeListView setFrame:CGRectMake(0, spendingTimeImageView.frame.origin.y+spendingTimeImageView.frame.size.height, spendingTimeImageView.frame.size.width, spendingTimeListView.frame.size.height)];
            
            //查询按钮
            [queryByCombinedConditionsButton setFrame:CGRectMake(( _bgImageView.frame.size.width-300)/2, spendingTimeListView.frame.origin.y+spendingTimeListView.frame.size.height+20, 300, itemViewsHeight)];
            [spendingStatusListView openView];
            [[spendingStatusListButton imageView] setTransform : CGAffineTransformMakeRotation(1.57)];
            
            [UIView commitAnimations];
        }
        [spendingStatusListView selectItem:spendingStatusListView.selectedIndex];
    }
}

- (void)queryByCombinedConditionsButtonPressedDown
{
    [queriedOrderIdTextField resignFirstResponder];
    
    [[_spendingRecordTableView tableFooterView] setHidden:YES];
//    mbProgressHUD.labelText = @"加载中...";
//    [mbProgressHUD show:YES];
    currentDisplayedView = 1;
    currentQueriedCondition = 1;
    _currPage = 1;
    [self hideSpendingRecordQueryViewInTop];
    [_header setState:RefreshStateRefreshing];
    
//    PPWebViewData *pp = [[PPWebViewData alloc] init];
//    [pp setDelegate:self];
//    [pp getConsumptionRecordByTime:_currentQureyedStatus Data:_currentQueryedTime Page:_currPage];
//    [pp release];
}
- (void)queryByOrderIdButtonPressedDown
{
    NSString *orderId = [queriedOrderIdTextField text];
    [queriedOrderIdTextField resignFirstResponder];
    [[_spendingRecordTableView tableFooterView] setHidden:YES];
    
    [_sortedArrForArrays removeAllObjects];
    [_sectionHeadsKeys removeAllObjects];
    
//    if ([orderId length] != 16)
//    {
//        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"温馨提示" message:@"订单号长度有误！请输入16位纯数字订单号"];
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
//        mbProgressHUD.labelText = @"加载中...";
//        [mbProgressHUD show:YES];
        currentDisplayedView = 1;
        currentQueriedCondition = 2;
        [self hideSpendingRecordQueryViewInTop];
        [_header setState:RefreshStateRefreshing];
        
//        PPWebViewData *pp = [[PPWebViewData alloc] init];
//        [pp setDelegate:self];
//        [pp getConsumptionRecordByOrderId:[queriedOrderIdTextField text]];
//        [pp release];
    }
    
    
}

//按时间查询返回的消费记录
- (void)consumptionRecordByTimeJsonResponseCallBack:(NSDictionary *)paramDic
{
    
    if (PP_ISNSLOG) {
        NSLog(@"-----paramDic-----%@",paramDic);
    }
    
//    [mbProgressHUD hide:YES];
    [_header endRefreshing];
    
    if ([[paramDic objectForKey:@"error"] intValue] == 0)
    {
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
        [tempArray release];
        if ([[paramDic objectForKey:@"data"] count] == 0) {
            
            [_footer setCanLoadMore:NO];
            [[_spendingRecordTableView tableFooterView] setHidden:YES];
            if (_currPage == 1)
            {
                [noRecordView setHidden:NO];
            }
            else
            {
                [noRecordView setHidden:YES];
            }
        }
        
        else if ([[paramDic objectForKey:@"data"] count] < 20) {
            [_footer setCanLoadMore:NO];
            [noRecordView setHidden:YES];
            [[_spendingRecordTableView tableFooterView] setHidden:YES];
        }else
        {
            [_footer setCanLoadMore:YES];
            [noRecordView setHidden:YES];
            [[_spendingRecordTableView tableFooterView] setHidden:NO];
        }
        [_footer setIsDragging:YES];
        [_spendingRecordTableView reloadData];
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
//按orderid查询返回的消费记录
- (void)consumptionRecordByOrderIdJsonResponseCallBack:(NSDictionary *)paramDic
{
    
//    [mbProgressHUD hide:YES];
    
    [_sortedArrForArrays removeAllObjects];
    [_sectionHeadsKeys removeAllObjects];
    
    if ([[paramDic objectForKey:@"error"] intValue] == 0) {
        
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
    [[_spendingRecordTableView tableFooterView] setHidden:YES];
    [_spendingRecordTableView reloadData];

}

- (void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError{
    // 让刷新控件恢复默认的状态
//    [mbProgressHUD hide:YES];
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


//--------------------------------------刷新数据 并加载到tableview中------------------------
-(void)loadData:(int)page
{
    PPWebViewData *pp = [[PPWebViewData alloc] init];
    [pp setDelegate:self];
    if (currentQueriedCondition == 1)
    {
        [pp getConsumptionRecordByTime:_currentQureyedStatus Data:_currentQueryedTime Page:page];
    }
    else if(currentQueriedCondition == 2)
    {
        [pp getConsumptionRecordByOrderId:[queriedOrderIdTextField text]];
    }
    
    [pp release];
}


#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_header == refreshView)
    {
        _currPage = 1;
        [self loadData:_currPage];
    }
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

//---------------------------查询页面和数据显示页面的切换---------------------------

- (void)showSpendingRecordQueryViewFromTop{
    
    [self onDeviceOrientationChange:NO];
    [UIView beginAnimations:@"showView2" context:nil];
    [spendingRecordQueryView setFrame:CGRectMake(0, -_bgImageView.frame.size.height+50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [spendingRecordDataView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [UIView setAnimationDuration:0.6];
    [spendingRecordQueryView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [spendingRecordDataView setFrame:CGRectMake(0, _bgImageView.frame.size.height, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)hideSpendingRecordQueryViewInTop{
    
    [noRecordView setHidden:YES];
    [_sortedArrForArrays removeAllObjects];
    [_sectionHeadsKeys removeAllObjects];
    [_spendingRecordTableView reloadData];
    
    [self onDeviceOrientationChange:NO];
    [UIView beginAnimations:@"hideView2" context:nil];
    [spendingRecordQueryView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [spendingRecordDataView setFrame:CGRectMake(0, _bgImageView.frame.size.height, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [UIView setAnimationDuration:0.6];
    [spendingRecordQueryView setFrame:CGRectMake(0, -_bgImageView.frame.size.height+50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [spendingRecordDataView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height-50)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}
//---------------------------查询页面和数据显示页面的切换---------------------------


-(void)showSpendingRecordViewByRight{
    [super showViewByRight];
}

-(void)backButtonPressed
{
    //currentDisplayedView == 1表示是数据列表页面，currentDisplayedView ==0表示是数据查询页面
    if (currentDisplayedView == 1)
    {
        currentDisplayedView = 0;
        _currPage = 1;
        [_spendingRecordTableView setContentOffset:CGPointMake(0, 0)];
        [self showSpendingRecordQueryViewFromTop];
    }
    else if (currentDisplayedView == 0)
    {
        [self hiddenSpendingRecordViewInRight];
        PPCenterView *ppCenterView = [[PPCenterView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppCenterView atIndex:1002];
        [ppCenterView showCenterViewByLeft];
        [ppCenterView release];
    }
    
}

-(void)hiddenSpendingRecordViewInRight
{
    [super hiddenViewInRight];
}

-(void)didHiddenView
{
    [mbProgressHUD removeFromSuperview];
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


- (void)dealloc
{
    NSLog(@"spendingRecordView----------dealloc");
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

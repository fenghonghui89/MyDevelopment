//
//  PPNoticeListView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-11-22.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPNoticeListView.h"
#import "PPAppPlatformKitConfig.h"
#import "PPCommon.h"
#import "PPNotice.h"
#import "PPNoticeManager.h"
#import "PPNoticeContentView.h"



static int headFixedHeight = 85;
static int headFixedY = 50;
static int footFixedHeight = 50;
static int footFixedY = 50;


static PPNoticeListView * ppNoticeListView;

@implementation PPNoticeListView


- (id)init
{
    self = [super init];
    if (self) {
        [_bgImageView setClipsToBounds:YES];
        _pageType = PageTypeOfEmail;
        headSegView_newY = 50;

        _editStatus = NO;
        
        _tableArray = [[NSMutableArray alloc] init];
        [_titleLabel setText:@"消息中心"];
        [self.verticalLineLeftView setHidden:NO];
        [self.backButton setHidden:NO];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleMessage"]];
        
        
        noRecordView = [[UIImageView alloc] init];
        [noRecordView setImage:[[PPUIKit setLocaImage:@"PPNoRecord"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [_bgImageView addSubview:noRecordView];
        [noRecordView setHidden:YES];
        
        UILabel *noRecordLabel = [[UILabel alloc] init];
        [noRecordLabel setFrame:CGRectMake(-30, 50, 110, 30)];
        [noRecordLabel setText:@"T_T 暂无记录"];
        [noRecordLabel setTextColor:[PPCommon getColor:@"cccccc"]];
        [noRecordLabel setBackgroundColor:[UIColor clearColor]];
        [noRecordLabel setTextAlignment:NSTextAlignmentCenter];
        [noRecordLabel setFont:[UIFont systemFontOfSize:14]];
        [noRecordView addSubview:noRecordLabel];
        [noRecordLabel release];
        [noRecordView release];

        _tableView = [[UITableView alloc] init];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setRowHeight:80];
//        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        [_tableView setShowsVerticalScrollIndicator:YES];
        [_tableView setCanCancelContentTouches:NO];
        _tableView.backgroundColor = [PPCommon getColor:@"f0eff3"];
        _tableView.contentInset = _tableView.scrollIndicatorInsets ;
        [_bgImageView addSubview:_tableView];
        [_bgImageView insertSubview:_tableView belowSubview:_topView];
        [_tableView release];
        
        _headSegView = [[UIView alloc] init];
        [_headSegView setBackgroundColor:[PPCommon getColor:@"F0EFF3"]];
        [_bgImageView insertSubview:_headSegView aboveSubview:_tableView];
        [_headSegView release];
        
        
        _sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, 35)];
        [_sectionView setBackgroundColor:[PPCommon getColor:@"FFFFFF"]];
        _sectionView.layer.borderColor = [PPCommon getColor:@"CCCCCC"].CGColor;
        [_sectionView.layer setBorderWidth:0.8];
        
        [_headSegView addSubview:_sectionView];
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_editStatus)
        {
            [_editButton setTitle:@"取消" forState:UIControlStateNormal];
        }
        else
        {
            [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        }

        [_editButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
        [_editButton addTarget:self action:@selector(editButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_editButton setFrame:CGRectMake(_sectionView.frame.size.width - 60, 0, 50 , _sectionView.frame.size.height)];
        [[_editButton titleLabel] setFont:[UIFont systemFontOfSize:13]];


        [_editButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_sectionView addSubview:_editButton];
        
        



        _selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
        [_selectAllButton setAlpha:0];

        [_selectAllButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
        [_selectAllButton addTarget:self action:@selector(selectAllButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [_selectAllButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_selectAllButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [[_selectAllButton titleLabel] setFont:[UIFont systemFontOfSize:13]];
        [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailUnchecked"] forState:UIControlStateNormal];
        [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailUnchecked"] forState:UIControlStateHighlighted];
        
        
        [_selectAllButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_sectionView addSubview:_selectAllButton];
        
        
        _segmentedControlButtonView = [[UIView alloc] init];
        [[_segmentedControlButtonView layer] setMasksToBounds:YES];
        [[_segmentedControlButtonView layer] setCornerRadius:3.0f];
        [[_segmentedControlButtonView layer] setBorderWidth:1.0f];
        [[_segmentedControlButtonView layer] setBorderColor:[[PPCommon getColor:@"2181f7"] CGColor]];
        [_headSegView addSubview:_segmentedControlButtonView];
        [_segmentedControlButtonView release];
    
        _notiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_notiButton setAutoresizesSubviews:YES];
        [_segmentedControlButtonView addSubview:_notiButton];
        [[_notiButton titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
        [_notiButton setTitle:@"公告" forState:UIControlStateNormal];
        [_notiButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_notiButton setBackgroundColor:[UIColor whiteColor]];
        [_notiButton addTarget:self action:@selector(segButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

        
        _emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emailButton setAutoresizesSubviews:YES];
        [_segmentedControlButtonView addSubview:_emailButton];
        [[_emailButton titleLabel] setFont:[UIFont systemFontOfSize:12.0f]];
        [_emailButton setTitle:@"邮件" forState:UIControlStateNormal];
        [_emailButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_emailButton setBackgroundColor:[UIColor whiteColor]];
        [_emailButton addTarget:self action:@selector(segButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
     
        _footToolView = [[UIView alloc] init];
        [_footToolView.layer setBorderColor:[PPCommon getColor:@"B2B2B2"].CGColor];
        [_footToolView.layer setBorderWidth:0.5];
        [_footToolView setBackgroundColor:[PPCommon getColor:@"F7F7F7"]];
        [_bgImageView insertSubview:_footToolView aboveSubview:_tableView];
        [_footToolView release];
        
        
        [_footToolView setHidden:_editStatus];
        
    
        _markToReadedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_markToReadedButton setTitle:@"标记为已读" forState:UIControlStateNormal];
        [_markToReadedButton setTitleColor:[PPCommon getColor:@"007bfb"] forState:UIControlStateNormal];
        
        [_markToReadedButton setTitleColor:[UIColor grayColor] forState: UIControlStateHighlighted];
        [[_markToReadedButton titleLabel ] setFont:[UIFont systemFontOfSize:14.0f]];
        [[_markToReadedButton titleLabel] setTextAlignment:NSTextAlignmentLeft];
        [_markToReadedButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_markToReadedButton addTarget:self action:@selector(markMailToReaded:) forControlEvents:UIControlEventTouchUpInside];
        [_markToReadedButton setBackgroundColor:[PPCommon getColor:@"F7F7F7"]];
        
        
        [_footToolView addSubview:_markToReadedButton];
        
        
        _markToUnreadedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_markToUnreadedButton setTitle:@"标记为未读" forState:UIControlStateNormal];
        [_markToUnreadedButton setTitleColor:[PPCommon getColor:@"007bfb"] forState:UIControlStateNormal];
        
        [_markToUnreadedButton setTitleColor:[UIColor grayColor] forState: UIControlStateHighlighted];
        [[_markToUnreadedButton titleLabel ] setFont:[UIFont systemFontOfSize:14.0f]];
        [[_markToUnreadedButton titleLabel] setTextAlignment:NSTextAlignmentCenter];
        [_markToUnreadedButton addTarget:self action:@selector(markMailToUnreaded:) forControlEvents:UIControlEventTouchUpInside];
        [_markToUnreadedButton setBackgroundColor:[UIColor clearColor]];
        
        [_footToolView addSubview:_markToUnreadedButton];
        
        _deleteSelectedMailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteSelectedMailButton setTitle:@"删除选中" forState:UIControlStateNormal];
        [_deleteSelectedMailButton setTitleColor:[PPCommon getColor:@"007bfb"] forState:UIControlStateNormal];
        
        [_deleteSelectedMailButton setTitleColor:[UIColor grayColor] forState: UIControlStateHighlighted];
        [[_deleteSelectedMailButton titleLabel ] setFont:[UIFont systemFontOfSize:14.0f]];
        [[_deleteSelectedMailButton titleLabel] setTextAlignment:NSTextAlignmentRight];
        [_deleteSelectedMailButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_deleteSelectedMailButton addTarget:self action:@selector(deleteSelectedMails:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteSelectedMailButton setBackgroundColor:[UIColor clearColor]];
        
        [_footToolView addSubview:_deleteSelectedMailButton];
        
        [_markToReadedButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 16, 0, 0)];
        [_deleteSelectedMailButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 16)];
        
        
//        _markToReadedButton.layer.borderWidth = 1;
//        _markToUnreadedButton.layer.borderWidth = 1;
//        _deleteSelectedMailButton.layer.borderWidth = 1;
        
        
        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = self;
        _header.viewHeight = 65.0;
        _header.contentInsetTop = headFixedHeight;
        [_header setBackgroundColor:[UIColor clearColor]];
        _header.scrollView = _tableView;
        
        [_header release];
        
        // 上拉加载更多
        _footer = [[PPRefreshFootMoreView alloc] init];
        [_tableView setTableFooterView:_footer];
        [_footer setBackgroundColor:[UIColor clearColor]];
        [_footer release];
        
        [[_tableView tableFooterView] setHidden:YES];
        
        
        _currPage = 0;

        
        [self initVerticalFrame];

        _ppMBProgressHUD = [[PPMBProgressHUD alloc] init];
        [_ppMBProgressHUD hide:YES];
        [_tableView addSubview:_ppMBProgressHUD];
        [_ppMBProgressHUD release];

    }
    return self;
}

- (void)initVerticalFrame
{
    [super initVerticalFrame];
    [_tableView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height - 50)];
    [_tableView setContentInset:UIEdgeInsetsMake(headFixedHeight, 0, 0, 0)];
    
    [noRecordView setFrame:CGRectMake((_bgImageView.frame.size.width - 80) / 2, (_bgImageView.frame.size.height - 80) / 2 + 20, 50, 50)];
    
    [_segmentedControlButtonView setFrame:CGRectMake((_tableView.frame.size.width - 300) / 2, 10, 300, 30)];
    
    [_notiButton setFrame:CGRectMake(0, 0, _segmentedControlButtonView.frame.size.width / 2, 30)];
    [_emailButton setFrame:CGRectMake(_notiButton.frame.size.width + _notiButton.frame.origin.x, 0,
                                      _segmentedControlButtonView.frame.size.width / 2, 30)];
   
    [_headSegView setFrame:CGRectMake(0, headSegView_newY, _tableView.frame.size.width, headFixedHeight)];
    if (_editStatus) {
        [_footToolView setFrame:CGRectMake(0, _tableView.frame.size.height + _tableView.frame.origin.y - _footToolViewFixed_newY,
                                           _tableView.frame.size.width, footFixedHeight)];
    }
    else{
        [_footToolView setFrame:CGRectMake(0, _tableView.frame.size.height + _tableView.frame.origin.y,
                                           _tableView.frame.size.width, footFixedHeight)];
    }
//    NSLog(@"%@",NSStringFromCGRect(_footToolView.frame));
    [_markToReadedButton setFrame:CGRectMake(0, 0, _footToolView.frame.size.width / 3, 50)];
    [_markToUnreadedButton setFrame:CGRectMake(_markToReadedButton.frame.origin.x + _markToReadedButton.frame.size.width, 0, _footToolView.frame.size.width / 3 , 50)];
    [_deleteSelectedMailButton setFrame:CGRectMake(_markToUnreadedButton.frame.origin.x + _markToUnreadedButton.frame.size.width, 0, _footToolView.frame.size.width / 3, 50)];
    
    [_sectionView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, 35)];
    [_tableView setContentInset:UIEdgeInsetsMake(85, 0, 0, 0)];
    
    [_selectAllButton setFrame:CGRectMake(10, 0, 80 , _sectionView.frame.size.height)];
    
    [_header setFrame:CGRectMake(0, -65, _bgImageView.frame.size.width, 65)];
    
    CGRect arrowRect = _header.arrowImage.frame;
    arrowRect.size.height = 55.0f;
    [_header.arrowImage setFrame:arrowRect];
    
    CGRect statusLabelRect = _header.lastUpdateTimeLabel.frame;
    statusLabelRect.origin.y = 30.0f;
    [_header.lastUpdateTimeLabel setFrame:statusLabelRect];
    
    _header.viewHeight = 65.0;

}

-(void)initHorizontalFrame
{
    [super initHorizontalFrame];
    [_tableView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, _bgImageView.frame.size.height - 50)];
    [_tableView setContentInset:UIEdgeInsetsMake(headFixedHeight, 0, 0, 0)];
    
    [noRecordView setFrame:CGRectMake((_bgImageView.frame.size.width - 80) / 2, (_bgImageView.frame.size.height - 80) / 2 + 70, 50, 50)];
    [_segmentedControlButtonView setFrame:CGRectMake((_tableView.frame.size.width - 300) / 2, 10, 300, 30)];
//    [_headSegView setFrame:CGRectMake(0, _tableView.frame.origin.y, _tableView.frame.size.width, headFixedHeight)];
    [_notiButton setFrame:CGRectMake(0, 0, _segmentedControlButtonView.frame.size.width / 2, 30)];
    [_emailButton setFrame:CGRectMake(_notiButton.frame.size.width + _notiButton.frame.origin.x, 0,
                                      _segmentedControlButtonView.frame.size.width / 2, 30)];
    if (_editStatus) {
        [_footToolView setFrame:CGRectMake(0, _tableView.frame.size.height + _tableView.frame.origin.y - _footToolViewFixed_newY,
                                           _tableView.frame.size.width, footFixedHeight)];
    }else{
        [_footToolView setFrame:CGRectMake(0, _tableView.frame.size.height + _tableView.frame.origin.y,
                                           _tableView.frame.size.width, footFixedHeight)];
    }
//    NSLog(@"%@",NSStringFromCGRect(_footToolView.frame));
    [_markToReadedButton setFrame:CGRectMake(0, 0, _footToolView.frame.size.width / 3 - 20, 50)];
    [_markToUnreadedButton setFrame:CGRectMake(_markToReadedButton.frame.origin.x + _markToReadedButton.frame.size.width, 0, _footToolView.frame.size.width / 3 + 20  , 50)];
    [_deleteSelectedMailButton setFrame:CGRectMake(_markToUnreadedButton.frame.origin.x + _markToUnreadedButton.frame.size.width, 0, _footToolView.frame.size.width / 3, 50)];
    
    [_sectionView setFrame:CGRectMake(0, 50, _bgImageView.frame.size.width, 35)];
    [_headSegView setFrame:CGRectMake(0, headSegView_newY, _tableView.frame.size.width, headFixedHeight)];
    [_tableView setContentInset:UIEdgeInsetsMake(85, 0, 0, 0)];
    [_selectAllButton setFrame:CGRectMake(10, 0, 80 , _sectionView.frame.size.height)];
    
    [_header setFrame:CGRectMake(0, -45, _bgImageView.frame.size.width, 45)];
    
    CGRect arrowRect = _header.arrowImage.frame;
    arrowRect.size.height = 35.0f;
    [_header.arrowImage setFrame:arrowRect];
    
    CGRect statusLabelRect = _header.lastUpdateTimeLabel.frame;
    statusLabelRect.origin.y = 25.0f;
    [_header.lastUpdateTimeLabel setFrame:statusLabelRect];
    
    _header.viewHeight = 45.0;

}


+ (PPNoticeListView *)sharedInstance
{
    if(!ppNoticeListView){
        ppNoticeListView = [[[PPNoticeListView alloc] init] autorelease];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppNoticeListView atIndex:1002];
    }
    return ppNoticeListView;
}


/// <summary>
/// 密保设置页面从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showPPNoticeListViewByRight
{
    
    [super showViewByRight];
}

-(void)showPPNoticeListViewByLeft
{
    [super showViewByLeft];

}

-(void)backButtonPressed
{
    [self hiddenPPNoticeListViewInRight];
    PPCenterView *ppCenterView = [[PPCenterView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppCenterView atIndex:1002];
    [ppCenterView showCenterViewByLeft];
    [ppCenterView release];

}

-(void)hiddenPPNoticeListViewInRight
{
    [super hiddenViewInRight];
}
- (void)hiddenPPNoticeListViewInLeft
{
    [super hiddenViewInLeft];
}


-(void)didHiddenView
{
    ppNoticeListView = nil;
    [_ppMBProgressHUD removeFromSuperview];
    
    [super didHiddenView];
}

-(void)didShowView{
    
    if (_pageType == PageTypeOfEmail)
    {
        [self segButtonTouchUpInside:_emailButton];
    }
    else if(_pageType == PageTypeOfNoti)
    {
        [self segButtonTouchUpInside:_notiButton];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PPNotice *ppNotice = [_tableArray objectAtIndex:[indexPath row]];
    static NSString *CellIdentifier = @"Cell";
    RMPersonTableViewCell *cell ;
    
    cell = [[[RMPersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.delegate = self;
    [cell setCanSwipe:!_editStatus];
    if ([ppNotice isRead])
    {
        [cell setThumbnail:[PPUIKit setLocaImage:nil]];
    }else
    {
        [cell setThumbnail:[PPUIKit setLocaImage:@"isNoRead"]];
    }
    
    if (_isCheckedAll)
    {
        [cell setChecked:YES];
    }
    else
    {
        if ([_selectedCellArray containsObject:[NSNumber numberWithInteger: indexPath.row]]) {
            [cell setChecked:YES];
        }
        else
        {
            [cell setChecked:NO];
        }
        
    }
    [[cell titleLabel] setText:[ppNotice title]];
    [[cell detailLabel] setText:[ppNotice content]];
    [cell setFavourite:![ppNotice isRead] animated:NO];
    [cell setSendTime:[ppNotice sendDate]];
    [cell setMessageId:[ppNotice messageId]];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[ppNotice sendDate]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    [[cell dateLabel] setText:currentDateStr];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    RMPersonTableViewCell *cell = (RMPersonTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (_editStatus) {
        if (cell.checked) {
            [cell setChecked:NO];
            if (_selectedCellArray) {
                [_selectedCellArray removeObject:[NSNumber numberWithInteger:indexPath.row]];
            }
        }
        else if (!cell.checked) {
            [cell setChecked:YES];
            //记录下当前选中行的位置
            [_selectedCellArray addObject:[NSNumber numberWithInteger:indexPath.row]];
        }
        if ([_selectedCellArray count] < [_tableArray count]) {
            [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailUnchecked"] forState:UIControlStateNormal];
            [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailUnchecked"] forState:UIControlStateHighlighted];
            [_selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
            _isCheckedAll = NO;
        }
        else
        {
            [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailChecked"] forState:UIControlStateNormal];
            [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailChecked"] forState:UIControlStateHighlighted];
            [_selectAllButton setTitle:@"取消全选" forState:UIControlStateNormal];
            _isCheckedAll = YES;
        }
    }
    else
    {
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
        
        PPNoticeContentView *ppNoticeContentView = [[PPNoticeContentView alloc] init];
        
        [[ppNoticeContentView mailTitleLabel] setText:cell.titleLabel.text];
        [[ppNoticeContentView mailSenderLabel] setText:[NSString stringWithFormat:@"发送人：%@",cell.senderLabel.text]];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:cell.sendTime];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentDateStr = [dateFormatter stringFromDate:date];
        [dateFormatter release];
        
        [[ppNoticeContentView mailDateLabel] setText:[NSString stringWithFormat:@"发送时间：%@",currentDateStr]];
        [[ppNoticeContentView mailContentTextView] setText:cell.detailLabel.text];
        [ppNoticeContentView setNoticeType:_pageType];
        [ppNoticeContentView showPPNoticeContentViewByRight];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppNoticeContentView atIndex:1002];
        [ppNoticeContentView release];
        
        PPNotice *ppNotice = [_tableArray objectAtIndex:[indexPath row]];
        
        if (_pageType == PageTypeOfEmail) {
            if (!ppNotice.isRead) {
                char hexToKen[16];
                str_to_hex((char *)[[[PPAppPlatformKit sharedInstance] current20MinToken] UTF8String], 32, (unsigned char *)hexToKen);
                
                PPNoticeManager *ppNoticeManager = [[PPNoticeManager alloc] init];
                [ppNoticeManager ppRequestSetMessage:cell.messageId Token:hexToKen EmailIdArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:cell.messageId], nil] IsRead:YES delegate:self];
                [ppNoticeManager release];
            }
            
        }
        else if (_pageType == PageTypeOfNoti){
            //更改邮件已读未读操作
            if (!ppNotice.isRead) {
                [ppNotice setIsRead:YES];
                PPNoticeManager *ppNoticeManager = [[PPNoticeManager alloc] init];
                [ppNoticeManager updateNotice:ppNotice];
                [ppNoticeManager release];
            }
            
            
        }
        [self hiddenPPNoticeListViewInLeft];
    }
}

#pragma mark - Swipe Table View Cell Delegate

-(void)swipeTableViewCellDidStartSwiping:(RMSwipeTableViewCell *)swipeTableViewCell {
//        NSLog(@"bb");
}

-(void)swipeTableViewCell:(RMPersonTableViewCell *)swipeTableViewCell didSwipeToPoint:(CGPoint)point velocity:(CGPoint)velocity {
//    NSLog(@"aa");

}

-(void)swipeTableViewCellWillResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity {

    //更改邮件已读未读操作
    NSIndexPath *indexPath = [_tableView indexPathForCell:swipeTableViewCell];
    PPNotice *ppNotice = [_tableArray objectAtIndex:[indexPath row]];
    
    if (point.x >= CGRectGetHeight(swipeTableViewCell.frame)) {
        
        //NO标记未读为已读
        [(RMPersonTableViewCell*)swipeTableViewCell setFavourite:[ppNotice isRead] animated:YES];
        [ppNotice setIsRead:![ppNotice isRead]];
        
        if ([ppNotice isRead]) {
            [(RMPersonTableViewCell*)swipeTableViewCell setThumbnail:[PPUIKit setLocaImage:nil]];
        }else
        {
            [(RMPersonTableViewCell*)swipeTableViewCell setThumbnail:[PPUIKit setLocaImage:@"isNoRead"]];
        }
        //请求接口更改邮件标记[公告存在本地]
        PPNoticeManager *ppNoticeManager = [[PPNoticeManager alloc] init];
        if (_pageType == PageTypeOfEmail)
        {
            char hexToKen[16];
            str_to_hex((char *)[[[PPAppPlatformKit sharedInstance] current20MinToken] UTF8String], 32, (unsigned char *)hexToKen);
            
            NSArray *array = [NSArray arrayWithObject:[NSString stringWithFormat:@"%d",ppNotice.messageId]];
            [ppNoticeManager ppRequestSetMessage:0 Token:hexToKen EmailIdArray:array IsRead:[ppNotice isRead] delegate:self];
        }
        else if (_pageType == PageTypeOfNoti)
        {
//            [ppNotice setIsRead:YES];
            [ppNoticeManager updateNotice:ppNotice];
        }
        [ppNoticeManager release];
    }
    else if (point.x < 0 && -point.x >= CGRectGetHeight(swipeTableViewCell.frame))
    {
        swipeTableViewCell.shouldAnimateCellReset = NO;
        [[(RMPersonTableViewCell*)swipeTableViewCell checkmarkGreyImageView] removeFromSuperview];
        [UIView animateWithDuration:0.25
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             swipeTableViewCell.contentView.frame = CGRectOffset(swipeTableViewCell.contentView.bounds, swipeTableViewCell.contentView.frame.size.width, 0);
                         }
                         completion:^(BOOL finished) {
                             //删除行数据
                             [swipeTableViewCell.contentView setHidden:YES];
                             NSIndexPath *indexPath = [_tableView indexPathForCell:swipeTableViewCell];
                             [_tableArray removeObjectAtIndex:indexPath.row];
                             [_tableView beginUpdates];
                             [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                             [_tableView endUpdates];
                             
                             //请求接口删除邮件[公告存在本地]
                             PPNoticeManager *ppNoticeManager = [[PPNoticeManager alloc] init];
                             if (_pageType == PageTypeOfEmail)
                             {
                                 char hexToKen[16];
                                 str_to_hex((char *)[[[PPAppPlatformKit sharedInstance] current20MinToken] UTF8String], 32, (unsigned char *)hexToKen);
                                 NSArray *array = [NSArray arrayWithObject:[NSString stringWithFormat:@"%d",ppNotice.messageId]];
                                 [ppNoticeManager ppRequestDelMessage:0 Token:hexToKen EmailIdArray:array delegate:self];
                             }
                             else if(_pageType == PageTypeOfNoti)
                             {
                                 [ppNoticeManager deleteNotice:ppNotice];
                             }
                             [ppNoticeManager release];
                         }
         ];
    }
}

-(void)swipeTableViewCellDidResetState:(RMSwipeTableViewCell *)swipeTableViewCell fromPoint:(CGPoint)point animation:(RMSwipeTableViewCellAnimationType)animation velocity:(CGPoint)velocity {
//#if LOG_DELEGATE_METHODS
//    NSLog(@"swipeTableViewCellDidResetState: %@ fromPoint: %@ animation: %d, velocity: %@", swipeTableViewCell, NSStringFromCGPoint(point), animation, NSStringFromCGPoint(velocity));
//#endif
//    if (point.x < 0 && -point.x > CGRectGetHeight(swipeTableViewCell.frame)) {
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeTableViewCell];
//        [self.array removeObjectAtIndex:indexPath.row];
//        [self.tableView beginUpdates];
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView endUpdates];
//    }
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 让刷新控件恢复默认的状态
    [_header endRefreshing];
    [[_footer infoLabel] setText:@"上拉即可刷新"];
    [[_footer activityIndicator] stopAnimating];
    return [_tableArray count];
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}


- (void)keyboardWillHideCallBack:(NSNotification *)noti
{
    [super keyboardWillHideCallBack:noti];
}

- (void)keyboardWillShowCallBack:(NSNotification *)noti
{
    [super keyboardWillShowCallBack:noti];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(_keyBoardIsShow)
    {
        [self textChange:textField];
    }
}

- (void)textChange:(UITextField *)paramTextField
{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        
    }
    else if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
    }
}



- (void)dealloc{
    
    [_tableArray release];
    [super dealloc];
}



- (void)didSuccessGetMessageCallBack:(int)paramMessageCount Pages:(int)paramPageCount ItemArray:(NSMutableArray *)paramItemArray
{
    [_header endRefreshing];
    [_footer setIsDragging:YES];
    
    if ([paramItemArray count] == 0) {
        [_footer setCanLoadMore:NO];
        [_tableView.tableFooterView setHidden:YES];
        [noRecordView setHidden:NO];
    }
    //判断是否还有更多邮件，20是每页显示条数
    else if (_currPage * 20 + [paramItemArray count] <= paramMessageCount) {
        [_footer setCanLoadMore:NO];
        [_tableView.tableFooterView setHidden:YES];
        [noRecordView setHidden:YES];
    }
    else
    {
        [_footer setCanLoadMore:YES];
        [_tableView.tableFooterView setHidden:NO];
        [noRecordView setHidden:YES];
    }

    if(_currPage == 0)
    {
        if (_tableArray) {
            [_tableArray release];
            _tableArray = nil;
        }
        _tableArray = [[NSMutableArray alloc] initWithArray:paramItemArray];
    }
    else
    {
        [_tableArray addObjectsFromArray:paramItemArray];
    }

    [_tableView reloadData];
}

- (void)didFailRequestConnectionCallBack:(PPNoticeManager *)ppNoticeManager errorCode:(TRHTTPConnectionError)errorCode userInfo:(NSMutableDictionary *)userInfo
{

    [_header endRefreshing];
    // 让刷新控件恢复默认的状态
    [[_footer infoLabel] setText:@"上拉即可刷新"];
    [[_footer activityIndicator] stopAnimating];
    [_ppMBProgressHUD show:YES];
    _ppMBProgressHUD.labelText = @"通信失败，稍后再试";
    [_ppMBProgressHUD hide:YES afterDelay:2];
    
    [[_tableView tableFooterView] setHidden:YES];
    [_tableView reloadData];
}

- (void)didSuccessSetMessageCallBack{
    NSLog(@"编辑修改成功");
}
- (void)didSuccessDelMessageCallBack{
    NSLog(@"删除成功");
}

- (void)didFailGetMessageCallBack:(MessageStatus)status
{
//    [_ppMBProgressHUD hide:YES];
    [_header endRefreshing];
    [_footer setIsDragging:YES];
    [_footer setCanLoadMore:NO];
    [[_footer activityIndicator] stopAnimating];
    [_tableView.tableFooterView setHidden:YES];
    if (status == IH_E_MESSSGE_NOT_EXIST) {
        [_tableArray removeAllObjects];
        [_tableView reloadData];
        [noRecordView setHidden:NO];
    }
}

#pragma mark  ---scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y <= - headFixedHeight )
    {
        return;
    }
    
    if (scrollView.contentOffset.y + scrollView.bounds.size.height  > scrollView.contentSize.height) {
        if (_editStatus) {
            return;
        }
        else
        {
            if (_footer.canLoadMore &&_footer.isDragging)
            {
                [[_footer infoLabel] setText:@"加载中..."];
                //            [tableView setScrollEnabled:YES];
                [_footer setIsDragging:NO];
//                [_footer setCanLoadMore:NO];
                [[_footer activityIndicator] startAnimating];
                _currPage ++;
                [self loadData:_currPage];
            }
        }
        return;
    }
    
    
    CGFloat headSegView_y = _oldY - scrollView.contentOffset.y;
    CGRect headSegView_f = _headSegView.frame;
    headSegView_newY = headSegView_f.origin.y + headSegView_y;
    
    if (headSegView_newY > headFixedY) {
        headSegView_newY = headFixedY;
    }
    if (headSegView_newY < headFixedY - 50) {
        headSegView_newY = headFixedY - 50;
    }
    
    if (_headSegView.frame.origin.y != headSegView_newY) {
        headSegView_f.origin.y = headSegView_newY;
        [_headSegView setFrame:headSegView_f];
        CGFloat top = headSegView_f.origin.y + headSegView_f.size.height - headFixedY;
        [_tableView setContentInset:UIEdgeInsetsMake(top, 0, 0, 0)];
        [_header setContentInsetTop:top];
    }
    
    if (_editStatus) {
        
        CGFloat footToolView_y = _oldY - scrollView.contentOffset.y;

        CGRect footToolView_f = _footToolView.frame;
        CGFloat footToolView_newY = footToolView_f.origin.y - footToolView_y;
        _footToolViewFixed_newY = self.bounds.size.height - footToolView_newY;
        if (_footToolViewFixed_newY >= 50) {
            _footToolViewFixed_newY = 50;
        }else if (_footToolViewFixed_newY <= 0)
        {
            _footToolViewFixed_newY = 0;
        }
        
        if (footToolView_newY < _tableView.frame.size.height + _tableView.frame.origin.y - footFixedHeight) {
            footToolView_newY = _tableView.frame.size.height + _tableView.frame.origin.y - footFixedHeight;
        }
        if (footToolView_newY > _tableView.frame.size.height + _tableView.frame.origin.y) {
            footToolView_newY = _tableView.frame.size.height + _tableView.frame.origin.y;
        }
        
        if (_footToolView.frame.origin.y != footToolView_newY) {
            footToolView_f.origin.y = footToolView_newY;
            [_footToolView setFrame:footToolView_f];
        }
    }
    else
    {
        
    }
    
    _oldY =  scrollView.contentOffset.y;
    _isCellAnimation = NO;
}

#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_header == refreshView)
    {
        _currPage = 0;
        [self loadData:_currPage];
        [_footer setCanLoadMore:NO];
    }
}

- (void)loadData:(int)page
{
    _isCellAnimation = NO;
    [_footer setCanLoadMore:YES];
    
    [noRecordView setHidden:YES];
    
    char hexToKen[16];
    str_to_hex((char *)[[[PPAppPlatformKit sharedInstance] current20MinToken] UTF8String], 32, (unsigned char *)hexToKen);
    PPNoticeManager *ppNoticeManager = [[PPNoticeManager alloc] init];
    
    [_tableArray removeAllObjects];
    [_tableView reloadData];
    
    if (_pageType == PageTypeOfNoti)
    {
        _pageType = PageTypeOfNoti;
        [_notiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_notiButton setBackgroundColor:[PPCommon getColor:@"2181f7"]];
        [_emailButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_emailButton setBackgroundColor:[UIColor whiteColor]];
        
        NSMutableArray *notiArray = [ppNoticeManager getAllNotice];
        
        if (PP_ISNSLOG) {
            NSLog(@"从本地取出公告-----%@",notiArray);
        }
        for (NSDictionary *dic in notiArray) {
            PPNotice *notice = [[PPNotice alloc] initWithDictionary:dic];
            [_tableArray addObject:notice];
            [notice release];
        }
        if ([_tableArray count] > 0) {
            [noRecordView setHidden:YES];
        }
        else
        {
            [self performSelector:@selector(showNoRecordView) withObject:nil afterDelay:0.3];
        }
        [_tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
        [_header performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.3];
        [_footer setIsDragging:YES];
        [[_tableView tableFooterView] setHidden:YES];
        
    }
    else
    {
        _pageType = PageTypeOfEmail;
        [_emailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_emailButton setBackgroundColor:[PPCommon getColor:@"2181f7"]];
        [_notiButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_notiButton setBackgroundColor:[UIColor whiteColor]];
        [ppNoticeManager ppRequestGetMessage:0
                                       Token:hexToKen
                                        Type:MessageTypeOfEmail CurrPage:page delegate:self];
//        [_ppMBProgressHUD hide:YES];
    }
    [ppNoticeManager release];
}

- (void)showNoRecordView
{
    [noRecordView setHidden:NO];
    [[_tableView tableFooterView] setHidden:YES];
}

//a

- (void)segButtonTouchUpInside:(UIButton *)paramSender
{
    if ([_header isRefreshing]) {
        return;
    }
    if ([_tableView isDragging]) {
        if (PP_ISNSLOG) {
            NSLog(@"tableview is been dragging");
        }
        return;
    }
    if (_editStatus) {
        return;
    }
    
    [_tableView setContentOffset:CGPointMake(0, -85) animated:NO];
    _isCellAnimation = NO;
    
    char hexToKen[16];
    str_to_hex((char *)[[[PPAppPlatformKit sharedInstance] current20MinToken] UTF8String], 32, (unsigned char *)hexToKen);
    if (paramSender == _notiButton)
    {
        _pageType = PageTypeOfNoti;
        [_notiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_notiButton setBackgroundColor:[PPCommon getColor:@"2181f7"]];
        [_emailButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_emailButton setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        _pageType = PageTypeOfEmail;
        [_emailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_emailButton setBackgroundColor:[PPCommon getColor:@"2181f7"]];
        [_notiButton setTitleColor:[PPCommon getColor:@"2181f7"] forState:UIControlStateNormal];
        [_notiButton setBackgroundColor:[UIColor whiteColor]];
    }
    [_header setState:RefreshStateRefreshing];
}

- (void)editButtonTouchUpInside:(UIButton *)sender
{
    _isCellAnimation = YES;
    //如果是编辑状态，则退出编辑状态
    if (_editStatus)
    {
        [_header setHidden:NO];
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        [_selectAllButton setAlpha:0];
        
        _editStatus = NO;
        
        [self footToolViewAnimation:NO Button:sender];
        
        _isCheckedAll = YES;
        [self selectAllButtonTouchUpInside];
        _isCellAnimation = YES;
    }
    else
    {
        if ([_header isRefreshing]) {
            return;
        }
        
        [_header setHidden:YES];
        [[_tableView tableFooterView] setHidden:YES];
        
        [sender setTitle:@"取消" forState:UIControlStateNormal];
        [_selectAllButton setAlpha:1];
        [_selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
        _editStatus = YES;
        
        if (!_selectedCellArray) {
            _selectedCellArray =[[NSMutableArray alloc] init];
        }

        [self footToolViewAnimation:YES Button:sender];
        
        [_tableView reloadData];
    }
    [self selectAllButtonAnimation:YES];
}

//编辑状态底部工具栏动画
- (void)footToolViewAnimation:(BOOL)paramShow Button:(UIButton *)sender
{
    [UIView beginAnimations:@"footToolViewAnimation" context:nil];
    [UIView setAnimationDuration:0.3];
    if (paramShow) {
        [_footToolView setFrame:CGRectMake(0, _tableView.frame.size.height + _tableView.frame.origin.y - footFixedY,
                                           _tableView.frame.size.width, footFixedHeight)];
        
        //设置记录旋屏得偏移量
        _footToolViewFixed_newY = footFixedY;
    }else{
        [_footToolView setFrame:CGRectMake(0, _tableView.frame.size.height + _tableView.frame.origin.y, _tableView.frame.size.width, footFixedHeight)];
        _footToolViewFixed_newY = 0;
    }
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    [self changeButtonTitle:sender];
}

//改变编辑按钮样式动画
- (void)changeButtonTitle:(UIButton *)sender
{
    [UIView beginAnimations:@"changeButtonTitle1" context:nil];
    [UIView setAnimationDuration:0.3];
    [[sender titleLabel] setAlpha:0];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"changeButtonTitle2" context:nil];
    [UIView setAnimationDuration:0.3];
    [[sender titleLabel] setAlpha:1];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
}

- (void)selectAllButtonTouchUpInside
{
    _isCellAnimation = NO;
    
    if (_isCheckedAll)
    {
        [_selectedCellArray removeAllObjects];
        [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailUnchecked"] forState:UIControlStateNormal];
        [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailUnchecked"] forState:UIControlStateHighlighted];
        [_selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
        _isCheckedAll = NO;
    }
    else
    {
        for (NSInteger i = 0; i < [_tableArray count]; i ++) {
            
            if (![_selectedCellArray containsObject:[NSNumber numberWithInteger:i]]) {
                [_selectedCellArray addObject:[NSNumber numberWithInteger:i]];
            }
        }
        
        [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailChecked"] forState:UIControlStateNormal];
        [_selectAllButton setImage:[PPUIKit setLocaImage:@"PPMailChecked"] forState:UIControlStateHighlighted];
        [_selectAllButton setTitle:@"取消全选" forState:UIControlStateNormal];
        _isCheckedAll = YES;
    }
    
    [_tableView reloadData];
}

- (void)selectAllButtonAnimation:(BOOL)paramBoolShow
{
    if (paramBoolShow) {
        if (_editStatus) {
            [_selectAllButton setAlpha:0];
            [UIView animateWithDuration:0.3 animations:^{
                [_selectAllButton setAlpha:1];
            }];
        }
        else
        {
            [_selectAllButton setAlpha:1];
            [UIView animateWithDuration:0.3 animations:^{
                [_selectAllButton setAlpha:0];
            }];
        }
    }
}


- (void)markMailToReaded:(UIButton *)sender
{
    if (([_selectedCellArray count] <= 0))
    {
        NSString *message = @"请选择邮件！";
        
        if (_pageType == PageTypeOfNoti) {
            message = @"请选择公告！";
        }
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:message];
        
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    else
    {
        NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
        for (NSNumber * number in _selectedCellArray) {
            
            PPNotice *notice = [_tableArray objectAtIndex:[number integerValue]];
            [notice setIsRead:YES];
            
            if (_pageType == PageTypeOfEmail) {
                [array addObject:[NSString stringWithFormat:@"%d",notice.messageId]];
            }
            else if(_pageType == PageTypeOfNoti)
            {
                [array addObject:notice];
            }
            
        }
        
        PPNoticeManager *ppNoticeManager = [[PPNoticeManager alloc] init];
        //请求接口更改邮件标记[公告存在本地]
        if (_pageType == PageTypeOfEmail) {
            char hexToKen[16];
            str_to_hex((char *)[[[PPAppPlatformKit sharedInstance] current20MinToken] UTF8String], 32, (unsigned char *)hexToKen);
            
            [ppNoticeManager ppRequestSetMessage:0 Token:hexToKen EmailIdArray:array IsRead:YES delegate:self];
        }
        else if(_pageType == PageTypeOfNoti)
        {
            [ppNoticeManager updateNoticeArray:array];
        }
        
        [ppNoticeManager release];
        [self editButtonTouchUpInside:_editButton];
    }

}

- (void)markMailToUnreaded:(UIButton *)sender
{
    
    if (([_selectedCellArray count] <= 0))
    {
        NSString *message = @"请选择邮件！";
        
        if (_pageType == PageTypeOfNoti) {
            message = @"请选择公告！";
        }
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:message];
        
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    else
    {
        NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
        for (NSNumber * number in _selectedCellArray) {
            
            PPNotice *notice = [_tableArray objectAtIndex:[number integerValue]];
            [notice setIsRead:NO];
            
            if (_pageType == PageTypeOfEmail) {
                [array addObject:[NSString stringWithFormat:@"%d",notice.messageId]];
            }
            else if(_pageType == PageTypeOfNoti)
            {
                [array addObject:notice];
            }
        }
        
        PPNoticeManager *ppNoticeManager = [[PPNoticeManager alloc] init];
        //请求接口更改邮件标记[公告存在本地]
        if (_pageType == PageTypeOfEmail) {
            char hexToKen[16];
            str_to_hex((char *)[[[PPAppPlatformKit sharedInstance] current20MinToken] UTF8String], 32, (unsigned char *)hexToKen);
            [ppNoticeManager ppRequestSetMessage:0 Token:hexToKen EmailIdArray:array IsRead:NO delegate:self];
        }
        else if(_pageType == PageTypeOfNoti)
        {
            [ppNoticeManager updateNoticeArray:array];
        }
        [ppNoticeManager release];
        [self editButtonTouchUpInside:_editButton];
    }
    
    
}

- (void)deleteSelectedMails:(UIButton *)sender
{
    
    if (([_selectedCellArray count] <= 0))
    {
        NSString *message = @"请选择邮件！";
        
        if (_pageType == PageTypeOfNoti) {
            message = @"请选择公告！";
        }
        PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:message];
        
        [alert setCancelButtonTitle:@"确定" block:^{
            
        }];
        [alert addButtonWithTitle:nil block:nil];
        [alert show];
        [alert release];
    }
    else
    {
        NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
        
        NSMutableArray *indexPaths = [[[NSMutableArray alloc] init] autorelease];
        NSMutableIndexSet *indexSet = [[[NSMutableIndexSet alloc] init] autorelease];
        for (NSNumber * number in _selectedCellArray) {
            
            //记录tableview中要删除的行索引
            NSIndexPath *index = [NSIndexPath indexPathForRow:[number integerValue] inSection:0];
            [indexPaths addObject:index];
            //记录数据源中要删除的数组索引
            [indexSet addIndex:[number integerValue]];
            
            PPNotice *notice = [_tableArray objectAtIndex:[number integerValue]];
            if (_pageType == PageTypeOfEmail) {
                [array addObject:[NSString stringWithFormat:@"%d",notice.messageId]];
            }
            else if(_pageType == PageTypeOfNoti)
            {
                [array addObject:notice];
            }
        }
        
        [_tableView beginUpdates];
        [_tableArray removeObjectsAtIndexes:indexSet];
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [_tableView endUpdates];
        
        if ([_tableArray count] == 0) {
            [self performSelector:@selector(showNoRecordView) withObject:nil afterDelay:0.3];
        }
        
        PPNoticeManager *ppNoticeManager = [[PPNoticeManager alloc] init];
        //请求接口删除选中的邮件[公告存在本地]
        if (_pageType == PageTypeOfEmail) {
            char hexToKen[16];
            str_to_hex((char *)[[[PPAppPlatformKit sharedInstance] current20MinToken] UTF8String], 32, (unsigned char *)hexToKen);
            
            [ppNoticeManager ppRequestDelMessage:0 Token:hexToKen EmailIdArray:array delegate:self];
        }
        else if(_pageType == PageTypeOfNoti)
        {
            [ppNoticeManager deleteNoticeArray:array];
        }
        
        [ppNoticeManager release];
        [self performSelector:@selector(editButtonTouchUpInside:) withObject:_editButton afterDelay:0.3];
    }
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

//
//  PPHelpView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-9.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPHelpView.h"
#import "PPCommon.h"
#import "PPUIKit.h"
#import "PPWebViewData.h"
#import <CoreText/CoreText.h>
#import "PPAppPlatformKitConfig.h"
#import "PPMBProgressHUD.h"

@implementation PPHelpView

-(id)init{
    self = [super init];
    if (self) {
        

        [self.backButton setHidden:NO];
        [_titleLabel setText:@"帮助中心"];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleHelpView"]];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBounces:NO];
        [_tableView setBackgroundColor:[PPCommon getColor:@"f0eff3"]];
        [_bgImageView addSubview:_tableView];
        [_tableView release];

        
        _ppMBProgressHUD = [PPMBProgressHUD showHUDAddedTo:self animated:YES];
        [_ppMBProgressHUD setLabelText:PP_MBPROGRESSHUDTEXT];
        [self initVerticalFrame];

        [self loadHelpViewData];
    }
    return self;
}

#pragma mark - 获取 帮助数据 -

- (void)loadHelpViewData
{
    PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
    [ppWebViewData setDelegate:self];
    [ppWebViewData getHelpViewJson];
    [ppWebViewData release];
    
}



#pragma mark - 设备旋转 调整视图的位置和尺寸 -

- (void)onDeviceOrientationChange:(BOOL)animated
{
    [_tableView reloadData];
    [super onDeviceOrientationChange:animated];
}

//竖
-(void)initVerticalFrame
{
    [super initVerticalFrame];
    [_tableView setFrame:CGRectMake(0, 50 + 15, _bgImageView.frame.size.width, _bgImageView.frame.size.height  - 50 - 15)];
}


//横
-(void)initHorizontalFrame
{
    [super initHorizontalFrame];
    [_tableView setFrame:CGRectMake(0, 50 + 15, _bgImageView.frame.size.width, _bgImageView.frame.size.height  - 50 - 15)];

}


#pragma mark  - 视图显示，隐藏，消失 -

-(void)hiddenHelpViewInRight
{
    [super hiddenViewInRight];
}

-(void)showHelpViewByRight
{
    [super showViewByRight];
}


-(void)hiddenHelpViewInLeft
{
    [super hiddenViewInLeft];
}

-(void)showHelpViewByLeft
{
    [super showViewByLeft];
}

-(void)didHiddenView
{
    
//    NSLog(@"ppMBProgressHUD-%d",[_ppMBProgressHUD retainCount]);
    [super didHiddenView];
    [PPMBProgressHUD hideAllHUDsForView:self animated:YES];

}

-(void)didShowView{
    [super didShowView];
}


#pragma mark  - 关闭视图，返回上一层 -

-(void)closeButtonPressed{
    [super closeButtonPressed];
    [[[PPAppPlatformKit sharedInstance] delegate] ppClosePageViewCallBack:6];
}


- (void)backButtonPressed
{
    [self hiddenHelpViewInRight];
    PPCenterView *ppCenterView = [[PPCenterView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppCenterView atIndex:1002];
    [ppCenterView showCenterViewByLeft];
    [ppCenterView release];
}



#pragma mark - 展开/收起 Cell -

//对指定的节进行“展开/折叠”操作
-(void)collapseOrExpand:(int)section
{
	Boolean expanded = NO;
	//Boolean searched = NO;
	NSMutableDictionary *d = [_dataArray objectAtIndex:section];
    
    //如果上次点选和本次一样就反向开启或关闭
	if (section == lastHitSection) {
        //若本节model中的“expanded”属性不为空，则取出来
        if([d objectForKey:@"expanded"] != nil)
        {
            expanded = [[d objectForKey:@"expanded"] intValue];
        }
        //若原来是折叠的则展开，若原来是展开的则折叠
        [d setObject:[NSNumber numberWithBool:!expanded] forKey:@"expanded"];
    }else{
        //反选其他section关闭
        for (int i = 0; i < [_dataArray count]; i++)
        {
            NSMutableDictionary *d = [_dataArray objectAtIndex:i];
            [d setObject:[NSNumber numberWithBool:NO] forKey:@"expanded"];
        }
        
        if([d objectForKey:@"expanded"] != nil)
        {
            expanded = [[d objectForKey:@"expanded"] intValue];
        }
        //若原来是折叠的则展开，若原来是展开的则折叠
        [d setObject:[NSNumber numberWithBool:!expanded] forKey:@"expanded"];
    }
    lastHitSection = section;
}


//返回指定节的“expanded”值
-(Boolean)isExpanded:(int)section{
	Boolean expanded = NO;
	NSMutableDictionary *d = [_dataArray objectAtIndex:section];
	//若本节model中的“expanded”属性不为空，则取出来
	if([d objectForKey:@"expanded"] != nil)
		expanded = [[d objectForKey:@"expanded"]intValue];
	return expanded;
}


//按钮被点击时触发
-(void)expandButtonClicked:(id)sender{
	UIButton *btn= (UIButton*)sender;
	int section = btn.tag; //取得tag知道点击对应哪个块
	[self collapseOrExpand:section];
	//刷新tableview
	[_tableView reloadData];
}


#pragma mark - UITableViewDataSource,UITableViewDelegate -


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [_dataArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//对指定节进行“展开”判断
	if (![self isExpanded:section]) {
		//若本节是“折叠”的，其行数返回为0
		return 0;
	}
    return 1;
	
}

// 设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 44;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
	UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 44)];
	UIButton *headButton = [UIButton buttonWithType:UIButtonTypeCustom];
	//按钮填充整个视图
	headButton.frame = hView.frame;
	[headButton addTarget:self action:@selector(expandButtonClicked:)
         forControlEvents:UIControlEventTouchUpInside];
	headButton.tag = section;//把节号保存到按钮tag，以便传递到expandButtonClicked方法
    
	//根据是否展开，切换按钮显示图片
	if ([self isExpanded:section])
    {
		[headButton setImage:[PPUIKit setLocaImage:@"PPHelpViewCellArrowsDown"] forState:UIControlStateNormal];
    }
	else
    {
		[headButton setImage:[PPUIKit setLocaImage:@"PPHelpViewCellArrowsRight"] forState:UIControlStateNormal];
    }
	//由于按钮的标题，
	//4个参数是上边界，左边界，下边界，右边界。
	headButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[headButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    
    [headButton setImageEdgeInsets:UIEdgeInsetsMake(5, _tableView.frame.size.width - 20, 0, 0)];
    
    
	//设置按钮显示颜色
	headButton.backgroundColor = [UIColor whiteColor];
	[headButton setTitle:[[_dataArray objectAtIndex:section] objectForKey:@"groupname"] forState:UIControlStateNormal];
    [[headButton titleLabel] setFont:[UIFont systemFontOfSize:15]];
	[headButton setTitleColor:[PPCommon getColor:@"191E23"] forState:UIControlStateNormal];
	[hView addSubview: headButton];
	
    
    
    UIView *lineView = [[UIView alloc] init];
    [lineView setFrame:CGRectMake(0, 0, _tableView.frame.size.width, 0.5)];
    [lineView setBackgroundColor:[PPCommon getColor:@"CCCCCC"]];
    [hView addSubview:lineView];
    [lineView release];
    if (section >= 1) {
        [lineView setFrame:CGRectMake(16, 0, _tableView.frame.size.width, 0.5)];
    }
    
    if (section == [_dataArray count] - 1) {
        UIView *lineView = [[UIView alloc] init];
        [lineView setFrame:CGRectMake(0, 43.5, _tableView.frame.size.width, 0.5)];
        [lineView setBackgroundColor:[PPCommon getColor:@"CCCCCC"]];
        [hView addSubview:lineView];
        [lineView release];
    }
	return [hView autorelease];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDictionary *m = (NSDictionary*)[_dataArray objectAtIndex: indexPath.section];
	NSArray *d = (NSArray*)[m objectForKey:@"cell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //需要把以前添加的subview给移除 重用时会重复添加
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIFont *labelFont = [UIFont systemFontOfSize:13];
    NSArray *cellAyyay = [d objectAtIndex:[indexPath row]];
    //显示数据
    if (indexPath.section == 0) {
        CGRect rect = CGRectMake(15, 5, _tableView.frame.size.width - 30, 0);
        for (int i = 0; i < [cellAyyay count]; i++) {
            NSDictionary *questionDic = [cellAyyay objectAtIndex:i];
            NSString *questionStr = [questionDic objectForKey:@"question"];
            NSString *answerStr = [questionDic objectForKey:@"answer"];
            
            UILabel *questionLabel =[[UILabel alloc] init];
            if (i == 0)
            {
                [questionLabel setFrame:CGRectMake(rect.origin.x, rect.origin.y + 10, rect.size.width, 0)];
            }
            else
            {
                [questionLabel setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 0)];
            }

            [questionLabel setTextColor:[PPCommon getColor:@"392E34"]];
            [questionLabel setBackgroundColor:[UIColor clearColor]];
            [questionLabel setNumberOfLines:0];
            [questionLabel setFont:labelFont];
            [[cell contentView] addSubview:questionLabel];
            [questionLabel setText:questionStr];;
            [questionLabel sizeToFit];
            [questionLabel release];
            
            UILabel *answerLabel = [[UILabel alloc] init];
            [answerLabel setFrame:CGRectMake(rect.origin.x, questionLabel.frame.size.height + questionLabel.frame.origin.y + 5, rect.size.width, 0)];
            
            [answerLabel setBackgroundColor:[UIColor clearColor]];
            [answerLabel setTextColor:[PPCommon getColor:@"6C6C6C"]];
            [answerLabel setNumberOfLines:0];
            [answerLabel setFont:labelFont];
            [[cell contentView] addSubview:answerLabel];
            [answerLabel setText:answerStr];
            [answerLabel sizeToFit];
            [answerLabel release];
            
            rect = CGRectMake(rect.origin.x, answerLabel.frame.size.height+answerLabel.frame.origin.y + 10, rect.size.width, rect.size.height);

        }
    }
    else
    {
        CGRect rect = CGRectMake(15, 5, _tableView.frame.size.width - 30, 0);
        for (int i = 0; i < [cellAyyay count]; i++) {
            NSString *cellStr = [cellAyyay objectAtIndex:i];
            UILabel *label = [[UILabel alloc] init];
            if (i == 0)
            {
                [label setFrame:CGRectMake(rect.origin.x, rect.origin.y + 10 + rect.size.height, rect.size.width, rect.size.height)];
            }
            else
            {
                [label setFrame:CGRectMake(rect.origin.x, rect.origin.y + rect.size.height, rect.size.width, rect.size.height)];
            }
            
            [label setNumberOfLines:0];
            [label setFont:labelFont];
            [label setText:cellStr];
            [label setTextColor:[PPCommon getColor:@"6C6C6C"]];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setLineBreakMode:NSLineBreakByCharWrapping];
            [[cell contentView] addSubview:label];
            [label release];
            [label sizeToFit];
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, label.frame.size.height+label.frame.origin.y);
        }

    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *m = (NSDictionary*)[_dataArray objectAtIndex: indexPath.section];
	NSArray *d = (NSArray*)[m objectForKey:@"cell"];
    NSArray *cellAyyay = [d objectAtIndex:[indexPath row]];
    if (indexPath.section == 0) {
        float height = 5;
        for (int i = 0; i < [cellAyyay count]; i++) {
            NSDictionary *questionDic = [cellAyyay objectAtIndex:i];
            NSString *questionStr = [questionDic objectForKey:@"question"];
            NSString *answerStr = [questionDic objectForKey:@"answer"];
            CGSize sizeQuestion = [questionStr sizeWithFont:[UIFont systemFontOfSize:13]
                                        constrainedToSize:CGSizeMake(_tableView.frame.size.width - 30, MAXFLOAT)
                                            lineBreakMode:NSLineBreakByWordWrapping];
            CGSize sizeAnswer = [answerStr sizeWithFont:[UIFont systemFontOfSize:13]
                                    constrainedToSize:CGSizeMake(_tableView.frame.size.width - 30, MAXFLOAT)
                                        lineBreakMode:NSLineBreakByWordWrapping];
            if (i == 0)
            {
                height += sizeQuestion.height + 15 + sizeAnswer.height + 10;
            }
            else
            {
                height += sizeQuestion.height + 5 + sizeAnswer.height + 10;
            }

        }
        return height;
    }
    else
    {
        float height = 5;
        for (int i = 0; i < [cellAyyay count]; i++) {
            NSString *cellStr = [cellAyyay objectAtIndex:i];
            CGSize labelSize = [cellStr sizeWithFont:[UIFont systemFontOfSize:13]
                                   constrainedToSize:CGSizeMake(_tableView.frame.size.width - 30, MAXFLOAT)
                                       lineBreakMode:NSLineBreakByWordWrapping];
            if (i == 0)
            {
                height += labelSize.height + 15;
            }
            else
            {
                height += labelSize.height + 10;
            }
        }
        return height;
    }
}

#pragma mark -  PPWebViewDataDelegate 回调 -

- (void)helpViewJsonResponseCallBack:(NSDictionary *)paramDic
{
    
    if ([[paramDic objectForKey:@"error"] intValue] != 0) {
        [_ppMBProgressHUD setLabelText:@"获取数据异常"];
        [_ppMBProgressHUD hide:YES afterDelay:1];
        return;
    }
    [_ppMBProgressHUD hide:YES];
    NSMutableArray *tempDataArray = [[NSMutableArray alloc] initWithArray:[paramDic objectForKey:@"data"]];
    if (_dataArray) {
        [_dataArray release];
        _dataArray = nil;
    }
    _dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [tempDataArray count]; i++) {
        NSMutableDictionary *tableViewDic = [[NSMutableDictionary alloc] init];
        [tableViewDic setObject:[[tempDataArray objectAtIndex:i] objectForKey:@"title"] forKey:@"groupname"];
        NSMutableArray *cellArray = [[NSMutableArray alloc] init];
        [cellArray addObject:[[tempDataArray objectAtIndex:i] objectForKey:@"content"]];
        [tableViewDic setObject:cellArray forKey:@"cell"];
        [cellArray release];
        [_dataArray addObject:tableViewDic];
        [tableViewDic release];
    }
    [tempDataArray release];
    lastHitSection = [_dataArray count] - 1;
    [self collapseOrExpand:[_dataArray count] - 1];
    [_tableView reloadData];
}

-(void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError
{
    [_ppMBProgressHUD setLabelText:@"网络异常,请尝试刷新"];
    NSString *string = [paramError localizedDescription];
    if (PP_ISNSLOG) {
        NSLog(@"ppHttpResponseDidFailWithErrorCallBack-%@",string);
    }
    [_ppMBProgressHUD hide:YES afterDelay:1];
}

#pragma mark - dealloc -

-(void)dealloc{

    NSLog(@"help dealloc");
    [_dataArray release];
    _dataArray = nil;
    [super dealloc];
}


@end

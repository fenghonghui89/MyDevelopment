//
//  PPCenterView.m
//  PPUserUIKit
//
//  Created by seven  mr on 1/23/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//
#import "PPAppPlatformKit.h"
#import "PPCenterView.h"
#import "PPAppPlatformKit.h"
#import "PPUpdatePassWordView.h"
#import "PPLoginView.h"
#import "PPWebView.h"
#import "PPRegisterView.h"
#import "PPExchange.h"
#import "PPAlertView.h"
#import "PPCommon.h"
#import "PPRechargeRecordView.h"
#import "PPSpendingRecordView.h"
#import "PPHelpView.h"
#import "PPPasswordProtectionView.h"
#import "PPNoticeListView.h"


@implementation PPCenterView



-(id)init{
    self = [super init];
    if (self) {
        [_titleLabel setText:@"帐号信息"];
        [self.verticalLineLeftView setHidden:YES];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleUserCenter"]];
        
        
        _centerTableView = [[UITableView alloc]init];
        [_centerTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        [_centerTableView setContentOffset:CGPointMake(0, 50) animated:YES];
        [_centerTableView setDelegate:self];
        [_centerTableView setDataSource:self];
        [_centerTableView setShowsVerticalScrollIndicator:YES];
        _centerTableView.backgroundColor=[PPCommon getColor:@"f0eff3"];

        [_bgImageView addSubview:_centerTableView];
        [_centerTableView release];
        
        [self initVerticalFrame];
    }
    return self;
}

#pragma mark - 设备旋转 调整视图的位置和尺寸 -

-(void)initVerticalFrame{
    [super initVerticalFrame];

    [_centerTableView setFrame:CGRectMake(0, 51, _bgImageView.frame.size.width, _bgImageView.frame.size.height - 51)];
    //PP中心表格所有cell加起来的长度是501，这里设置滚动条可以滚动的范围总共是520
    [_centerTableView setContentSize:CGSizeMake(_bgImageView.frame.size.width, 500)];

}

-(void)initHorizontalFrame{
    [super initHorizontalFrame];
    [_centerTableView setFrame:CGRectMake(0, 51, _bgImageView.frame.size.width , _bgImageView.frame.size.height - 51)];
    [_centerTableView setContentSize:CGSizeMake(_bgImageView.frame.size.width, 500)];

}

#pragma mark - UITableViewDataSource, UITableViewDelegate -
//设置组别个数
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    //    UI_SCREEN_HEIGHT
    return  1;
}
//设置每个组别中cell的个数
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}



//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 7)
    {
        return 35;

    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArray = [NSArray arrayWithObjects:@"",@"用户名",@"PP币",@"",@"修改密码",@"密保管理",@"消息中心",@"",
                           @"充值",@"充值记录",@"消费记录",@"帮助",nil];
    
    PPCenterTableViewCell *cell;
    static NSString *cellid1 = @"CELLd1";
    cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
    int rowNumber=indexPath.row;
    
    if (!cell) {
        
        if (indexPath.row==0||indexPath.row==1||indexPath.row==2||indexPath.row==3||indexPath.row==7){
            
           cell = [[[PPCenterTableViewCell alloc] initWithLabelType] autorelease];
            
            if(cell){
                if (rowNumber==0||indexPath.row==3||indexPath.row==7) {
//                    [cell setBackgroundColor:[PPCommon getColor:@"f0eff3"]];
//                    [cell.contentView setBackgroundColor:[PPCommon getColor:@"f0eff3"]];
                    
                    [cell.titleLabel setText:@""];
                    [cell.valueLabel setText:@""];
                    [cell.actionButton setTitle:@"" forState:UIControlStateNormal];
                    cell.tag = 3;
                }
                else if(rowNumber == 1){
                    NSString *username=[[PPAppPlatformKit sharedInstance]currentUserName];
                    [cell.titleLabel setText:@"用户名"];
                    if(username == nil){
                        username = @"尚未登录";
                    }
                    [cell.valueLabel setText:username];
                    [cell.valueLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
                    [cell.actionButton setTitle:@"    注销" forState:UIControlStateNormal];
                    cell.actionButton.tag=1;
                    cell.tag=1;
                    [cell.actionButton addTarget:self action:@selector(myButton:) forControlEvents:UIControlEventTouchUpInside];
                }
                else if(rowNumber==2){
                    [cell.titleLabel setText:@"PP币"];
                    [cell.valueLabel setText:[NSString stringWithFormat:@"%11.2f", balance]];
                    [cell.valueLabel setTextColor:[PPCommon getColor:@"7f7f7f"]];
                    [cell.actionButton setTitle:@"    充值" forState:UIControlStateNormal];
                    cell.actionButton.tag=0;
                    cell.tag=0;
                    [cell.actionButton addTarget:self action:@selector(myButton:) forControlEvents:UIControlEventTouchUpInside];
                }
            }

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else{
            NSString *imageName;
            int tagOfcell=2;
            switch (rowNumber) {
                    
                case 4:
                    imageName=@"changePassword";
                    break;
                case 5:
                    imageName=@"passportManagement";
                    break;
                case 6:
                    tagOfcell=0;
                    imageName=@"bbs";
                    break;
                case 8:
                    imageName=@"recharge";
                    break;
                case 9:
                    imageName=@"rechargeRecord";
                    break;
                case 10:
                    imageName=@"spendingRecord";
                    break;
                case 11:
                    tagOfcell=0;
                    imageName=@"help";
                    break;
                default:
                    imageName=@"ppcenter";
                    break;
            }
            
            cell = [[[PPCenterTableViewCell alloc] initWithDefaultType] autorelease];
            cell.tag=tagOfcell;
            [[cell titleLabel] setText:[titleArray objectAtIndex:indexPath.row]];
            [cell.titleIamgeView setImage:[PPUIKit setLocaImage:imageName] ];

        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *price = @"10";
    price = [NSString stringWithFormat:@"%d",[[PPAppPlatformKit sharedInstance] getRechargeAmout]];

    switch (indexPath.row)
    {
        case 4://修改密码
            [self hiddenCenterViewInLeft];
            [self updatePassWordButtonPressdown];
            break;
        case 5://密保管理
            [self hiddenCenterViewInLeft];
            PPPasswordProtectionView *ppPasswordProtectionView = [[PPPasswordProtectionView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppPasswordProtectionView atIndex:1002];
            [ppPasswordProtectionView showPasswordProtectionViewByRight];
            [ppPasswordProtectionView release];

            break;
        case 6: //消息中心
            [self hiddenCenterViewInLeft];
//            [[PPNoticeListView sharedInstance] setPageType:PageTypeOfNoti];
            [[PPNoticeListView sharedInstance] setPageType:PageTypeOfEmail];
            [[PPNoticeListView sharedInstance] showPPNoticeListViewByRight];
//            [[PPNoticeListView sharedInstance] segButtonTouchUpInside:[[PPNoticeListView sharedInstance] emailButton]];
            break;
        case 8: //充值
            [self hiddenCenterViewInLeft];
            PPWebView *ppWebView = [[PPWebView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
            [ppWebView rechargeWebShow:price];
            [[ppWebView backButton] setHidden:NO];
            [[ppWebView verticalLineLeftView] setHidden:NO];
            [ppWebView release];
            break;
        case 9://充值记录
            [self hiddenCenterViewInLeft];
            
            PPRechargeRecordView *ppRechargeRecordView = [[PPRechargeRecordView alloc] init] ;
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppRechargeRecordView atIndex:1001];
            [ppRechargeRecordView showRechargeRecordViewByRight];
            [ppRechargeRecordView release];
            break;
        case 10://消费记录
            [self hiddenCenterViewInLeft];
            PPSpendingRecordView *ppSpendingRecordView = [[PPSpendingRecordView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppSpendingRecordView atIndex:1001];
            [ppSpendingRecordView showSpendingRecordViewByRight];
            [ppSpendingRecordView release];
            break;
        case 11:
            //帮助中心
            [self hiddenCenterViewInLeft];
            PPHelpView *ppHelpView = [[PPHelpView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppHelpView atIndex:1002];
            [ppHelpView showViewByRight];
            [ppHelpView release];
            break;
        default:
            break;
    }

}


#pragma mark  - 修改密码，注销并显示登录 ，关闭视图 -

/**
 *  进入修改密码
 */
-(void)updatePassWordButtonPressdown{
    if ([[PPAppPlatformKit sharedInstance] isOneKeyLogin]) {
        if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
          
            [self alertViewNeedBind];
        }else{
            PPUpdatePasswordView *ppUpdatePassWordView = [[PPUpdatePasswordView alloc] init];
            [[[UIApplication sharedApplication] keyWindow] insertSubview:ppUpdatePassWordView atIndex:1001];
            [ppUpdatePassWordView showUpdatePassWordViewByRight];
            [ppUpdatePassWordView release];
            
        }
    }else{
        PPUpdatePasswordView *ppUpdatePassWordView = [[PPUpdatePasswordView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppUpdatePassWordView atIndex:1001];
        [ppUpdatePassWordView showUpdatePassWordViewByRight];
        [ppUpdatePassWordView release];
    }
    
}

-(void)logoffActiveUserButtonPressdown{
    [[PPAppPlatformKit sharedInstance] PPlogout];
    [[[PPAppPlatformKit sharedInstance] delegate] ppLogOffCallBack];
    [self hiddenCenterViewInRight];
    
    if ([[PPAppPlatformKit sharedInstance] isLogOutPushLoginView]) {
        [self performSelector:@selector(pushLoginView) withObject:nil afterDelay:0.7];
    }
}



-(void)pushLoginView{
    PPLoginView *ppLoginView = [[PPLoginView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppLoginView atIndex:1002];
    [ppLoginView showLoginViewByRight];
    [ppLoginView release];
}



-(void)closeButtonPressed{
    [super closeButtonPressed];
}


#pragma mark  - 视图显示，隐藏，消失 -
//消失到右边
-(void)hiddenCenterViewInRight
{
    [super hiddenViewInRight];
}


//消失到左边
-(void)hiddenCenterViewInLeft
{

    [super hiddenViewInLeft];
}


/// <summary>
/// 用户中心从右边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showCenterViewByRight
{
    PPWebViewData *pp = [[PPWebViewData alloc] init];
    [pp setDelegate:self];
    [pp ppPPMoneyRequest];
    [pp release];
    [userNameText setText:[[PPAppPlatformKit sharedInstance] currentShowUserName]];
    if ([userNameText text] == nil || ![[userNameText text] length]) {
        [userNameText setText:@"尚未登录"];
    }
    
    [super showViewByRight];
}


/// <summary>
/// 用户中心从左边展示
/// </summary>
/// <returns>无返回</returns>
-(void)showCenterViewByLeft
{
    PPWebViewData *pp = [[PPWebViewData alloc] init];
    [pp setDelegate:self];
    [pp ppPPMoneyRequest];
    [pp release];
    [userNameText setText:[[PPAppPlatformKit sharedInstance] currentShowUserName]];
    
    if ([userNameText text] == nil || ![[userNameText text] length]) {
        [userNameText setText:@"尚未登录"];
    }
    
    [super showViewByLeft];
}

-(void)didHiddenView
{
    [super didHiddenView];
    
}

#pragma mark - 余额回调 -

-(void)balanceCallBack:(NSDictionary *)paramDic
{
    if ([[paramDic objectForKey:@"error"] intValue] == 0) {
        NSString *balanceStr = [[paramDic objectForKey:@"data"] objectForKey:@"ppmoney"];
        balance = [balanceStr doubleValue];
        [_centerTableView reloadData];
        if (PP_ISNSLOG) {
            NSLog(@"异步获取余额回调-返回%11.2f",balance);
        }
    }

}


#pragma mark - Dealloc -

- (void)dealloc
{
    [super dealloc];
}
#pragma mark - 过期方法 -
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 20)];
//    view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
//    return [view autorelease];
//}


-(void)bindUserInfoButtonPressdown{
    [self hiddenCenterViewInLeft];
    PPRegisterView *ppRegisterView = [[PPRegisterView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:ppRegisterView atIndex:1002];
    [ppRegisterView release];
}


//-(void)userInfoProvingButtonPressdown{
//    if ([[PPAppPlatformKit sharedInstance] isOneKeyLogin]) {
//        if ([[PPAppPlatformKit sharedInstance] isNeedBind]) {
//            [self alertViewNeedBind];
//        }else{
//            [[PPWebView sharedInstance] userInfoSecurityWebShow];
//        }
//    }else{
//        [[PPWebView sharedInstance] userInfoSecurityWebShow];
//    }
//}

- (void)myButton:(UIButton *)sender{
    
    if (sender.tag == 0) {
        [self hiddenCenterViewInLeft];
        NSString *price = @"10";
        price = [NSString stringWithFormat:@"%d",[[PPAppPlatformKit sharedInstance] getRechargeAmout]];
        PPWebView *ppWebView = [[PPWebView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
        [ppWebView rechargeWebShow:price];
        [[ppWebView backButton] setHidden:NO];
        [[ppWebView verticalLineLeftView] setHidden:NO];
        [ppWebView release];
        
        
        
        
    }else if (sender.tag == 1){
        [self logoffActiveUserButtonPressdown];
    }
    
}

//-(void)didShowView
//{
//    balance = [self getBalance];
//}

//#pragma mark  - HyperlinkLabelDelegate delegate methods -
//-(void)myLabel:(PPHyperlinkLabel *)paramLabel{
//    if (paramLabel.tag == 0) {
//        [self hiddenCenterViewInLeft];
//        NSString *price = @"10";
//        price = [NSString stringWithFormat:@"%d",[[PPAppPlatformKit sharedInstance] getRechargeAmout]];
//        PPWebView *ppWebView = [[PPWebView alloc] init];
//        [[[UIApplication sharedApplication] keyWindow] addSubview:ppWebView];
//        [ppWebView rechargeWebShow:price];
//        [[ppWebView backButton] setHidden:NO];
//        [[ppWebView verticalLineLeftView] setHidden:NO];
//        [ppWebView release];
//
//
//
//
//    }else if (paramLabel.tag == 1){
//        [self logoffActiveUserButtonPressdown];
//    }
//}


-(void)alertViewNeedBind{
    //    UAlertView *alertView = [[UAlertView alloc] initWithTitle:[[PPAppPlatformKit sharedInstance] currentAddress]
    //                                                        message:@"您现在的为临时会员。此功能为正式会员提供.绑定后一键登录功能保留。两种方式登录任你选择" delegate:self
    //                                              cancelButtonTitle:@"取消" otherButtonTitles:@"去绑定", nil];
    //    [alertView show];
    //    [alertView release];
}


- (void)goBBSButtonPressdown{
    //    [[PPWebView sharedInstance] goBBS];
}
@end

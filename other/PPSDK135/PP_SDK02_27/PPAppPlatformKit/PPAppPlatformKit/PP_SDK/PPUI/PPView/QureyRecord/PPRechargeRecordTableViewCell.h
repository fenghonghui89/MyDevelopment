//
//  PPRechargeRecordTableViewCell.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-9.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPRechargeRecordTableViewCell : UITableViewCell



//充值记录查询结果数据显示的label
@property(nonatomic,retain) UILabel *timeLabel;

@property(nonatomic,retain) UILabel *orderIdLabel;

@property(nonatomic,retain) UILabel *rechargeAmountLabel;

@property(nonatomic,retain) UILabel *arrivedAmountLabel;

@property(nonatomic,retain) UILabel *rechargeTypeLabel;

@property(nonatomic,retain) UILabel *rechargeStatusLabel;

@end

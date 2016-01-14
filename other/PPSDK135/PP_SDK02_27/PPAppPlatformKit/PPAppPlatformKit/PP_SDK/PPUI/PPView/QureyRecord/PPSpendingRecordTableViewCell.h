//
//  SpendingRecordTableViewCell.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-20.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPSpendingRecordTableViewCell : UITableViewCell

//消费记录查询结果数据显示的label
@property(nonatomic,retain) UILabel *timeLabel;

@property(nonatomic,retain) UILabel *orderIdLabel;

@property(nonatomic,retain) UILabel *spendingAmountLabel;

@property(nonatomic,retain) UILabel *gameNameLabel;

@property(nonatomic,retain) UILabel *orderStatusLabel;

@end

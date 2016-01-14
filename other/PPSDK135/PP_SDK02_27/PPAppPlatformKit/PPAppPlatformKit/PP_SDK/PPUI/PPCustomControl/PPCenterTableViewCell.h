//
//  PPCenterTableViewCell.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-9-27.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPHyperlinkLabel.h"

@interface PPCenterTableViewCell : UITableViewCell

@property(nonatomic, retain) UIImageView *titleIamgeView;

@property(nonatomic, retain) UILabel *titleLabel;

@property(nonatomic, retain) UIImageView *actionImageView;

@property(nonatomic, retain) UILabel *valueLabel;

@property(nonatomic, retain) UILabel *tintLabel;

@property(nonatomic, retain) UIButton *actionButton;

-(id)initWithDefaultType;

-(id)initWithLabelType;


@end

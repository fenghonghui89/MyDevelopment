//
//  RMPersonTableViewCell.h
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2013-05-13.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMSwipeTableViewCell.h"


@interface RMPersonTableViewCell : RMSwipeTableViewCell

//已读未读小图标
@property (nonatomic, strong) UIImageView *profileImageView;
@property (nonatomic, strong) UIImageView *checkmarkGreyImageView;
@property (nonatomic, strong) UIImageView *checkmarkGreenImageView;
@property (nonatomic, strong) UIImageView *deleteGreyImageView;
@property (nonatomic, strong) UIImageView *deleteRedImageView;
@property (nonatomic, assign) BOOL isFavourite;
@property (nonatomic, assign, getter = isChecked) BOOL checked;

@property (nonatomic, assign) int messageId;
@property (nonatomic, assign) int sendTime;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *detailLabel;
@property (nonatomic, retain) UILabel *senderLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *checkedMarkImageView;

-(void)setThumbnail:(UIImage*)image;
-(void)setFavourite:(BOOL)favourite animated:(BOOL)animated;

//-(void)setStatuEditing:(BOOL)editing animated:(BOOL)animated;

@end

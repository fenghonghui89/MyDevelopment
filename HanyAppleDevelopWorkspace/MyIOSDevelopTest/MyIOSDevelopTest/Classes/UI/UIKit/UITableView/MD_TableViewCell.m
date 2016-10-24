//
//  MD_TableViewCell.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
/*
 系统默认cell的label和imageview的frame不能改变，如要改变要用自定义cell，且在layoutSubViews里面定义
 */

#import "MD_TableViewCell.h"

@implementation MD_TableViewCell

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end

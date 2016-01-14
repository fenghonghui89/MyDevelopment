//
//  UserNameCell.h
//  PPUserUIKit
//
//  Created by seven  mr on 1/16/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PPUserNameCell : UITableViewCell
{
    
}

@property (nonatomic, retain) UILabel *cellUserLabel;
@property (nonatomic, retain) UIButton *cellDelButton;

+ (UIColor *)getColor:(NSString *)hexColor;
@end


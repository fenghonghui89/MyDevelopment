//
//  UserNameCell.m
//  PPUserUIKit
//
//  Created by seven  mr on 1/16/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPUserNameCell.h"
#import "PPUIKit.h"
@interface PPUserNameCell ()

@end


@implementation PPUserNameCell

@synthesize cellUserLabel;
@synthesize cellDelButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cellUserLabel = [[UILabel alloc] initWithFrame:CGRectMake(99, 0, 180, 44)];
        [cellUserLabel setFont:[UIFont systemFontOfSize:14]];
        [cellUserLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:cellUserLabel];
        [cellUserLabel release];
        
        cellDelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cellDelButton setImage:[PPUIKit setLocaImage:@"PPTableViewCellDel"]
                       forState:UIControlStateNormal];
        [cellDelButton setImageEdgeInsets:UIEdgeInsetsMake(8, 13, 8, 13)];

        
        [cellDelButton setFrame:CGRectMake(0, 2, 50, 40)];
        [self addSubview:cellDelButton];
        

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        
    }else{
        UIImageView *cellBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 260, 44)];
        [cellBGView setBackgroundColor:[PPUserNameCell getColor:@"f7f7f7"]];
        [self setBackgroundView:cellBGView];
        [cellBGView release];
    }
    
}

-(void)dealloc
{
    [super dealloc];
}


+ (UIColor *)getColor:(NSString *)hexColor {
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

@end

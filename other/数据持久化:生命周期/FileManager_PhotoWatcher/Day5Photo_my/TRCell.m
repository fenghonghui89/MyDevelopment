//
//  TRCell.m
//  Day5Photo_my
//
//  Created by HanyFeng on 13-12-10.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRCell.h"

@implementation TRCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)setAlbum:(TRAlbum *)album
{
    _album = album;
    self.mainLabel.text = self.album.name;
    self.subLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.album.imagePaths.count];
    self.myImageView.image = [UIImage imageWithContentsOfFile:self.album.imagePaths[0]];
}

//显示的时候view布局子view，当控件显示的时候调用（如果没有该方法，显示会有异常；里面可以不写语句）
-(void)layoutSubviews
{
    self.myImageView.clipsToBounds = YES;//超出自身显示范围的内容不显示（YES）
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

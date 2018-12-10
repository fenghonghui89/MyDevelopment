//
//  WeiBoTableViewCell.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-2.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "WeiBoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "WeiboContentView.h"
@interface WeiBoTableViewCell()
@property(nonatomic,retain)UIImageView *headerIV;
@property(nonatomic,retain)UILabel *userNameLabel;
@property(nonatomic,retain)UILabel *createdTimeLabel;
@property(nonatomic,retain)UILabel *sourceLabel;
@property(nonatomic,retain)UILabel *repostsCountLabel;
@property(nonatomic,retain)UILabel *commentsCountLabel;
@property(nonatomic,retain)WeiboContentView *weiboContentView;

@property(nonatomic,retain)UIImageView *repostsCountIV;
@property(nonatomic,retain)UIImageView *commentsCountIV;
@property(nonatomic,retain)UIButton *actionBtn;

@end



@implementation WeiBoTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

-(id)init
{
    if (self = [super init]){
        [self setBackgroundColor:[UIColor purpleColor]];
        
        //头像
        UIImageView *headerIV = [[UIImageView alloc] init];
        [headerIV setBackgroundColor:[UIColor greenColor]];
        [headerIV.layer setCornerRadius:10.0];
        [headerIV.layer setBorderWidth:1.0];
        [headerIV.layer setBorderColor:[UIColor redColor].CGColor];
        [headerIV.layer setMasksToBounds:YES];
        [self addSubview:headerIV];
        self.headerIV = headerIV;
        [headerIV release];
        
        //用户名
        UILabel *userNameLabel = [[UILabel alloc] init];
        [userNameLabel setBackgroundColor:[UIColor greenColor]];
        [userNameLabel setTextColor:[UIColor redColor]];
        [userNameLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:userNameLabel];
        self.userNameLabel = userNameLabel;
        [userNameLabel release];
        
        //创建时间
        UILabel *createdTimeLabel = [[UILabel alloc] init];
        [createdTimeLabel setBackgroundColor:[UIColor greenColor]];
        [createdTimeLabel setTextColor:[UIColor redColor]];
        [createdTimeLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:createdTimeLabel];
        self.createdTimeLabel = createdTimeLabel;
        [createdTimeLabel release];
        
        //转发数旁边的图标
        UIImageView *repostsCountIV = [[UIImageView alloc] init];
        [repostsCountIV setBackgroundColor:[UIColor redColor]];
        [self addSubview:repostsCountIV];
        self.repostsCountIV = repostsCountIV;
        [repostsCountIV release];
        
        //评论数旁边的图标
        UIImageView *commentsCountIV = [[UIImageView alloc] init];
        [commentsCountIV setBackgroundColor:[UIColor redColor]];
        [self addSubview:commentsCountIV];
        self.commentsCountIV = commentsCountIV;
        [commentsCountIV release];
        
        //转发数label
        UILabel *repostsCountLabel = [[UILabel alloc] init];
        [repostsCountLabel setBackgroundColor:[UIColor greenColor]];
        [repostsCountLabel setTextColor:[UIColor redColor]];
        [repostsCountLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:repostsCountLabel];
        self.repostsCountLabel = repostsCountLabel;
        [repostsCountLabel release];
        
        //评论数label
        UILabel *commentsCountLabel = [[UILabel alloc] init];
        [commentsCountLabel setBackgroundColor:[UIColor greenColor]];
        [commentsCountLabel setTextColor:[UIColor redColor]];
        [commentsCountLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:commentsCountLabel];
        self.commentsCountLabel = commentsCountLabel;
        [commentsCountLabel release];
        
        //按钮
        UIButton *actionBtn = [[UIButton alloc] init];
        [actionBtn setBackgroundColor:[UIColor redColor]];
        [self addSubview:actionBtn];
        self.actionBtn = actionBtn;
        [actionBtn release];
        
        //内容view
        WeiboContentView *weiboContentView = [[WeiboContentView alloc] init];
        [self addSubview:weiboContentView];
        self.weiboContentView = weiboContentView;
        [weiboContentView release];
        
        //微博来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        [sourceLabel setBackgroundColor:[UIColor greenColor]];
        [sourceLabel setTextColor:[UIColor redColor]];
        [sourceLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        [sourceLabel release];
    }
    
    return self;
}

-(void)setWeibo:(Weibo *)weibo
{
    if (_weibo != weibo) {
        [_weibo release];
        _weibo = [weibo retain];
        
        _weiboContentView.weibo = _weibo;
        [self initFrame];
    }
}

-(void)initFrame
{
    [self.headerIV setFrame:CGRectMake(5, 5, 50, 50)];
    [self.userNameLabel setFrame:CGRectMake(_headerIV.frame.origin.x + _headerIV.frame.size.width + 4, 5, 120, 20)];
    [self.createdTimeLabel setFrame:CGRectMake(UIScreen_Width - 5 - 123, 5, 123, 20)];
    
    float weiboContentViewHeight = [self.weiboContentView getWeiboContentViewHeight];
    [self.weiboContentView setFrame:CGRectMake(59, 30, 256,weiboContentViewHeight)];
    
    float height = self.weiboContentView.frame.origin.y + weiboContentViewHeight;
    [self.sourceLabel setFrame:CGRectMake(5, height+5, 100, 20)];
    [self.repostsCountIV setFrame:CGRectMake(143, height+5, 20, 20)];
    [self.repostsCountLabel setFrame:CGRectMake(163, height+5, 29, 20)];
    [self.commentsCountIV setFrame:CGRectMake(217, height+5, 20, 20)];
    [self.commentsCountLabel setFrame:CGRectMake(236, height+5, 29, 20)];
    [self.actionBtn setFrame:CGRectMake(UIScreen_Width - 5 - 30, height+5, 30, 20)];
}

//每点一次cell都会触发
-(void)layoutSubviews
{
    __block UIActivityIndicatorView *activityIndicator = nil;
    NSURL *imageURL = [NSURL URLWithString:self.weibo.weiboUserInfo.profile_image_url];
    [self.headerIV sd_setImageWithURL:imageURL placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (!activityIndicator) {
            [self.headerIV addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
            activityIndicator.center = self.headerIV.center;
            [activityIndicator startAnimating];
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
    }];
    
    [_userNameLabel setText:self.weibo.weiboUserInfo.screen_name];
    [_createdTimeLabel setText:[self getDateByDateString:self.weibo.created_at]];
    [_repostsCountLabel setText:[NSString stringWithFormat:@"%d",[self.weibo.reposts_count intValue]]];
    [_commentsCountLabel setText:[NSString stringWithFormat:@"%d",[self.weibo.comments_count intValue]]];
    [_sourceLabel setText:self.weibo.source];
}

-(NSString *)getDateByDateString:(NSString *)paramDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E MMM d HH:mm:ss Z yyyy"];
    NSDate *date = [dateFormatter dateFromString:paramDateStr];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

//每点一次cell都会触发
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

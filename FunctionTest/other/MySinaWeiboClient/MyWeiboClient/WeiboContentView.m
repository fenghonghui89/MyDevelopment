//
//  WeiboContentView.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-3.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "WeiboContentView.h"
#import "RTLabel.h"
#import "UIViewExt.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "WeiBoParser.h"
@interface WeiboContentView()<RTLabelDelegate>
@property(nonatomic,retain)RTLabel *mainTextRTLabel;//文字内容
@property(nonatomic,retain)RTLabel *retweetedTextRTLabel;//转发的文字内容
@property(nonatomic,retain)UILabel *repostsCountLabel;//转发数
@property(nonatomic,retain)UILabel *commentsCountLabel;//评论数
@property(nonatomic,retain)UIView *retweetedBGView;

@end

@implementation WeiboContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setWeibo:(Weibo *)weibo
{
    if (_weibo != weibo) {
        [_weibo release];
        _weibo = [weibo retain];
        
        [self initUI];
        [self initFrame];
    }
}

-(void)initUI
{
    [self setBackgroundColor:[UIColor orangeColor]];
    
    RTLabel *mainTextRTLabel = [[RTLabel alloc] init];
    [mainTextRTLabel setFont:[UIFont systemFontOfSize:14]];
    [mainTextRTLabel setTextColor:[UIColor blackColor]];
    [mainTextRTLabel setBackgroundColor:[UIColor whiteColor]];
    [mainTextRTLabel setDelegate:self];
    [mainTextRTLabel setTag:1];
    [mainTextRTLabel setLinkAttributes:[NSDictionary dictionaryWithObject:@"blue" forKey:@"color"]];
    [mainTextRTLabel setSelectedLinkAttributes:[NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"]];
    [self addSubview:mainTextRTLabel];
    self.mainTextRTLabel = mainTextRTLabel;
    [mainTextRTLabel release];
    
    //如果是转发的微博
    if (_weibo.retweeted_status) {
        
        UIView *retweetedBGView = [[UIView alloc] init];
        [retweetedBGView setBackgroundColor:[UIColor brownColor]];
        [self addSubview:retweetedBGView];
        self.retweetedBGView = retweetedBGView;
        [retweetedBGView release];
        
        RTLabel *retweetedTextRTLabel = [[RTLabel alloc] init];
        [retweetedTextRTLabel setFont:[UIFont systemFontOfSize:13]];
        [retweetedTextRTLabel setTextColor:[UIColor blackColor]];
        [retweetedTextRTLabel setBackgroundColor:[UIColor whiteColor]];
        [retweetedTextRTLabel setDelegate:self];
        [retweetedTextRTLabel setTag:1];
        [retweetedTextRTLabel setLinkAttributes:[NSDictionary dictionaryWithObject:@"blue" forKey:@"color"]];
        [retweetedTextRTLabel setSelectedLinkAttributes:[NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"]];
        [_retweetedBGView addSubview:retweetedTextRTLabel];
        self.retweetedTextRTLabel = retweetedTextRTLabel;
        [retweetedTextRTLabel release];
        
        UILabel *repostsCountLabel = [[UILabel alloc] init];
        [repostsCountLabel setBackgroundColor:[UIColor whiteColor]];
        [repostsCountLabel setTextColor:[UIColor blackColor]];
        [repostsCountLabel setFont:[UIFont systemFontOfSize:12]];
        [_retweetedBGView addSubview:repostsCountLabel];
        self.repostsCountLabel = repostsCountLabel;
        [repostsCountLabel release];
        
        UILabel *commentsCountLabel = [[UILabel alloc] init];
        [commentsCountLabel setBackgroundColor:[UIColor whiteColor]];
        [commentsCountLabel setTextColor:[UIColor blackColor]];
        [commentsCountLabel setFont:[UIFont systemFontOfSize:12]];
        [_retweetedBGView addSubview:commentsCountLabel];
        self.commentsCountLabel = commentsCountLabel;
        [commentsCountLabel release];
    }
}

-(void)initFrame
{
    //原微博的text
    float mainTextHeight = [HFCommon getTextHeightWithFontSize:14 andWidth:256 andText:_weibo.text];
    [_mainTextRTLabel setFrame:CGRectMake(0,0,256,mainTextHeight)];

    if (!_weibo.retweeted_status) {//如果不是是转发微博
        float picsHeight = 0;
        if (_weibo.pic_urls) {//如果含有图片
            
            float height = _mainTextRTLabel.frame.origin.y + _mainTextRTLabel.frame.size.height;
            int picsCount = _weibo.pic_urls.count;
            for (int i = 0; i < picsCount; i++) {
                UIImageView *pic = [[UIImageView alloc] init];
                [pic setContentMode:UIViewContentModeScaleAspectFit];
                [pic setClipsToBounds:YES];
                [pic setBackgroundColor:[UIColor cyanColor]];
                [pic sd_setImageWithURL:_weibo.pic_urls[i]];
                [pic setFrame:CGRectMake(i%3*80+(i%3+1)*4,height+i/3*80+(i/3+1)*4, 80, 80)];
                [self addSubview:pic];
            }
            picsHeight = (picsCount/3 + (picsCount%3==0?0:1))*80 + (picsCount/3 + (picsCount%3==0?0:1) -1)*4;
        }
        [self setFrame:CGRectMake(0, 0, 256, mainTextHeight+4+picsHeight)];
        
        
    }else{//如果是转发的微博
        
        //被转发微博的text
        NSString *retText = [NSString stringWithFormat:@"@%@:%@",_weibo.retweeted_status.weiboUserInfo.screen_name,_weibo.retweeted_status.text];
        float retTextHeight = [HFCommon getTextHeightWithFontSize:13 andWidth:248 andText:retText];
        [_retweetedTextRTLabel setFrame:CGRectMake(0,0, 248, retTextHeight)];
        
        //被转发微博的转发数、评论数label
        float height1 = _retweetedTextRTLabel.frame.origin.y + _retweetedTextRTLabel.frame.size.height;
        [_repostsCountLabel setFrame:CGRectMake(0, height1 + 4, 75, 20)];
        [_commentsCountLabel setFrame:CGRectMake(_repostsCountLabel.frame.origin.x +_repostsCountLabel.frame.size.width + 4, height1 + 4, 75, 20)];
        float retCountLabelHeight = _repostsCountLabel.frame.size.height;
        
        //被转发微博的图片（如果存在）
        float picsHeight = 0;
        if (_weibo.retweeted_status.pic_urls) {
            float height2 = _repostsCountLabel.frame.origin.y + _repostsCountLabel.frame.size.height;
            int picsCount = _weibo.retweeted_status.pic_urls.count;
            for (int i = 0; i < picsCount; i++) {
                UIImageView *pic = [[UIImageView alloc] init];
                [pic sd_setImageWithURL:_weibo.retweeted_status.pic_urls[i]];
                [pic setBackgroundColor:[UIColor cyanColor]];
                [pic setContentMode:UIViewContentModeScaleAspectFit];
                [pic setClipsToBounds:YES];
                [pic setFrame:CGRectMake(_retweetedTextRTLabel.frame.origin.x+i%3*70+(i%3+1)*4, height2+i/3*70+(i/3+1)*4, 70, 70)];
                [self.retweetedBGView addSubview:pic];
            }
            picsHeight = (picsCount/3 + (picsCount%3==0?0:1))*70 + (picsCount/3 + (picsCount%3==0?0:1) -1)*4;
        }
        
        //被转发微博的底图
        [_retweetedBGView setFrame:CGRectMake(4, _mainTextRTLabel.frame.origin.y +_mainTextRTLabel.frame.size.height+4, 248, retTextHeight+4+retCountLabelHeight+4+picsHeight)];
        float retBGViewHeight = _retweetedBGView.frame.size.height;
        
        [self setFrame:CGRectMake(0, 0, 256,mainTextHeight + 4 + retBGViewHeight)];
    }
}

-(void)layoutSubviews
{
    [_mainTextRTLabel setText:[WeiBoParser parseLink:_weibo.text]];
    
    NSString *retText = [NSString stringWithFormat:@"@%@:%@",_weibo.retweeted_status.weiboUserInfo.screen_name,_weibo.retweeted_status.text];
    [_retweetedTextRTLabel setText:[WeiBoParser parseLink:retText]];
    
    [_repostsCountLabel setText:[NSString stringWithFormat:@"转发数(%d)",[_weibo.retweeted_status.reposts_count intValue]]];
    [_commentsCountLabel setText:[NSString stringWithFormat:@"评论数(%d)",[_weibo.retweeted_status.comments_count intValue]]];
}

-(float)getWeiboContentViewHeight
{
    return self.frame.size.height;
}

-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url
{
    NSString *hostStr = [url host];
    NSString *absoluteStr = [url absoluteString];
    NSLog(@"%@--%@",hostStr,absoluteStr);
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

//
//  PPMailContentView.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-12-2.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPNoticeContentView.h"
#import "PPNoticeListView.h"
#import "PPCommon.h"

@implementation PPNoticeContentView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        [_titleLabel setText:@"邮件详情"];
        [self.verticalLineLeftView setHidden:NO];
        [self.backButton setHidden:NO];
        [_titleImage setImage:[PPUIKit setLocaImage:@"PPTitleMessage"]];
        [_bgImageView setBackgroundColor:[UIColor whiteColor]];
        [self setBackgroundColor:[UIColor clearColor]];
        
        _mailTitleLabel = [[UILabel alloc] init];
        [_mailTitleLabel setTextColor:[PPCommon getColor:@"444444"]];
        [_mailTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [_mailTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_mailTitleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        _mailTitleLabel.numberOfLines = 0;
        [_bgImageView addSubview:_mailTitleLabel];
        [_mailTitleLabel release];
        
        
        _mailSenderLabel = [[UILabel alloc] init];
        [_mailSenderLabel setTextColor:[PPCommon getColor:@"007aff"]];
        [_mailSenderLabel setFont:[UIFont systemFontOfSize:12]];
        [_mailSenderLabel setBackgroundColor:[UIColor clearColor]];
        [_bgImageView addSubview:_mailSenderLabel];
        [_mailSenderLabel release];

        
        _mailDateLabel = [[UILabel alloc] init];
        [_mailDateLabel setTextColor:[PPCommon getColor:@"999999"]];
        [_mailDateLabel setFont:[UIFont systemFontOfSize:11]];
        [_mailDateLabel setBackgroundColor:[UIColor clearColor]];
        [_bgImageView addSubview:_mailDateLabel];
        [_mailDateLabel release];
        
        _mailContentTextView = [[UITextView alloc] init];
        [_mailContentTextView setEditable:NO];
        
        _mailContentTextView.dataDetectorTypes =UIDataDetectorTypeAll;
 
        [_mailContentTextView setTextColor:[PPCommon getColor:@"444444"]];
        [_mailContentTextView setFont:[UIFont systemFontOfSize:14]];
        [_bgImageView addSubview:_mailContentTextView];
        [_mailContentTextView release];
        
        
        _mailHorizontalLineView = [[UIImageView alloc] init];
        [_mailHorizontalLineView setImage:[PPUIKit setLocaImage:@"PPHorizontalLine"]];
        _mailHorizontalLineView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_bgImageView addSubview:_mailHorizontalLineView];
        [_mailHorizontalLineView release];
    }
    return self;
}

- (void)initVerticalFrame
{
    [super initVerticalFrame];
    
    CGSize mailTitleLabelSize = [_mailTitleLabel.text sizeWithFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]
                                              constrainedToSize:CGSizeMake(_bgImageView.frame.size.width - 32, MAXFLOAT)
                                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    [_mailTitleLabel setFrame:CGRectMake(16, 65, _bgImageView.frame.size.width - 32, mailTitleLabelSize.height)];
    [_mailSenderLabel setFrame:CGRectMake(16, _mailTitleLabel.frame.origin.y + _mailTitleLabel.frame.size.height + 8, _bgImageView.frame.size.width, 13)];
    [_mailDateLabel setFrame:CGRectMake(16, _mailSenderLabel.frame.origin.y + _mailSenderLabel.frame.size.height + 5, _bgImageView.frame.size.width, 12)];
    
    [_mailContentTextView setFrame:CGRectMake(16, _mailDateLabel.frame.origin.y + _mailDateLabel.frame.size.height + 30, _bgImageView.frame.size.width - 32, _bgImageView.frame.size.height - (_mailDateLabel.frame.origin.y + _mailDateLabel.frame.size.height + 30) )];
    
    _mailHorizontalLineView.frame = CGRectMake(16, _mailDateLabel.frame.origin.y + _mailDateLabel.frame.size.height + 15, _bgImageView.frame.size.width - 16, 1.0);
}

- (void)initHorizontalFrame
{
    [super initHorizontalFrame];
    
    CGSize mailTitleLabelSize = [_mailTitleLabel.text sizeWithFont:[UIFont systemFontOfSize:30 * (1 / 2.0)]
                                                 constrainedToSize:CGSizeMake(_bgImageView.frame.size.width - 32, MAXFLOAT)
                                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    [_mailTitleLabel setFrame:CGRectMake(16, 65, _bgImageView.frame.size.width - 32, mailTitleLabelSize.height)];
    [_mailSenderLabel setFrame:CGRectMake(16, _mailTitleLabel.frame.origin.y + _mailTitleLabel.frame.size.height + 8, _bgImageView.frame.size.width, 13)];
    [_mailDateLabel setFrame:CGRectMake(16, _mailSenderLabel.frame.origin.y + _mailSenderLabel.frame.size.height + 5, _bgImageView.frame.size.width, 12)];
    
    [_mailContentTextView setFrame:CGRectMake(16, _mailDateLabel.frame.origin.y + _mailDateLabel.frame.size.height + 30, _bgImageView.frame.size.width - 32, _bgImageView.frame.size.height - (_mailDateLabel.frame.origin.y + _mailDateLabel.frame.size.height + 30) )];
    
    _mailHorizontalLineView.frame = CGRectMake(16, _mailDateLabel.frame.origin.y + _mailDateLabel.frame.size.height + 15, _bgImageView.frame.size.width - 16, 1.0);
}

-(void)showPPNoticeContentViewByRight
{
    if (_noticeType == PageTypeOfEmail) {
        [_titleLabel setText:@"邮件详情"];
    }
    else if (_noticeType == PageTypeOfNoti)
    {
        [_titleLabel setText:@"公告详情"];
    }
    [super showViewByRight];
}

-(void)showPPNoticeContentViewByLeft
{
    [super showViewByLeft];
}


-(void)backButtonPressed
{
    
    
    [[PPNoticeListView sharedInstance] showPPNoticeListViewByLeft];
    
    [[PPNoticeListView sharedInstance] setPageType:_noticeType];
    
    [self hiddenPPNoticeContentViewInRight];
}

-(void)hiddenPPNoticeContentViewInRight
{
    [super hiddenViewInRight];
}
- (void)hiddenPPNoticeContentViewInLeft
{
    [super hiddenViewInLeft];
}


-(void)didHiddenView
{
    [super didHiddenView];
}

-(void)didShowView{
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) dealloc
{
    NSLog(@"PPNoticeContentView--dealloc");
    
    [super dealloc];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context,  [PPCommon getColor:@"cccccc"].CGColor);
//    float rectY = _mailDateLabel.frame.origin.y + _mailDateLabel.frame.size.height + 14;
//    CGContextFillRect (context, CGRectMake (16, rectY, rect.size.width - 16, 1));
//    CGContextStrokePath(context);
//}


@end

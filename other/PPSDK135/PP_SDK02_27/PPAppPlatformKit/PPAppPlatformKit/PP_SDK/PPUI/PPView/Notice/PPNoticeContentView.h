//
//  PPMailContentView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-12-2.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPBaseView.h"
#import "PPNoticeListView.h"

@interface PPNoticeContentView : PPBaseView
{
    UIImageView *_mailHorizontalLineView;

}

@property (nonatomic,retain)UILabel *mailTitleLabel;
@property (nonatomic,retain)UILabel *mailSenderLabel;
@property (nonatomic,retain)UILabel *mailDateLabel;
@property (nonatomic,retain)UITextView *mailContentTextView;
@property (nonatomic,assign)PageType noticeType;

-(void)showPPNoticeContentViewByRight;
-(void)showPPNoticeContentViewByLeft;


@end

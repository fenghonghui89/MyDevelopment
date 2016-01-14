//
//  WeiboContentView.h
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-3.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboContentView : UIView
@property(nonatomic,retain)Weibo *weibo;
-(float)getWeiboContentViewHeight;
@end

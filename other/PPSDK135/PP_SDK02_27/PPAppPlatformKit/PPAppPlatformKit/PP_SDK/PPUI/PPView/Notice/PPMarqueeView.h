//
//  PPMarqueeView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-12-13.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPMarqueeView : UIView
{
    
    
    UILabel *_subLabel;
    
//    BOOL _isShow;
}
@property (nonatomic,retain)NSString *text;

@property (nonatomic,assign)BOOL isShow;

+ (PPMarqueeView *)sharedInstance;

- (void)showMarqueeView;

- (void)marqueeBeginScroll;

- (void)hiddenMarqueeView;

@end

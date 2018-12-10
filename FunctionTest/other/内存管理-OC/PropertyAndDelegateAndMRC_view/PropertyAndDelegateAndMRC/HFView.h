//
//  HFView.h
//  PropertyAndDelegateAndMRC
//
//  Created by hanyfeng on 14-4-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFView;
@protocol HFViewDelegate <NSObject>
@optional
-(void)view:(HFView *)view AndText:(NSString *)text;
@end

@interface HFView : UIView
@property(nonatomic,assign)id<HFViewDelegate> delegate;
@end

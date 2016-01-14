//
//  UIImageView+ForScrollView.m
//  PPAppPlatformKit
//
//  Created by seven  mr on 2/20/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "UIImageView+ForScrollView.h"

#define noDisableVerticalScrollTag 836913
#define noDisableHorizontalScrollTag 836914

@implementation UIImageView (ForScrollView)



//[userNameTableView flashScrollIndicators];这个方法滚动时候调用下方法。这样实现一直显示滚动条
- (void) setAlpha:(float)alpha {

    if (self.superview.tag == noDisableVerticalScrollTag) {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleLeftMargin) {
            if (self.frame.size.width < 10 && self.frame.size.height > self.frame.size.width) {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.height < sc.contentSize.height) {
                    return;
                }
            }
        }
    }

    if (self.superview.tag == noDisableHorizontalScrollTag) {
        if (alpha == 0 && self.autoresizingMask == UIViewAutoresizingFlexibleTopMargin) {
            if (self.frame.size.height < 10 && self.frame.size.height < self.frame.size.width) {
                UIScrollView *sc = (UIScrollView*)self.superview;
                if (sc.frame.size.width < sc.contentSize.width) {
                    return;
                }
            }
        }
    }

    [super setAlpha:alpha];
}

@end
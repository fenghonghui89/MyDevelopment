//
//  XHZoomDrawerView.m
//  XHDrawerController
//
//  Created by 曾 宪华 on 13-12-27.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "XHZoomDrawerView.h"
#import "XHDrawerControllerHeader.h"

@implementation XHZoomDrawerView

#pragma mark - UIView Overrides

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //scrollview
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.scrollsToTop = NO;
        self.scrollView.scrollEnabled = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.contentSize = CGSizeMake((CGRectGetWidth(frame) + XHContentContainerViewOriginX * 2), CGRectGetHeight(frame));
        [self.scrollView setContentOffset:CGPointMake(XHContentContainerViewOriginX, 0.0f) animated:NO];
        [self addSubview:self.scrollView];
        NSLog(@"scrollview.contentoffset:%@",NSStringFromCGPoint(_scrollView.contentOffset));
        
        //左边内容
        _leftContainerView = [[UIView alloc] initWithFrame:self.bounds];
        NSLog(@"left:%@",NSStringFromCGRect(_leftContainerView.frame));
        [self.scrollView addSubview:self.leftContainerView];
        
        //中间内容及中间按钮（可选，不设置则弹出左右菜单后不能直接点击中间内容返回）
        _contentContainerView = [[UIView alloc] initWithFrame:self.bounds];
        xh_UIViewSetFrameOriginX(self.contentContainerView, XHContentContainerViewOriginX);
        [self.scrollView addSubview:self.contentContainerView];
        NSLog(@"content:%@",NSStringFromCGRect(self.contentContainerView.frame));
        
        _contentContainerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.contentContainerButton.frame = self.contentContainerView.bounds;
        [self.contentContainerView addSubview:self.contentContainerButton];
        NSLog(@"button:%@",NSStringFromCGRect(_contentContainerButton.frame));
        
        //右边内容
        _rightContainerView = [[UIView alloc] initWithFrame:self.bounds];
        xh_UIViewSetFrameOriginX(self.rightContainerView, CGRectGetWidth(self.contentContainerView.frame) + XHContentContainerViewOriginX);
        [self.scrollView addSubview:self.rightContainerView];
        NSLog(@"right:%@",NSStringFromCGRect(_rightContainerView.frame));
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //显示中间内容
    self.backgroundView.frame = self.bounds;
    [self.contentContainerView bringSubviewToFront:self.contentContainerButton];
}

#pragma mark - Accessors（backgroundView的set方法）
- (void)setBackgroundView:(UIView *)backgroundView {
    [self.backgroundView removeFromSuperview];
    _backgroundView = backgroundView;
    [self insertSubview:self.backgroundView atIndex:0];
}

@end

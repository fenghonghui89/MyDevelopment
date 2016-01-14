//
//  PPRefreshFootMoreView.h
//  tabledemo
//
//  Created by Seven on 13-10-25.
//  Copyright (c) 2013年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPRefreshFootMoreView : UIView<UIScrollViewDelegate>
{
}

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UILabel *infoLabel;
@property (nonatomic) BOOL canLoadMore;
@property (nonatomic) BOOL isDragging;
@property (nonatomic, retain) UIScrollView *scrollView;
@end

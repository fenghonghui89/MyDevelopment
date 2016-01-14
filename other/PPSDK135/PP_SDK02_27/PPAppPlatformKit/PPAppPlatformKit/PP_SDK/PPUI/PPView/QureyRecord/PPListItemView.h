//
//  PPListItemView.h
//  ListViewTest
//
//  Created by Seven on 13-10-17.
//  Copyright (c) 2013年 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPListItemViewDelegate;

@interface PPListItemView : UIView

@property (nonatomic,retain)UIImageView *itemStateImageView;//item标识是否选中的imageView
@property (nonatomic,retain)UIImageView *dashlineView;
@property (nonatomic,retain)UIButton *itemButton;//item的button
@property (nonatomic,assign)int itemIndex;//item在整个list中的位置
@property (nonatomic,assign)BOOL isSelected;//item是否被选中


//@property (nonatomic,retain)UIImage *itemImage;

@property(nonatomic, assign) id<PPListItemViewDelegate> delegate;

- (PPListItemView *)initWithButtonTitle:(NSString *)title itemFrame:(CGRect)frame;


//将item设为选中状态
- (void)setSelectedState;

//取消item的选中状态
- (void)cancelSelectedState;

@end


@protocol PPListItemViewDelegate <NSObject>
@required
- (void)listItemView:(PPListItemView *)view selectedIndex:(NSInteger)index withInfo:(NSDictionary *)info;
@end
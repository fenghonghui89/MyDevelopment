//
//  PPDropDownView.h
//  ListViewTest
//
//  Created by Seven on 13-10-17.
//  Copyright (c) 2013年 1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPListItemView.h"

@protocol PPDropDownViewDelegate;


@interface PPDropDownView : UIView<PPListItemViewDelegate>


@property(nonatomic,retain) NSMutableArray *items;
@property(nonatomic,retain) PPListItemView *selectedItem;
@property(nonatomic,assign) int countOfItems;
@property(nonatomic,assign) int selectedIndex;

@property(nonatomic, assign) id<PPDropDownViewDelegate> delegate;

@property(nonatomic,assign) BOOL isOpen;



- (NSInteger)addItemWithButtonTitle:(NSString *)title itemFrame:(CGRect)frame;


- (void)openView;
- (int)closeView;
- (void)selectItem:(int)index;

@end

@protocol PPDropDownViewDelegate <NSObject>
@required

-(void)dropDownView:(PPDropDownView *)view selectedIndex:(NSInteger)index withInfo:(NSDictionary *)info;

@end



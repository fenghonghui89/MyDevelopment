//
//  XTJNavigationBar1.h
//  XTJMall
//
//  Created by hanyfeng on 2017/6/12.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XTJRootDefine.h"



@interface XTJNavigationItem_Main : UIView

//公共
@property(nonatomic,copy)NSString *title;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *left0Btn;
@property (weak, nonatomic) IBOutlet UIButton *right0Btn;
@property (weak, nonatomic) IBOutlet UIButton *right1Btn;
@property (weak, nonatomic) IBOutlet UIButton *right2Btn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property(nonatomic,copy)dispatch_block_t leftBarButton0Handler;
@property(nonatomic,copy)dispatch_block_t rightBarButton1Handler;
@property(nonatomic,copy)dispatch_block_t rightBarButton2Handler;
@property(nonatomic,copy)dispatch_block_t rightBarButton0Handler;

@end

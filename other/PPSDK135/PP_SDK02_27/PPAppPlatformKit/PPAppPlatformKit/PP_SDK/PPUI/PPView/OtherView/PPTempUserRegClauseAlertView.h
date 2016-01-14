//
//  PPTempUserRegClauseAlertView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-4-24.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPHyperlinkLabel.h"

@class PPTempUserRegClauseAlertView;
@protocol PPTempUserRegClauseAlertViewDelegate <NSObject>
@required
- (void)didClickButton:(UIButton *)sender;
@end

/**
 *  零时用户提示UI （过期）
 */
@interface PPTempUserRegClauseAlertView : UIView<PPHyperlinkLabelDelegate>
{
    UIView *AlertViewSuperView;
    UIView *AlertView;
	UIWindow *TempFullscreenWindow;
    UIView *grayView;
    UIButton *cancelButton;
    UIButton *OKButton;
    UILabel *titleLabel;
    UITextView*textClauseScrollView;
    UIButton *agreeClauseButton;
    PPHyperlinkLabel *agreeClauseLabel;
    BOOL isAgreeClause;
    id <PPTempUserRegClauseAlertViewDelegate> delegate;
}
@property (nonatomic, assign) id <PPTempUserRegClauseAlertViewDelegate> delegate;


- (int)showModel;
@end

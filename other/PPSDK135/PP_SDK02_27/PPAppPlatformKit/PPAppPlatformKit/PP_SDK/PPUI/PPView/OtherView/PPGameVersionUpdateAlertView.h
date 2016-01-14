//
//  PPGameVersionUpdateAlertView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-7-5.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPHyperlinkLabel.h"
#import "PPMBProgressHUD.h"
#import "PPGameVersion.h"


@class PPGameVersionUpdateAlertView;
@protocol PPGameVersionUpdateAlertViewDelegate <NSObject,UIAlertViewDelegate>
@required
- (void)didClickButton:(UIButton *)sender;
@end
/**
 *  版本更新 （有新的版本更新 提示）
 */
@interface PPGameVersionUpdateAlertView : UIView
<
PPHyperlinkLabelDelegate
>
{
    UIView *AlertViewSuperView;
    UIView *AlertView;
	UIWindow *TempFullscreenWindow;
    UIView *grayView;
    UIButton *cancelButton;
    UIButton *OKButton;
    UILabel *titleLabel;
    UITextView *textUpdateScrollView;
    UIButton *ignoreUpdateButton;
    NSString *downloadUrl;
    PPHyperlinkLabel *ignoreUpdateLabel;
    BOOL isIgnoreUpdate;
    BOOL isForce;
    NSString *newestVersion;
    NSMutableData *recvData;
    id <PPGameVersionUpdateAlertViewDelegate> delegate;
    UIInterfaceOrientation paramInterfaceOrientation;
    PPMBProgressHUD *ppMBProgress;
    PPGameVersion *_gameVersion;
}
@property (nonatomic, assign) id <PPGameVersionUpdateAlertViewDelegate> delegate;


- (int)showModel;
//- (id)initWithForce:(BOOL)paramForce UpdateDescribeList:(NSDictionary *)paramUpdateDescribeList DownloadUrl:(NSString *)paramDownloadUrl
//      NewestVersion:(NSString *)paramNewestVersion;

- (id)initWithGameVersion:(PPGameVersion *)gameVersion;
@end
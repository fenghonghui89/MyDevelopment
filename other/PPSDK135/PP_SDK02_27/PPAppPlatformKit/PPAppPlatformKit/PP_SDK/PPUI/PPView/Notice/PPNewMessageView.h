//
//  PPLoginSucceedNotiView.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-4-17.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPBaseView.h"

@interface PPNewMessageView : UIImageView
{
    UIImageView *ppLogoImageView;
    UILabel *userNameLabel;
    BOOL isShow;
}

+ (PPNewMessageView *)sharedInstance;
-(void)showNotiView;
@end



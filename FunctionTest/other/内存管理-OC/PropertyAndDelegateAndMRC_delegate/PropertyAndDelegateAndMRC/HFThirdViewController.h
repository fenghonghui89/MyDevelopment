//
//  HFThirdViewController.h
//  PropertyAndDelegateAndMRC
//
//  Created by hanyfeng on 14-4-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFThirdViewController;
@protocol HFThirdViewControllerDelegate <NSObject>
@optional
-(void)thirdViewController:(HFThirdViewController *)thirdViewController AndText:(NSString *)text;
@end

@interface HFThirdViewController : UIViewController
@property(nonatomic,assign)id<HFThirdViewControllerDelegate> delegate;
@end

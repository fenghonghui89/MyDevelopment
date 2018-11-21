//
//  PresentedViewController.h
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/9/30.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "BaseViewController.h"

@class PresentedViewController;
@protocol PresentedVCDelegate <NSObject>

-(void)didPresentedVC:(PresentedViewController *)viewcontroller;

@end

@interface PresentedViewController : BaseViewController
@property(nonatomic,weak) id<PresentedVCDelegate>delegate;
@end


//
//  PanInteractiveTransition.h
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/21.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//手势dismiss 会跟自定义dismiss冲突 只能二选一

#import <UIKit/UIKit.h>

@interface PanInteractiveTransition : UIPercentDrivenInteractiveTransition
@property(nonatomic,assign)BOOL interacting;
-(void)panToDismiss:(UIViewController *)viewcontroller;
@end


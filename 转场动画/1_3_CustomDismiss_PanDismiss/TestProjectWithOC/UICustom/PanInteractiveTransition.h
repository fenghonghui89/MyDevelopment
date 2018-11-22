//
//  PanInteractiveTransition.h
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/21.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//手势dismiss

#import <UIKit/UIKit.h>

@interface PanInteractiveTransition : UIPercentDrivenInteractiveTransition
//@property(nonatomic,assign)BOOL interacting;//不需要？
-(void)panToDismiss:(UIViewController *)viewcontroller;
@end


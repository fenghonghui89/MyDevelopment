//
//  PanInteractiveTransition.h
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/27.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface PanInteractiveTransition : UIPercentDrivenInteractiveTransition
-(void)panToPop:(UIViewController *)viewcontroller;
@property(nonatomic,assign)BOOL interacting;//供vc判断要返回nil还是对象
@end

NS_ASSUME_NONNULL_END

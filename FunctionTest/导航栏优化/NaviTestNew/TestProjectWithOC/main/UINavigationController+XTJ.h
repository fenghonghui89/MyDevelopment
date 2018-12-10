//
//  UINavigationController+XTJ.h
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/11/1.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (XTJ)
//右滑退出开关
-(void)configSwipeRight:(BOOL)isNeed;

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated isNeedLogin:(BOOL)isNeedLogin;
//-(instancetype)xa_initWithRootViewController:(UIViewController *)rootViewController;
@end

NS_ASSUME_NONNULL_END

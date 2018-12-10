//
//  BJNavigationController+Test.h
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/16.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "BJNavigationController.h"

@interface BJNavigationController (Test)<UIGestureRecognizerDelegate>

/**
 当前手势是否正在滑动转场中
 */
@property(nonatomic,assign,getter=xa_isGrTransitioning)BOOL xa_grTransitioning;


- (void)xa_changeNavBarAlpha:(CGFloat)navBarAlpha;

@end

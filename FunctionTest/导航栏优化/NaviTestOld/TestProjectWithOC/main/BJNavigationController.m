//
//  BJNavigationController.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/16.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "BJNavigationController.h"

@interface BJNavigationController ()

@end

@implementation BJNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self configSwipeRight:YES];
    }
    return self;
}

//右滑退出开关
-(void)configSwipeRight:(BOOL)isNeed{
    
    // 使右滑返回手势可用
    if (isNeed) {
        [self setNavigationBarHidden:NO animated:NO];
    }else{
        [self setNavigationBarHidden:YES animated:NO];
        
    }

}

@end

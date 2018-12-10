//
//  BJBaseNavigationController.m
//  NaviTest2
//
//  Created by hanyfeng on 2018/11/9.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "BJBaseNavigationController.h"
#import "XANavBarTransition.h"
#import "XTJRootDefine.h"
@interface BJBaseNavigationController ()

@end

@implementation BJBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化导航栏
    self.navigationBar.translucent  = NO;//全透明(无毛玻璃效果)
    self.navigationBar.barTintColor = HexColor(@"934d91");
    
    //去掉底部细线
    self.navigationBar.shadowImage  = [UIImage new];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

}



@end

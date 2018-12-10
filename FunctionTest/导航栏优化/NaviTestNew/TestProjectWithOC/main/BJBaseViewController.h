//
//  BJBaseViewController.h
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/16.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTJRootDefine.h"
#import "UINavigationController+XTJ.h"
#import "UIViewController+XANavBarTransition.h"
@interface BJBaseViewController : UIViewController

-(void)customInit;
-(void)customInitNavigationBar;
-(void)customInitView;
@end

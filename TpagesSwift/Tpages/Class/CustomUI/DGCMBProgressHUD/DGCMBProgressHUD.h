//
//  DGCMBProgressHUD.h
//  uitest
//
//  Created by hanyfeng on 15/11/17.
//  Copyright © 2015年 MD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGCMBProgressHUD : UIView
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;
+ (DGCMBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated type:(NSInteger)type block:(void(^)(void))block;
@end

//
//  MDClassesViewController.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDClassesViewController : UIViewController

@property(nonatomic,strong)NSArray *data;

/**
 *  是否最后一层
 */
@property(nonatomic,assign)BOOL isLastsetLayer;
@end

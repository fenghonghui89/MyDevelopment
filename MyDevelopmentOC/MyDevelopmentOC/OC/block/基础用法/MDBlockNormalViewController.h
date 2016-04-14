//
//  MDBlockNormalViewController.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/4/1.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDBaseViewController.h"



typedef void (^MDBlockNormalViewControllerBlock)(BOOL b);

typedef void (^retryblock)(BOOL b);
typedef void (^MDBlockNormalViewControllerRetryBlock)(BOOL a,retryblock reb);//把retryblock放到外面定义





@class MDBlockNormalViewController;
@protocol MDBlockDelegate <NSObject>

@optional
-(void)blockDelegate:(MDBlockNormalViewController *)vc block:(MDBlockNormalViewControllerBlock)block;

@end





@interface MDBlockNormalViewController : MDBaseViewController
@property(nonatomic,copy)MDBlockNormalViewControllerBlock block;//block做属性
@property(nonatomic,weak)id<MDBlockDelegate> delegate;

-(void)retryBlockMethod:(MDBlockNormalViewControllerRetryBlock)block;
@end

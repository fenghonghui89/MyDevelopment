//
//  HFAppDelegate.h
//  KVO_KVC
//
//  Created by hanyfeng on 14-5-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFPerson.h"
#import "HFObserver.h"
@interface HFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSString *appStatus;
@property(nonatomic,strong)HFPerson *person;
@property(nonatomic,strong)HFObserver *observer;
@end

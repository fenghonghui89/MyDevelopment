//
//  TRViewController.h
//  Day7PlayMusic
//
//  Created by Tarena on 13-12-10.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TRAppDelegate.h"
@interface TRViewController : UIViewController

@property (nonatomic, weak)TRAppDelegate *app;//通过属性取得该项目下AppDelegate对象
@property (nonatomic, strong)NSMutableArray *musicPaths;
@property (nonatomic)int index;

@end
